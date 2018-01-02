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

        output reg         [32:0]  fft_in_data,
        output reg                 fft_in_eop,
        output reg         [1:0]   fft_in_err,
        input wire                 fft_in_ready,
        output reg                 fft_in_sop,
        output reg                 fft_in_valid,

        input wire         [37:0]  fft_out_data,
        input wire                 fft_out_eop,
        input wire         [1:0]   fft_out_err,
        output reg                 fft_out_ready,
        input wire                 fft_out_sop,
        input wire                 fft_out_valid
    );

    reg [31:0] flag_in;
    reg [31:0] flag_out;

    reg [31:0] cntr_in;
    reg [31:0] cntr_out;
    reg [7:0] state;
    reg [7:0] state_after_pause;

    reg [4:0] pause_cntr;

    parameter WAITE     = 8'd0
            , FILL      = 8'd1
            , FULL      = 8'd2
            , POP       = 8'd3
            , PUSH      = 8'd4
            , SETUP_DMA = 8'd5
            , TO_DMA    = 8'd6
            , PAUSE     = 8'd7
            , END       = 8'd8
            , DMA_EVENT = 32'd123
            , SIZE_FIFO = 32'd3072
            , SIZE_FFT  = 32'd256;

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
            fft_in_valid                    <= 1'b0;
        end else begin
            adc_prev_channel <= adc_channel;
            case (state)
                FILL:
                    if (cntr_in < SIZE_FFT && adc_valid == 1'b0) begin
                        fifo_in_valid <= 1'b0;
                        fft_in_valid <= 1'b0;
                    end else if (cntr_in < SIZE_FFT && adc_valid == 1'b1 && adc_channel == 2 && fft_in_ready == 1) begin
                        if (cntr_in == 0) begin
                            fft_in_sop <= 1'b1;
                            fft_in_eop <= 1'b0;
                        end else if (cntr_in == 255) begin
                            fft_in_sop <= 1'b0;
                            fft_in_eop <= 1'b1;
                        end  else begin
                            fft_in_sop <= 1'b0;
                            fft_in_eop <= 1'b0;
                        end
                        fifo_in_valid <= 1'b1;
                        fifo_in_data <= adc_data;
                        fft_in_valid <= 1'b1;
                        fft_in_data <= {adc_data[12], 3'b0, adc_data[11:0], 17'b0};
                        state <= PAUSE;
                        state_after_pause <= FILL;
                    end else if (cntr_in >= SIZE_FFT) begin
                        fifo_in_valid <= 1'b0;
                        fft_in_valid <= 1'b0;
                        state <= FULL;
                    end
                FULL:
                    begin
                        // fifo_in_valid <= 1'b0;
                        // if (align_event == 1'b1 && adc_channel == 1 && adc_prev_channel == 1) begin
                        //     state <= SETUP_DMA;
                        //     irq <= 1'b1;
                        // end else if (adc_valid == 1'b1) begin
                        //     state  <= POP;
                        // end
                        fft_out_ready <= 1'b1;
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