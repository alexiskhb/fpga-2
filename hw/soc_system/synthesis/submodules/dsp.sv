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
        output reg         [7:0]   led,                    //                        .led
        output reg         [7:0]   pins,                   //                        .led
        output reg                 irq,                     //                        .irq
        input wire         [1:0]   key
    );

localparam memory_data = 8'h04;

reg [12:0] adc_data;
reg        flag;

    always @ (posedge clk)
    begin
        pins[1] <= 1'b1;
    end

    always @ (posedge clk)
    begin
        led[1] <= streaming_sink_data;
        if (key[0]) begin        
            led[0] <= 1'b1;            
            irq <= 1'b1;        
        end else
        if (slave_chipselect) begin
            if(slave_read) begin
                case (slave_address)
                    memory_data : 
                    begin
                        slave_readdata <= streaming_sink_data;
                        irq <= 0;
                        flag = 0;
                    end                    
                endcase
            end            
        end else
        if (key[1]) begin
            led[0] <= 1'b0;
            led[1] <= 1'b0;
            irq <= 1'b0;
        end
    end


endmodule