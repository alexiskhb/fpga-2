`timescale 1ps / 1ps

module top_testbench();

    reg clk = 1;
    reg reset = 1;
    wire [7:0] ports_led;
    wire          dsp_avalon_streaming_source_valid;                         // dsp:streaming_source_valid -> adc_fifo:avalon_streaming_sink_valid
    wire   [31:0] dsp_avalon_streaming_source_data;                          // dsp:streaming_source_data -> adc_fifo:avalon_streaming_sink_data
    

    adc_fifo adc_fifo (
        .clk                             (clk),                                   //              clock_sink.clk
        .reset                           (reset),                      //              reset_sink.reset
        .avalon_streaming_source_data    (),               // avalon_streaming_source.data
        .avalon_streaming_source_valid   (),              //                        .valid
        .avalon_master_address           (),                                                    //           avalon_master.address
        .avalon_master_chipselect        (),                                                    //                        .chipselect
        .avalon_master_read              (),                                                    //                        .read
        .avalon_master_readdata          (),                                                    //                        .readdata
        .avalon_master_readdatavalid     (),                                                    //                        .readdatavalid
        .avalon_master_waitrequest       (),                                                    //                        .waitrequest
        .avalon_slave_address            (),     //            avalon_slave.address
        .avalon_slave_readdata           (),    //                        .readdata
        .avalon_slave_read               (),        //                        .read
        .avalon_slave_waitrequest        (), //                        .waitrequest
        .avalon_streaming_sink_valid     (),                   //   avalon_streaming_sink.valid
        .avalon_streaming_sink_data      (),                    //                        .data
        .avalon_streaming_sink_1_channel (),                 // avalon_streaming_sink_1.channel
        .avalon_streaming_sink_1_data    (),                    //                        .data
        .avalon_streaming_sink_1_error   (),                   //                        .error
        .avalon_streaming_sink_1_valid   ()                    //                        .valid
    );

    soc_system_fifo_0 fifo_0 (
        .wrclock                 (clk),               //   clk_in.clk
        .reset_n                 (~reset), // reset_in.reset_n
        .avalonst_sink_valid     (),   //       in.valid
        .avalonst_sink_data      (),    //         .data
        .avalonst_sink_channel   (), //         .channel
        .avalonst_sink_error     (),   //         .error
        .avalonst_source_valid   (),                //      out.valid
        .avalonst_source_data    (),                 //         .data
        .avalonst_source_channel (),              //         .channel
        .avalonst_source_error   ()                 //         .error
    );

    dsp dsp (
        .streaming_sink_data    (),              //   avalon_streaming_sink.data
        .streaming_sink_valid   (),             //                        .valid
        .streaming_source_data  (dsp_avalon_streaming_source_data),              // avalon_streaming_source.data
        .streaming_source_valid (dsp_avalon_streaming_source_valid),             //                        .valid
        .clk                    (clk),                             //              clock_sink.clk
        .reset                  (reset),                //              reset_sink.reset
        .slave_address          (),    //            avalon_slave.address
        .slave_read             (),       //                        .read
        .slave_readdata         (),   //                        .readdata
        .slave_chipselect       (), //                        .chipselect
        .slave_write            (),      //                        .write
        .slave_writedata        (),  //                        .writedata
        .irq                    (),                      //        interrupt_sender.irq
        .led                    (),                                     //                  portio.led
        .pins                   (),                                    //                        .gpio
        .key                    (),                                     //                        .key
        .sdram0_address         (),                     //           avalon_master.address
        .sdram0_write           (),                       //                        .write
        .sdram0_writedata       (),                   //                        .writedata
        .sdram0_waitrequest     (),                 //                        .waitrequest
        .slave_1_address        (),                                              //          avalon_slave_1.address
        .slave_1_chipselect     (),                                              //                        .chipselect
        .slave_1_read           (),                                              //                        .read
        .slave_1_readdata       (),                                              //                        .readdata
        .slave_1_waitrequest    (),                                              //                        .waitrequest
        .master_1_write         (),                                              //         avalon_master_1.write
        .master_1_writedata     (),                                              //                        .writedata
        .master_1_waitrequest   (),                                              //                        .waitrequest
        .master_1_address       ()                                               //                        .address
    );

    initial begin
        forever #5 clk = ~clk; // generate a clock
    end
    
    initial
        #200 reset = 0;
endmodule