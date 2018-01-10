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

            , DMA_EVENT = 32'd123
            , SIZE_FIFO = 32'd3072
            , FFT_SIZE  = 32'd256
            , FFT_HALF_SIZE  = 32'd128;

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
    reg free_fft;
    
    // always @ (posedge clk or posedge reset)
    // begin
    //     if (reset) begin
    //         fft_cntr_in <= 0;
    //     end else begin
    //         if (fft_cntr_in <  FFT_HALF_SIZE && state_fft == FULL) begin
    //             fft_cntr_in <= fft_cntr_in + 1;
    //         end else if (state_fft == END) begin
    //             fft_cntr_in <= 0;
    //         end
    //     end
    // end


    // always @ (posedge clk or posedge reset)
    // begin
    //     if (reset) begin
    //         state_fft <= WAIT;
    //     end else begin
    //         case (state_fft)
    //             WAIT:
    //                 begin
    //                     if (in1_cntr >= FFT_SIZE) begin
    //                         state_fft <= FULL1;
    //                         next_in <= 1;
    //                     end
    //                 end
    //             FFT_IN1:
    //                 begin
    //                     next_in <= 0;
    //                     if (fft_cntr_in < FFT_HALF_SIZE) begin
    //                         X <= {in1[fft_cntr_in * 2], in1[fft_cntr_in * 2 + 1]};
    //                     end else begin
    //                         state_fft <= FFT_OUT1;
    //                     end
    //                 end
    //             FFT_OUT1:
    //                 begin
    //                     if (next_out == 1) begin
    //                         state_fft <= GET_OUT1;
    //                     end
    //                 end

    //         endcase            
    //     end
    // end

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
        end else begin
            adc_prev_channel <= adc_channel;    
            // if ((in1_cntr >= FFT_SIZE || in2_cntr >= FFT_SIZE || in3_cntr >= FFT_SIZE) && setup_next == 0) begin
            //     next_in <= 1;
            //     setup_next <= 1;
            // end else if (in1_cntr >= FFT_SIZE && free_fft == 1 && setup_next == 1) begin
            //     next_in <= 0;
            //     free_fft <= 0;
            // end else if (in2_cntr >= FFT_SIZE && free_fft == 1 && setup_next == 1) begin
            //     next_in <= 0;
            //     free_fft <= 0;
            // end else if (in3_cntr >= FFT_SIZE && free_fft == 1 && setup_next == 1) begin
            //     next_in <= 0;
            //     free_fft <= 0;
            // end
            case (state)
                FILL:
                    if (cntr_in < SIZE_FIFO && adc_valid == 1'b0) begin
                        fifo_in_valid <= 1'b0;
                    end else if (cntr_in < SIZE_FIFO && adc_valid == 1'b1) begin
                        // if (adc_channel == 1 && in3_cntr < FFT_SIZE) begin
                        //     in3[in3_cntr] <= adc_data;
                        //     in3_cntr = in3_cntr + 1;
                        // end else if (adc_channel == 2 && in1_cntr < FFT_SIZE) begin
                        //     in1[in1_cntr] <= adc_data;
                        //     in1_cntr = in1_cntr + 1;
                        // end else if (adc_channel == 3 && in2_cntr < FFT_SIZE) begin
                        //     in2[in2_cntr] <= adc_data;
                        //     in2_cntr = in2_cntr + 1;
                        // end
                        fifo_in_valid <= 1'b1;
                        fifo_in_data <= adc_data;
                        state <= PAUSE;
                        state_after_pause <= FILL;
                    end else if (cntr_in >= SIZE_FIFO) begin
                        fifo_in_valid <= 1'b0;
                        state <= FULL;
                        sqrt_value <= 32'd1119177015;
                        sqrt_start <= 1'b1;
                    end
                FULL:
                    begin
                        fifo_in_valid <= 1'b0;
                        if (align_event == 1'b1 && adc_channel == 1 && adc_prev_channel == 1) begin
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
                        fifo_out_ready <= 1'b0;
                        fifo_in_valid <= 1'b1;
                        fifo_in_data <= adc_data;
                        state <= PAUSE;
                        state_after_pause <= FULL;
                    end
                SETUP_DMA:
                    begin
                        if (fifo_out_valid == 1'b1 && dma_chipselect == 1'b1) begin
                            sqrt_value <= 32'd1119177015;
                            sqrt_start <= 1'b1;
                            irq <= 1'b0;
                            fifo_out_ready <= 1'b1;
                            state <= TO_DMA;
                        end
                    end
                TO_DMA:
                    if (cntr_out > 32'd0) begin
                        dma_readdatavalid <= 1'b1;
                        dma_readdata <= sqrt_result;
                    end else begin
                        fifo_out_ready <= 1'b0;
                        dma_readdatavalid <= 1'b0;
                        state <= END;
                    end
                PAUSE:
                    begin
                        if (pause_cntr >= 4'd7) begin
                            pause_cntr <= 4'd0;
                            state <= state_after_pause;
                        end else begin
                            pause_cntr <= pause_cntr + 1;
                        end
                    end
                END:
                    begin
                        state <= FILL;
                    end
            endcase
        end
    end
endmodule