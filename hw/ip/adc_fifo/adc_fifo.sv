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

        input wire         [12:0]  adc_data,
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
        output reg         [31:0]  sqrt_value
    );

    reg [31:0] flag_in;
    reg [31:0] flag_out;

    reg [31:0] cntr_in;
    reg [31:0] cntr_out;
    reg [7:0] state;
    reg [7:0] state_after_pause;
    reg [7:0] state_fft;

    reg [4:0] pause_cntr;

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

            , DMA_EVENT = 32'd123
            , SIZE_FIFO = 32'd3072
            , FFT_SIZE  = 32'd256
            , FFT_HALF_SIZE  = 32'd128
            , MEAN_SIZE = 32'd16;

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

    reg align_event;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            align_event <= 1'b0;
        end else begin
            if (align_event == 0 && dma_event == 1) begin
                align_event <= 1'b1;
            end else if (state == END) begin
                align_event <= 1'b0;
            end
        end
    end

    reg [2:0] adc_prev_channel;
    reg [15:0] in1 [255:0];
    reg [15:0] in2 [255:0];
    reg [15:0] in3 [255:0];

    // reg [15:0] in [3:0][255:0];

    reg signed [31:0] fft_real_out [16:0];
    reg signed [31:0] fft_imag_out [16:0];

    // reg [31:0] fft_component;
    reg signed [31:0] fft_real_component;
    reg signed [31:0] fft_imag_component;
    reg [15:0] index_fft;

    reg [31:0] fft_cntr;
    reg [31:0] mean_sum;
    reg [31:0] in1_cntr;
    reg [31:0] in2_cntr;
    reg [31:0] in3_cntr;


    reg [15:0] treshold;

    reg fft1_good;

    reg free_fft;

    reg [15:0] sqrt_component_tmp;
    reg [31:0] mean_shifted_tmp;
    
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

    reg [31:0] mean_cntr;

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

    reg [31:0] fft_tmp_real;
    reg [31:0] fft_tmp_imag;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            state_fft <= WAIT;
            fft1_good <= 0;
            mean_sum <= 0;
        end else begin
            case (state_fft)
                WAIT:
                    if (in1_cntr >= FFT_SIZE) begin
                        state_fft <= FFT_IN1;
                        next_in <= 1;
                        mean_sum <= 0;
                    end
                FFT_IN1:
                    begin
                        next_in <= 0;
                        if (fft_cntr < FFT_HALF_SIZE) begin
                            X <= {in1[fft_cntr * 2], in1[fft_cntr * 2 + 1]};
                        end else begin
                            state_fft <= FFT_OUT1;
                        end
                    end
                FFT_OUT1:
                    if (next_out == 1) begin
                        state_fft <= GET_OUT1;
                    end
                GET_OUT1:                    
                    if (fft_cntr >= 5 && fft_cntr <= 12) begin
                        if (Y[63:48] < 0) begin
                            fft_real_out[(fft_cntr - 5) * 2] <= { 16'hffff, Y[63:48] };
                        end else begin
                            fft_real_out[(fft_cntr - 5) * 2] <= { 16'b0, Y[63:48]};
                        end
                        if (Y[47:32] <0) begin
                            fft_imag_out[(fft_cntr - 5) * 2] <= { 16'hffff, Y[47:32] };
                        end else begin
                            fft_imag_out[(fft_cntr - 5) * 2] <= { 16'b0, Y[47:32] };
                        end
                        if (Y[31:16] <0) begin
                            fft_real_out[(fft_cntr - 5) * 2 + 1] <= { 16'hffff, Y[31:16] };
                        end else begin
                            fft_real_out[(fft_cntr - 5) * 2 + 1] <= { 16'b0, Y[31:16] };
                        end
                        if (Y[15:0] <0) begin
                            fft_imag_out[(fft_cntr - 5) * 2 + 1] <= { 16'hffff, Y[15:0] };
                        end else begin
                            fft_imag_out[(fft_cntr - 5) * 2 + 1] <= { 16'b0, Y[15:0] };
                        end
                        // fft_real_out[(fft_cntr - 5) * 2] <= Y[63:48];
                        // fft_imag_out[(fft_cntr - 5) * 2] <= Y[47:32];
                        // fft_real_out[(fft_cntr - 5) * 2 + 1] <= Y[31:16];
                        // fft_imag_out[(fft_cntr - 5) * 2 + 1] <= Y[15:0];
                    end else if (fft_cntr == index_fft) begin
                        // fft_component <= { Y[63:48],  Y[47:32] };
                        if (Y[63:48] < 0) begin
                            fft_real_component <= { 16'hffff, Y[63:48] };
                        end else begin
                            fft_real_component <= { 16'b0, Y[63:48]};
                        end
                        if (Y[47:32] < 0) begin
                            fft_imag_component <= { 16'hffff, Y[47:32] };
                        end else begin
                            fft_imag_component <= { 16'b0, Y[47:32]};
                        end
                        // fft_real_component <= Y[63:48];
                        // fft_imag_component <= Y[47:32];
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
                            mean_sum = mean_sum + sqrt_result;
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
                            if (sqrt_result >= treshold * (mean_sum >> 4)) begin
                                fft1_good <= 1;
                            end else begin
                                fft1_good <= 0;
                            end
                            // state_fft <= WAIT;
                            state_fft <= FFT_END;
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
            treshold                        <= 50;
            index_fft                       <= 24;
        end else begin
            adc_prev_channel <= adc_channel;    
            if (state_fft == FFT_OUT1) begin
                in1_cntr <= 0;
            end
            case (state)
                FILL:
                    if (cntr_in < SIZE_FIFO && adc_valid == 1'b0) begin
                        fifo_in_valid <= 1'b0;
                    end else if (cntr_in < SIZE_FIFO && adc_valid == 1'b1) begin
                        // if (adc_channel == 1 && in3_cntr < FFT_SIZE) begin
                        //     in3[in3_cntr] <= adc_data;
                        //     in3_cntr <= in3_cntr + 1;
                        // end else if (adc_channel == 2 && in1_cntr < FFT_SIZE) begin
                        //     in1[in1_cntr] <= adc_data;
                        //     in1_cntr <= in1_cntr + 1;
                        // end else if (adc_channel == 3 && in2_cntr < FFT_SIZE) begin
                        //     in2[in2_cntr] <= adc_data;
                        //     in2_cntr <= in2_cntr + 1;
                        // end
                        fifo_in_valid <= 1'b1;
                        fifo_in_data <= adc_data;
                        state <= PAUSE;
                        state_after_pause <= FILL;
                    end else if (cntr_in >= SIZE_FIFO) begin
                        fifo_in_valid <= 1'b0;
                        state <= FULL;
                    end
                FULL:
                    begin
                        fifo_in_valid <= 1'b0;
                        if (state_fft != WAIT && adc_channel == 1 && adc_prev_channel == 1) begin
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
                        if (align_event == 1) begin
                            if (adc_channel == 1 && in3_cntr < FFT_SIZE) begin
                                in3[in3_cntr] <= adc_data;
                                in3_cntr <= in3_cntr + 1;
                            end else if (adc_channel == 2 && in1_cntr < FFT_SIZE) begin
                                in1[in1_cntr] <= adc_data;
                                in1_cntr <= in1_cntr + 1;
                            end else if (adc_channel == 3 && in2_cntr < FFT_SIZE) begin
                                in2[in2_cntr] <= adc_data;
                                in2_cntr <= in2_cntr + 1;
                            end
                        end
                        fifo_out_ready <= 1'b0;
                        fifo_in_valid <= 1'b1;
                        fifo_in_data <= adc_data;
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
                        // state <= FILL;
                    end
            endcase
        end
    end
endmodule