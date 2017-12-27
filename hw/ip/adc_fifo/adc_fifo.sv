`timescale 1 ps / 1 ps
module adc_fifo (
        input wire                 clk,
        input wire                 reset,
        output reg         [31:0]  avalon_streaming_source_data,
        output reg                 avalon_streaming_source_valid,

        output reg         [31:0]  avalon_master_address,
        output reg                 avalon_master_read,
        input wire         [31:0]  avalon_master_readdata,
        input wire                 avalon_master_waitrequest,
        output reg                 avalon_master_write,
        output reg         [31:0]  avalon_master_writedata,

        input wire                 avalon_slave_address,
        input wire                 avalon_slave_chipselect,
        input wire                 avalon_slave_read,
        output reg         [31:0]  avalon_slave_readdata,
        output reg                 avalon_slave_readdatavalid,
        output reg                 avalon_slave_waitrequest,

        input wire                 avalon_streaming_sink_valid,
        input wire         [31:0]  avalon_streaming_sink_data,

        input wire         [31:0]  avalon_streaming_sink_1_data,
        input wire         [7:0]   avalon_streaming_sink_1_channel,
        input wire         [7:0]   avalon_streaming_sink_1_error,
        input wire                 avalon_streaming_sink_1_valid,
        output reg                 avalon_streaming_sink_1_ready,

        output reg         [31:0]  avalon_streaming_source_1_data,
        output reg                 avalon_streaming_source_1_valid
    );

    reg [31:0] flag_in;
    reg [31:0] flag_out;

    reg [31:0] cntr_in;
    reg [31:0] cntr_out;
    reg [7:0] state;

    parameter WAITE     = 8'd0
            , FILL      = 8'd1
            , FULL      = 8'd2
            , POP       = 8'd3
            , PUSH      = 8'd4
            , SETUP_DMA = 8'd5
            , TO_DMA    = 8'd6
            , END       = 8'd7
            , DMA_EVENT = 32'd123
            , SIZE_FIFO = 32'd256
            , SIZE_IN   = 32'd300
            , SIZE_OUT  = 32'd256;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            cntr_in <= 0;
        end else begin
            if (cntr_in < SIZE_IN && (state == FILL || state == PUSH)) begin
                cntr_in <= cntr_in + 1;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            cntr_out <= SIZE_OUT;
        end else begin
            if (cntr_out > 0 && state == TO_DMA) begin
                cntr_out <= cntr_out - 1;
            end
        end
    end

    wire dma_event;
    assign dma_event = (avalon_streaming_sink_valid == 1'b1 && avalon_streaming_sink_data == DMA_EVENT) ? 1'b1 : 1'b0;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            state                           <= WAITE;
            avalon_master_address           <= 4;
            avalon_master_writedata         <= SIZE_FIFO;
            avalon_master_write             <= 1'b1;
            avalon_streaming_source_1_valid <= 0;
            avalon_streaming_source_1_data  <= 0;
            avalon_streaming_source_data    <= 0;
            avalon_streaming_source_valid   <= 0;
            avalon_slave_readdatavalid      <= 1'b0;
            avalon_slave_waitrequest        <= 1'b0;
        end else begin
            case (state)
                WAITE:
                    begin
                        avalon_master_write <= 1'b0;
                        if (dma_event) begin
                            state <= FILL;
                        end
                    end
                FILL:
                    if (cntr_in < SIZE_FIFO) begin
                        avalon_streaming_source_valid <= 1'b1;
                        avalon_streaming_source_data <= cntr_in;
                    end else begin
                        avalon_streaming_source_valid <= 1'b0;
                        state <= FULL;
                    end
                FULL:
                    begin
                        avalon_streaming_source_valid <= 1'b0;
                        if (cntr_in > SIZE_FIFO && cntr_in < SIZE_IN) begin
                            state  <= POP;
                        end else begin
                            state <= SETUP_DMA;
                        end
                    end
                POP:
                    begin
                        avalon_streaming_sink_1_ready <= 1'b1;
                        state <= PUSH;
                    end
                PUSH:
                    begin
                        avalon_streaming_sink_1_ready <= 1'b0;
                        avalon_streaming_source_valid <= 1'b1;
                        avalon_streaming_source_data <= cntr_in;
                        state <= FULL;
                    end
                SETUP_DMA:
                    if (avalon_streaming_sink_1_valid == 1'b1 && avalon_slave_chipselect == 1'b1) begin
                        avalon_streaming_sink_1_ready <= 1'b1;
                        state <= TO_DMA;
                    end
                TO_DMA:
                    if (cntr_out > 32'd0) begin
                        avalon_slave_readdatavalid <= 1'b1;
                        avalon_slave_readdata <= avalon_streaming_sink_1_data;
                    end else begin
                        avalon_streaming_sink_1_ready <= 1'b0;
                        avalon_slave_readdatavalid <= 1'b0;
                        state <= END;
                    end
            endcase
        end
    end
endmodule