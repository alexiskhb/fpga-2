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
        output reg         [31:0]  avalon_slave_readdata
    );


endmodule