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
        output reg         [7:0]   streaming_source_data,  // avalon_streaming_source.data
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
        output reg        [7:0]   led,                    //                        .led
        output reg         [7:0]   pins,                   //                        .led
        output reg                irq,                     //                        .irq
        input wire         [1:0]   key
    );

    wire            [7:0]           coder_data_out;
    wire                            coder_ready;
    wire signed     [31:0]          fir_sink_data;
    wire                            fir_sink_valid;

    wire            [7:0]           data_fifo_tx;
    wire                            rden_fifo_tx;
    wire                            wren_fifo_tx;
    wire            [7:0]           data_tx;
    wire            [7:0]           size_fifo_tx;
    wire                            ready_tx;
    wire                            start_tx;

    wire            [7:0]           data_fifo_rx;
    wire                            rden_fifo_rx;
    wire                            wren_fifo_rx;
    wire            [7:0]           data_rx;
    wire            [7:0]           size_fifo_rx;
    wire            [7:0]           interrupt_id;
    wire                            navig_timer_start;
    wire signed     [31:0]          test;
    wire signed     [12:0]          data_in;

    wire            [31:0]          guard_interval;
    wire            [31:0]          rx_threshold;
    wire            [31:0]          comp_threshold;
    wire            [31:0]          mem_addr;
    wire            [31:0]          end_address;
    wire                            data_ready;

    //assign data_in = {1'b0, coder_data_out, 4'd0};//ready_tx ? streaming_sink_data : 13'd0;

    always @ (posedge clk)
    begin
        if (key[0]) begin        
            led[0] <= 1'b1;
            led[1] <= 1'b1;
            irq <= 1'b1;        
        end else
        if (slave_chipselect) begin
            if(slave_read) begin
                irq <= 1'b0;
            end else 
            if (slave_write) begin
                case(slave_address)
                    8'h04: irq <= 1'b1;
                endcase
            end
        end else
        if (key[1]) begin
            led[0] <= 1'b0;
            led[1] <= 1'b0;
            irq <= 1'b0;
        end
        led <= streaming_sink_data;
    end


endmodule