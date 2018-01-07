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
        output reg                 in_valid,

        input wire         [63:0]  Y,
        input wire                 out_valid
    );

    reg [31:0] flag_in;
    reg [31:0] flag_out;

    reg [31:0] cntr_in;
    reg [31:0] cntr_out;
    reg [31:0] fft_countr;
    reg [7:0] state;
    reg [7:0] state_after_pause;
    reg [31:0] fft_cntr_in;
    reg [31:0] fft_cntr_out;

    reg [4:0] pause_cntr;

   reg [15:0] in [511:0];//511 || 255?

   reg [15:0] out [511:0];

    parameter WAITE     = 8'd0
            , FILL      = 8'd1
            , FULL      = 8'd2
            , POP       = 8'd3
            , PUSH      = 8'd4
            , SETUP_DMA = 8'd5
            , TO_DMA    = 8'd6
            , PAUSE     = 8'd7
            , END       = 8'd8
            , FILL_FIFO_FFT = 8'd9
            , DMA_EVENT = 32'd123
            , SIZE_FIFO = 32'd768
            , SIZE_FFT  = 32'd256
            , SIZE_2_FFT  = 32'd512;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            cntr_in <= 0;
        end else begin
            if (cntr_in < SIZE_FIFO && state == FILL && adc_valid == 1'b1 && adc_channel == 2) begin
                cntr_in <= cntr_in + 1;
            end else if (state == END) begin
                cntr_in <= 0;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            fft_countr <= 0;
        end else begin
            if (fft_countr < SIZE_FIFO && state == FILL_FIFO_FFT) begin
                fft_countr <= fft_countr + 1;
            end else if (state == END) begin
                fft_countr <= 0;
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


    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            fft_cntr_in <= 0;
        end else begin
            if (fft_cntr_in < 128 && state == FULL) begin
                fft_cntr_in <= fft_cntr_in + 1;
            end else if (state == END) begin
                fft_cntr_in <= 0;
            end
        end
    end

   always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            fft_cntr_out <= 0;
        end else begin
            if (fft_cntr_out < 128 && state == PUSH && flag_fft_out == 1) begin
                fft_cntr_out <= fft_cntr_out + 1;
            end else if (state == END) begin
                fft_cntr_out <= 0;
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
    reg flag_fft_out;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            state                           <= POP;
            fifo_csr_address                <= 4;
            fifo_csr_writedata              <= SIZE_FIFO;
            fifo_csr_write                  <= 1'b1;
            fifo_in_data                    <= 0;
            fifo_in_valid                   <= 0;
            dma_readdatavalid               <= 1'b0;
            dma_waitrequest                 <= 1'b0;
            pause_cntr                      <= 4'd0;
            adc_prev_channel                <= 3'd0;
            flag_fft_out                    <= 1'b0;
        end else begin
            adc_prev_channel <= adc_channel;
            case (state)
                FILL:
                    if (cntr_in < SIZE_FFT && adc_valid == 1'b0) begin
                        fifo_in_valid <= 1'b0;
                    end else if (cntr_in < SIZE_FFT && adc_valid == 1'b1 && adc_channel == 2) begin
                        fifo_in_valid <= 1'b1;
                        fifo_in_data <= adc_data;
                        in[cntr_in] <= {adc_data[12], 3'b0, adc_data[11:0]};
                        state <= PAUSE;
                        state_after_pause <= FILL;
                    end else if (cntr_in >= SIZE_FFT) begin
                        fifo_in_valid <= 1'b0;
                        // next_in <= 1'b1;
                        in_valid <= 1'b1;
                        state <= FULL;
                    end else begin
                        fifo_in_valid <= 1'b0;
                    end
                FULL:
                    begin
                        // next_in <= 1'b0;
                        if (fft_cntr_in < 128) begin
                            in_valid <= 1'b1;
                            X <= {in[fft_cntr_in * 2], in[fft_cntr_in * 2 + 1]};
                        end else begin
                            in_valid <= 1'b0;
                            state <= PUSH;
                        end
                    end
                POP:
                    begin
                        if (align_event) begin
                            state <= FILL;
                        end
                    end
                PUSH:
                    begin
                        if (out_valid == 1'b1 && flag_fft_out == 0) begin
                           flag_fft_out <= 1'b1;
                        end else if (flag_fft_out == 1 && out_valid == 1) begin
                           if (fft_cntr_out < 128) begin
                              out[fft_cntr_out * 4] <= Y[63:48];
                              out[fft_cntr_out * 4 + 1] <= Y[47:32];
                              out[fft_cntr_out * 4 + 2] <= Y[31:16];
                              out[fft_cntr_out * 4 + 3] <= Y[15:0];
                           end else begin
                              state <= FILL_FIFO_FFT;
                           end
                        end
                    end
                FILL_FIFO_FFT:
                    begin
                        if (fft_countr < SIZE_2_FFT) begin
                           fifo_in_valid <= 1'b1;
                           fifo_in_data <= out[fft_countr];
                        end else begin
                           fifo_in_valid <= 1'b0;
                           state <= SETUP_DMA;
                           irq <= 1'b1;
                        end
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