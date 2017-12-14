`timescale 1 ps / 1 ps
module adc_fifo (
        input wire                 clk,                    
        input wire                 reset,                  
        output reg         [31:0]  avalon_streaming_source_data,  
        output reg                 avalon_streaming_source_valid, 

        output reg         [5:0]   avalon_master_address,
        output reg                 avalon_master_chipselect,
        output reg                 avalon_master_read,        
        input wire         [31:0]  avalon_master_readdata,
        input wire                 avalon_master_readdatavalid,
        input wire                 avalon_master_waitrequest,

        input wire                 avalon_slave_address,
        input wire                 avalon_slave_read,
        output reg         [31:0]  avalon_slave_readdata,

        input wire                 avalon_streaming_sink_valid,
        input wire         [31:0]  avalon_streaming_sink_data
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
            end else if (flag_in == 2) begin
                dma_event <= 0;
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
                avalon_streaming_source_data <= 32'd123;
                avalon_streaming_source_valid <= 1;
                flag_in <= 1;                          
            end else if (flag_in == 1) begin            
                avalon_streaming_source_data <= 32'd1489;
                flag_in <= 2;
            end else if (flag_in == 2) begin
                avalon_streaming_source_valid <= 0;
                flag_in <= 3;
            end else if (flag_in == 3) begin
                flag_in <= 0;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            flag_out <= 0;
            avalon_master_read <= 0;
            avalon_slave_readdata <= 0;
        end else begin
            if (flag_in == 3) begin
                avalon_master_read <= 1;
                avalon_slave_readdata <= avalon_master_readdata;
                flag_out <= 4;
            end else if (flag_out == 4) begin
                avalon_slave_readdata <= avalon_master_readdata;
                flag_out <= 5;
            end else if (flag_out == 5) begin
                avalon_master_read <= 0;
                flag_out <= 0;
            end
        end
    end

endmodule