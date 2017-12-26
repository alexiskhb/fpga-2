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
    reg [31:0] flag_event;
    reg        dma_event;


    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            dma_event <= 1'b0;
        end else begin
            if (avalon_streaming_sink_valid == 1'b1 && avalon_streaming_sink_data == 32'd123) begin
                dma_event <= 1'b1;
            end else if (flag_in == 3) begin
                dma_event <= 17;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if(reset) begin
            flag_in <= 0;
            avalon_streaming_source_data <= 0;
            avalon_streaming_source_valid <= 0;
        end else begin
            if (dma_event == 1'b1 && flag_in == 0) begin
                avalon_streaming_source_valid <= 1;
                avalon_streaming_source_data <= 32'hABCD1235;
                flag_in <= 1;
            end else if (flag_in == 1) begin
                avalon_streaming_source_data <= 32'd2018;
                flag_in <= 2;
            end else if (flag_in == 2) begin
                avalon_streaming_source_data <= 32'd1489;
                flag_in <= 3;
            end else if (flag_in == 3) begin
                avalon_streaming_source_data <= 32'hABCD1245;
                flag_in <= 4;
            end else if (flag_in == 4) begin
                avalon_streaming_source_valid <= 0;
                flag_in <= 5;
            end else if (flag_out == 5) begin
                flag_in <= 17;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            flag_out <= 0;
            avalon_master_address <= 4;
            avalon_master_writedata <= 4;
            avalon_master_write <= 1'b1;
            avalon_streaming_source_1_valid <= 0;
            avalon_streaming_source_1_data <= 0;
            avalon_slave_readdatavalid <= 1'b0;
            avalon_slave_waitrequest <= 1'b0;
        end else begin
            avalon_master_write <= 1'b0;
            if (flag_in == 5 && flag_out == 0 && avalon_streaming_sink_1_valid == 1'b1
                    && avalon_slave_chipselect == 1'b1) begin
                avalon_streaming_sink_1_ready <= 1'b1;
                flag_out <= 4;
            end else if (flag_out == 4) begin
                avalon_slave_readdatavalid <= 1'b1;
                avalon_slave_readdata <= avalon_streaming_sink_1_data;
                flag_out <= 5;
            end else if (flag_out == 5) begin
                avalon_slave_readdata <= avalon_streaming_sink_1_data;
                flag_out <= 6;
            end else if (flag_out == 6) begin
                avalon_slave_readdata <= avalon_streaming_sink_1_data;
                flag_out <= 7;
            end else if (flag_out == 7) begin
                avalon_slave_readdata <= avalon_streaming_sink_1_data;
                flag_out <= 8;
            end else if (flag_out == 8) begin
                avalon_streaming_sink_1_ready <= 1'b0;
                avalon_slave_readdatavalid <= 1'b0;
                flag_out <= 9;
            end else if (flag_out == 9) begin
                flag_out <= 17;
            end
        end
    end

endmodule