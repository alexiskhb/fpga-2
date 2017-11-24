// dsp.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module dsp (
        input  wire signed [12:0]  streaming_sink_data,    //   avalon_streaming_sink.data
        input  wire                streaming_sink_valid,   //                        .valid
        output reg         [15:0]  streaming_source_data,  // avalon_streaming_source.data
        output reg                 streaming_source_valid, //                        .valid
        input  wire                clk,                    //              clock_sink.clk
        input  wire                reset,                  //              reset_sink.reset
        input  wire        [7:0]   slave_address,          //            avalon_slave.address
        input  wire                slave_read,             //                        .read
        output reg         [31:0]  slave_readdata,         //                        .readdata
        input  wire                slave_write,            //                        .write
        input  wire        [31:0]  slave_writedata,        //                        .writedata
        input  wire                slave_chipselect,       //                        .chipselect
        output wire        [31:0]  sdram0_address,         //           avalon_master.address
        output wire                sdram0_write,           //                        .write
        output wire        [63:0]  sdram0_writedata,       //                        .writedata
        input  wire                sdram0_waitrequest,     //                        .waitrequest
        output reg         [7:0]   led,                    //                        .led
        output reg         [7:0]   pins,                   //                        .led
        output reg                 irq,                     //                        .irq
        input wire         [1:0]   key,
        output reg                 streaming_source_startofpacket,
        output reg                 streaming_source_endofpacket,

        input wire         [5:0]   slave_1_address,
        input wire                 slave_1_chipselect,
        input wire                 slave_1_read,
        output reg         [16:0]  slave_1_readdata,
        output reg                 slave_1_waitrequest,

        output reg                 master_1_write,
        output reg         [15:0]  master_1_writedata,
        output reg                 master_1_waitrequest,
        output reg         [31:0]  master_1_address


    );

localparam memory_data = 8'h04;

reg dma_event;
reg [1:0] flag;

    always @ (posedge clk)
    begin
        if (flag == 0) begin
            master_1_writedata <= 16'd123;
            //master_1_write <= 1;//?
            flag <= 1;
        end else if (flag == 1) begin            
            master_1_writedata <= 16'd1489;
            master_1_write <= 1;      
            flag <= 2;
        end else if (flag == 2) begin
            master_1_write <= 0; 
            //master_1_waitrequest <= 1;
        end
    end


endmodule