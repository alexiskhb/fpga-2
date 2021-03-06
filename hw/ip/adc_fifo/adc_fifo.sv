`timescale 1 ps / 1 ps

module adc_fifo (
        input wire                 clk,
        input wire                 reset,
        output reg         [15:0]  fifo_in_data,
        output reg                 fifo_in_valid,

        output reg         [31:0]  fifo_csr_address,
        output reg                 fifo_csr_read,
        input wire         [31:0]  fifo_csr_readdata,
        input wire                 fifo_csr_waitrequest,
        output reg                 fifo_csr_write,
        output reg         [31:0]  fifo_csr_writedata,

        input wire                 dma_address,
        input wire                 dma_chipselect,
        input wire                 dma_read,
        output reg         [15:0]  dma_readdata,
        output reg                 dma_readdatavalid,
        output reg                 dma_waitrequest,

        input wire                 dsp_ss_valid,
        input wire         [31:0]  dsp_ss_data,

        input wire         [15:0]  fifo_out_data,
        input wire         [7:0]   fifo_out_channel,
        input wire         [7:0]   fifo_out_error,
        input wire                 fifo_out_valid,
        output reg                 fifo_out_ready,

        input wire         [15:0]  adc_data,
        input wire                 adc_valid,
        input wire         [2:0]   adc_channel,

        output reg                 irq,

        output reg         [31:0]  X,
        output reg                 next_in,

        input wire         [63:0]  Y,
        input wire                 next_out,

        input wire                 sqrt_busy,
        input wire         [15:0]  sqrt_result,

        output reg                 sqrt_start,
        output reg         [31:0]  sqrt_value,

        output reg         [15:0]  data_cntrl_data,
        output reg                 data_cntrl_valid,
        output reg         [2:0]   data_cntrl_channel,

        input wire         [31:0]  fft_fifo0_out_data,
        input wire         [7:0]   fft_fifo0_out_channel,
        input wire         [7:0]   fft_fifo0_out_error,
        input wire                 fft_fifo0_out_valid,
        output reg                 fft_fifo0_out_ready,

        input wire         [31:0]  fft_fifo1_out_data,
        input wire         [7:0]   fft_fifo1_out_channel,
        input wire         [7:0]   fft_fifo1_out_error,
        input wire                 fft_fifo1_out_valid,
        output reg                 fft_fifo1_out_ready,

        input wire         [31:0]  fft_fifo2_out_data,
        input wire         [7:0]   fft_fifo2_out_channel,
        input wire         [7:0]   fft_fifo2_out_error,
        input wire                 fft_fifo2_out_valid,
        output reg                 fft_fifo2_out_ready,

        input  wire        [7:0]   slave_address,
        input  wire                slave_read,
        output reg         [31:0]  slave_readdata,
        input  wire                slave_write,
        input  wire        [31:0]  slave_writedata,
        input  wire                slave_chipselect,

        output reg                 pinger_sim_next_channel,
        input wire         [15:0]  pinger_sim_value,


        output reg         [7:0]   pinger_param_channel,
        output reg         [31:0]  pinger_param_data

    );

    reg [31:0] flag_in;
    reg [31:0] flag_out;

    reg [31:0] cntr_in;
    reg [31:0] cntr_out;
    reg [7:0] state;
    reg [7:0] state_after_pause;
    reg [7:0] state_fft;

    reg [3:0] pause_cntr;

    parameter WAIT     = 8'd0
            , FILL      = 8'd1
            , FULL      = 8'd2
            , POP       = 8'd3
            , PUSH      = 8'd4
            , SETUP_DMA = 8'd5
            , TO_DMA    = 8'd6
            , PAUSE     = 8'd7
            , END       = 8'd8
            , FFT_IN1   = 8'd9
            , FFT_OUT1   = 8'd10
            , GET_OUT1  = 8'd11
            , CALC_MEAN = 8'd12
            , WAIT_SQRT = 8'd13
            , SQRT_COMPONENT = 8'd14
            , COMPARE = 8'd15
            , FFT_END = 8'd16
            , DOWN_START = 8'd17
            , DOWN_START_2 = 8'd18
            , WAIT_END = 8'd19

            , DMA_EVENT = 32'd123
            , SIZE_FIFO = 32'd3072
            , FFT_SIZE  = 32'd256
            , FFT_HALF_SIZE  = 32'd128
            , MEAN_SIZE = 32'd16
            , WAIT_DELAY = 32'd6300000

            , MEM_FREQ = 8'd0
            , MEM_TRESHOLD = 8'd4

            , MEM_SIM_DELAY_1 = 8'd8
            , MEM_SIM_DELAY_2 = 8'd12
            , MEM_SIM_DELAY_3 = 8'd16
            , MEM_SIM_PHASE_INC = 8'd20
            , MEM_SIM_FLAG = 8'd24
            , MEM_SIM_PING_TIME = 8'd28
            , MEM_SIM_WAIT_TIME = 8'd32;
            

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            cntr_in <= 0;
        end else begin
            if (cntr_in < SIZE_FIFO && state == FILL && adc_valid == 1'b1) begin
                cntr_in <= cntr_in + 1;
            end else if (state == END) begin
                cntr_in <= 0;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            cntr_out <= SIZE_FIFO;
        end else begin
            if (cntr_out > 0 && state == TO_DMA) begin
                cntr_out <= cntr_out - 1;
            end else if (state == END) begin
                cntr_out <= SIZE_FIFO;
            end
        end
    end

    wire dma_event;
    assign dma_event = (dsp_ss_valid == 1'b1 && dsp_ss_data == DMA_EVENT) ? 1'b1 : 1'b0;

    reg [2:0] adc_prev_channel;
    reg [31:0]  in_cntr [2:0];
    reg [2:0]   index [2:0];
    reg [2:0]   current_index;
    reg [2:0]   fft_good;

    reg signed [31:0] fft_real_out [16:0];
    reg signed [31:0] fft_imag_out [16:0];

    reg signed [31:0] fft_real_component;
    reg signed [31:0] fft_imag_component;

    reg [31:0] fft_cntr;
    reg [31:0] mean_sum;

    reg [15:0] treshold;
    reg [15:0] index_fft;
    reg [15:0] module_fft;


    reg [15:0] freq_param;
    reg [15:0] module_param;
    reg [15:0] treshold_param;

    reg free_fft;

    reg [15:0] sqrt_component_tmp;
    reg [31:0] mean_shifted_tmp;

    reg [31:0] fft_tmp_real;
    reg [31:0] fft_tmp_imag;
    
    reg [31:0] mean_cntr;
    reg [31:0] cntr_wait;

    reg        state_setup_flag;
    reg        changed_param;
    reg        reset_changed_param;

    reg        simulation;
    reg        pinger_sim_next_channel_changed;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            fft_cntr <= 0;
        end else begin
            if (fft_cntr <  FFT_HALF_SIZE && (state_fft == FFT_IN1 || state_fft == GET_OUT1)) begin
                fft_cntr <= fft_cntr + 1;
            end else if (state_fft == FFT_OUT1 || state_fft == CALC_MEAN) begin
                fft_cntr <= 0;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            mean_cntr <= 0;
        end else begin
            if (mean_cntr <  MEAN_SIZE && state_fft == CALC_MEAN) begin
                mean_cntr <= mean_cntr + 1;
            end else if (state_fft == WAIT) begin
                mean_cntr <= 0;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            cntr_wait <= 0;
        end else begin
            if (cntr_wait <= WAIT_DELAY && state == WAIT_END) begin
                cntr_wait <= cntr_wait + 1;
            end else begin
                cntr_wait <= 0;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            state_fft <= WAIT;
            mean_sum <= 0;
            fft_good <= 3'd0;
            treshold <= 15'd10;
            index_fft <= 15'd24;
            module_fft <= 15'd0;
            reset_changed_param <= 0;
        end else begin
            if (state == SETUP_DMA && state_setup_flag == 0) begin
                state_setup_flag <= 1'b1;
            end else if (state_setup_flag == 1 && state_fft != FFT_IN1) begin
                state_fft <= WAIT;
                mean_sum <= 0;
                fft_good <= 3'd0;
                next_in <= 0;
                state_setup_flag <= 0;
            end
            case (state_fft)
                WAIT:
                    begin
                        if (changed_param == 1) begin
                            treshold <= treshold_param;
                            index_fft <= freq_param;
                            module_fft <= module_param;
                            fft_good <= 3'd0;
                            reset_changed_param <= 1;
                        end else begin
                            reset_changed_param <= 0;
                            if (in_cntr[0] >= FFT_SIZE) begin
                                current_index <= 0;
                                fft_fifo0_out_ready <= 1'b1;
                            end else if (in_cntr[1] >= FFT_SIZE) begin
                                current_index <= 1;
                                fft_fifo1_out_ready <= 1'b1;
                            end else if (in_cntr[2] >= FFT_SIZE) begin
                                current_index <= 2;
                                fft_fifo2_out_ready <= 1'b1;
                            end
                            if (in_cntr[0] >= FFT_SIZE || in_cntr[1] >= FFT_SIZE || in_cntr[2] >= FFT_SIZE) begin
                                mean_sum <= 0;
                                next_in <= 1;
                                state_fft <= FFT_IN1;
                            end
                        end
                    end
                FFT_IN1:
                    begin
                        next_in <= 0;
                        if (fft_cntr < FFT_HALF_SIZE) begin
                            if (current_index == 0) begin
                                X <= fft_fifo0_out_data;    
                            end else if (current_index == 1) begin
                                X <= fft_fifo1_out_data;
                            end else if (current_index == 2) begin
                                X <= fft_fifo2_out_data;
                            end                            
                        end else begin
                            fft_fifo0_out_ready <= 1'b0;
                            fft_fifo1_out_ready <= 1'b0;
                            fft_fifo2_out_ready <= 1'b0;
                            state_fft <= FFT_OUT1;
                        end
                    end
                FFT_OUT1:
                    if (next_out == 1) begin
                        state_fft <= GET_OUT1;
                    end
                GET_OUT1:                    
                    if (fft_cntr >= 5 && fft_cntr <= 12) begin
                        fft_real_out[(fft_cntr - 5) * 2] <= $signed({ Y[63:48], 16'd0 }) >>> 16;
                        fft_imag_out[(fft_cntr - 5) * 2] <= $signed({ Y[47:32], 16'd0 }) >>> 16;
                        fft_real_out[(fft_cntr - 5) * 2 + 1] <= $signed({ Y[31:16], 16'd0 }) >>> 16;
                        fft_imag_out[(fft_cntr - 5) * 2 + 1] <= $signed({ Y[15:0], 16'd0 }) >>> 16;
                    end else if (fft_cntr == index_fft) begin
                        if (module_fft == 0) begin
                            fft_real_component <= $signed({ Y[63:48], 16'd0 }) >>> 16;
                            fft_imag_component <= $signed({ Y[47:32], 16'd0 }) >>> 16;    
                        end else if (module_fft == 1) begin
                            fft_real_component <= $signed({ Y[31:16], 16'd0 }) >>> 16;
                            fft_imag_component <= $signed({ Y[15:0], 16'd0 }) >>> 16;    
                        end
                    end else if (fft_cntr > index_fft) begin 
                        state_fft <= CALC_MEAN;
                    end                    
                CALC_MEAN:
                    begin
                        if (mean_cntr < MEAN_SIZE) begin
                            sqrt_value <= fft_real_out[mean_cntr] * fft_real_out[mean_cntr] + fft_imag_out[mean_cntr] * fft_imag_out[mean_cntr];
                            sqrt_start <= 1'b1;
                            state_fft <= DOWN_START;
                        end else begin
                            state_fft <= SQRT_COMPONENT;
                        end
                    end
                DOWN_START:
                    begin
                        sqrt_start <= 1'b0;
                        state_fft <= WAIT_SQRT;
                    end
                WAIT_SQRT:
                    begin
                        if (sqrt_busy == 0) begin
                            fft_tmp_real <= fft_real_out[mean_cntr - 1];
                            fft_tmp_imag <= fft_imag_out[mean_cntr - 1];
                            X <= fft_tmp_real;
                            sqrt_value <= fft_tmp_imag;
                            mean_sum <= mean_sum + sqrt_result;
                            state_fft <= CALC_MEAN;
                        end
                    end
                SQRT_COMPONENT:
                    begin
                        sqrt_start <= 1'b1;
                        sqrt_value <= fft_real_component * fft_real_component + fft_imag_component * fft_imag_component;
                        state_fft <= DOWN_START_2;
                    end
                DOWN_START_2:
                    begin
                        sqrt_start <= 1'b0;
                        state_fft <= COMPARE;
                    end
                COMPARE:
                    begin
                        if (sqrt_busy == 0) begin
                            sqrt_component_tmp <= sqrt_result;
                            mean_shifted_tmp <= mean_sum >> 4;
                            X <= mean_shifted_tmp;
                            sqrt_value <= sqrt_component_tmp;
                            if ((mean_sum >> 4) != 32'd0 && sqrt_result > treshold * (mean_sum >> 4)) begin
                                fft_good[current_index] <= 1'b1;
                            end else begin
                                fft_good[current_index] <= 1'b0;
                            end
                            state_fft <= WAIT;
                        end
                    end
            endcase            
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            state                           <= FILL;
            fifo_csr_address                <= 4;
            fifo_csr_writedata              <= SIZE_FIFO;
            fifo_csr_write                  <= 1'b1;
            fifo_in_data                    <= 0;
            fifo_in_valid                   <= 0;
            dma_readdatavalid               <= 1'b0;
            dma_waitrequest                 <= 1'b0;
            pause_cntr                      <= 4'd0;
            adc_prev_channel                <= 3'd0;
            index[0]                        <= 2;
            index[1]                        <= 0;
            index[2]                        <= 1;
        end else begin
            adc_prev_channel <= adc_channel;    
            if (state_fft == FFT_OUT1) begin
                in_cntr[current_index] <= 0;
            end
            case (state)
                FILL:
                    if (cntr_in < SIZE_FIFO && adc_valid == 1'b0) begin
                        fifo_in_valid <= 1'b0;
                    end else if (cntr_in < SIZE_FIFO && adc_valid == 1'b1) begin
                        fifo_in_valid <= 1'b1;
                        if (simulation == 1) begin
                            fifo_in_data <= pinger_sim_value;
                        end else begin
                            fifo_in_data <= adc_data;
                        end
                        state <= PAUSE;
                        state_after_pause <= FILL;
                    end else if (cntr_in >= SIZE_FIFO) begin
                        fifo_in_valid <= 1'b0;
                        state <= FULL;
                    end
                FULL:
                    begin
                        fifo_in_valid <= 1'b0;
                        if (fft_good == 3'b111 && adc_channel == 1 && adc_prev_channel == 1) begin
                            state <= SETUP_DMA;
                            irq <= 1'b1;
                        end else if (adc_valid == 1'b1) begin
                            state  <= POP;
                        end
                    end
                POP:
                    begin
                        fifo_out_ready <= 1'b1;
                        state <= PUSH;
                    end
                PUSH:
                    begin
                        in_cntr[index[adc_channel - 1]] <= in_cntr[index[adc_channel - 1]] + 1;
                        data_cntrl_channel <= index[adc_channel - 1];
                        data_cntrl_valid <= 1'b1;
                        if (simulation == 1) begin
                            data_cntrl_data <= pinger_sim_value;                        
                            fifo_in_data <= pinger_sim_value;
                        end else begin
                            data_cntrl_data <= adc_data;                        
                            fifo_in_data <= adc_data;
                        end
                        fifo_out_ready <= 1'b0;
                        fifo_in_valid <= 1'b1;
                        state <= PAUSE;
                        state_after_pause <= FULL;
                    end
                SETUP_DMA:
                    begin
                        if (fifo_out_valid == 1'b1 && dma_chipselect == 1'b1) begin
                            irq <= 1'b0;
                            fifo_out_ready <= 1'b1;
                            state <= TO_DMA;
                        end
                    end
                TO_DMA:
                    if (cntr_out > 32'd0) begin
                        dma_readdatavalid <= 1'b1;
                        dma_readdata <= fifo_out_data;
                    end else begin
                        fifo_out_ready <= 1'b0;
                        dma_readdatavalid <= 1'b0;
                        state <= END;
                    end
                PAUSE:
                    begin
                        data_cntrl_valid <= 1'b0;
                        fifo_in_valid <= 1'b0;
                        if (pause_cntr >= 4'd7) begin
                            pause_cntr <= 4'd0;
                            state <= state_after_pause;
                        end else begin
                            pause_cntr <= pause_cntr + 1;
                        end
                    end
                END:
                    begin
                        in_cntr[0] <= 32'd0;
                        in_cntr[1] <= 32'd0;
                        in_cntr[2] <= 32'd0;
                        pause_cntr <= 0;
                        adc_prev_channel <= 0;
                        state <= WAIT_END;
                    end
                WAIT_END:
                    begin
                        if (cntr_wait > WAIT_DELAY) begin
                            state <= FILL;
                        end
                    end
            endcase
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if(reset) begin
            pinger_sim_next_channel <= 1'b0;
            pinger_sim_next_channel_changed <= 1'b0;
        end else begin
            if (adc_valid == 1'b1 && pinger_sim_next_channel_changed == 1'b0) begin
                pinger_sim_next_channel <= 1'b1;
                pinger_sim_next_channel_changed <= 1'b1;
            end else begin
                pinger_sim_next_channel <= 1'b0;
                if (adc_valid == 1'b0) begin
                    pinger_sim_next_channel_changed <= 1'b0;
                end
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if(reset) begin
            freq_param <= 24;
            module_param <= 0;
            treshold_param <= 10;
            changed_param <= 0;
            simulation <= 0;
        end else begin            
            if (reset_changed_param == 1) begin
                changed_param <= 0;
            end else 
            if (slave_chipselect) begin
                if (slave_write) begin
                    case(slave_address)
                        MEM_FREQ:
                            begin
                                freq_param <= slave_writedata[31:16];
                                module_param <= slave_writedata[15:0];
                                changed_param <= 1;
                            end
                        MEM_TRESHOLD:
                            begin
                                treshold_param <= slave_writedata[15:0];
                                changed_param <= 1;
                            end
                        MEM_SIM_FLAG:
                            begin
                                simulation <= slave_writedata[0];
                            end
                        MEM_SIM_DELAY_1:
                            begin
                                pinger_param_channel <= MEM_SIM_DELAY_1;
                                pinger_param_data <= slave_writedata;
                            end
                        MEM_SIM_DELAY_2:
                            begin
                                pinger_param_channel <= MEM_SIM_DELAY_2;
                                pinger_param_data <= slave_writedata; 
                            end
                        MEM_SIM_DELAY_3:
                            begin
                                pinger_param_channel <= MEM_SIM_DELAY_3;
                                pinger_param_data <= slave_writedata;
                            end
                        MEM_SIM_PHASE_INC:
                            begin
                                pinger_param_channel <= MEM_SIM_PHASE_INC;
                                pinger_param_data <= slave_writedata; 
                            end
                        MEM_SIM_PING_TIME:
                            begin
                                pinger_param_channel <= MEM_SIM_PING_TIME;
                                pinger_param_data <= slave_writedata; 
                            end
                        MEM_SIM_WAIT_TIME:
                            begin
                                pinger_param_channel <= MEM_SIM_WAIT_TIME;
                                pinger_param_data <= slave_writedata;
                            end
                    endcase
                end
            end
        end
    end

endmodule