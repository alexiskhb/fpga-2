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
        output reg         [16:0]   streaming_source_data,  // avalon_streaming_source.data
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
        output reg                 slave_1_waitrequest

    );

reg flag;

    always @ (posedge clk)
    begin
        if (flag == 0) begin
            streaming_source_startofpacket <= 1'b1;
            streaming_source_data <= 16'd43696;
            streaming_source_valid <= 1'b1;
            flag <= 1;                
        end else if (flag == 1) begin
            streaming_source_data <= 16'd1489;
            streaming_source_valid <= 1'b1;
            streaming_source_endofpacket <= 1'b1;
        end
    end


endmodule