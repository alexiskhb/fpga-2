`timescale 1ps / 1ps

module top_testbench();

    reg            clk = 1;
    reg            reset = 1;
    reg     [1:0]  key;
    wire           fifo_ready;
    wire    [7:0]  ports_led;
    wire           dsp_avalon_streaming_source_valid;
    wire    [31:0] dsp_avalon_streaming_source_data;
    wire           adc_fifo_avalon_streaming_source_valid;
    wire    [31:0] adc_fifo_avalon_streaming_source_data;
    wire           avalon_st_adapter_001_out_0_valid;
    wire    [31:0] avalon_st_adapter_001_out_0_data;
    wire    [7:0]  avalon_st_adapter_001_out_0_channel;
    wire    [7:0]  avalon_st_adapter_001_out_0_error;
    wire          avalon_st_adapter_001_out_0_ready;

    wire   [31:0] adc_fifo_avalon_master_readdata;
    wire          adc_fifo_avalon_master_waitrequest;
    wire   [31:0] adc_fifo_avalon_master_address;
    wire          adc_fifo_avalon_master_read;
    wire   [31:0] adc_fifo_avalon_master_writedata;
    wire          adc_fifo_avalon_master_write;


    adc_fifo adc_fifo (
        .clk                             (clk),
        .reset                           (reset),
        .avalon_streaming_source_data    (adc_fifo_avalon_streaming_source_data),
        .avalon_streaming_source_valid   (adc_fifo_avalon_streaming_source_valid),
        .avalon_master_address           (adc_fifo_avalon_master_address),
        .avalon_master_read              (adc_fifo_avalon_master_read),
        .avalon_master_readdata          (adc_fifo_avalon_master_readdata),
        .avalon_master_writedata         (adc_fifo_avalon_master_writedata),
        .avalon_master_write             (adc_fifo_avalon_master_write),
        .avalon_master_waitrequest       (adc_fifo_avalon_master_waitrequest),
        .avalon_slave_address            (),
        .avalon_slave_readdata           (),
        .avalon_slave_read               (),
        .avalon_slave_waitrequest        (),
        .avalon_streaming_sink_valid     (dsp_avalon_streaming_source_valid),
        .avalon_streaming_sink_data      (dsp_avalon_streaming_source_data),
        .avalon_streaming_sink_1_channel (avalon_st_adapter_001_out_0_channel),
        .avalon_streaming_sink_1_data    (avalon_st_adapter_001_out_0_data),
        .avalon_streaming_sink_1_error   (avalon_st_adapter_001_out_0_error),
        .avalon_streaming_sink_1_valid   (avalon_st_adapter_001_out_0_valid),
        .avalon_streaming_sink_1_ready   (avalon_st_adapter_001_out_0_ready)
    );

    soc_system_fifo_0 fifo_0 (
        .wrclock                 (clk),
        .reset_n                 (~reset),
        .avalonst_sink_valid     (adc_fifo_avalon_streaming_source_valid),
        .avalonst_sink_data      (adc_fifo_avalon_streaming_source_data),
        .avalonst_sink_channel   (),
        .avalonst_sink_error     (),
        .avalonst_source_valid   (avalon_st_adapter_001_out_0_valid),
        .avalonst_source_data    (avalon_st_adapter_001_out_0_data),
        .avalonst_source_channel (avalon_st_adapter_001_out_0_channel),
        .avalonst_source_error   (avalon_st_adapter_001_out_0_error)
    );

    dsp dsp (
        .streaming_sink_data    (),
        .streaming_sink_valid   (),
        .streaming_source_data  (dsp_avalon_streaming_source_data),
        .streaming_source_valid (dsp_avalon_streaming_source_valid),
        .clk                    (clk),
        .reset                  (reset),
        .slave_address          (),
        .slave_read             (),
        .slave_readdata         (),
        .slave_chipselect       (),
        .slave_write            (),
        .slave_writedata        (),
        .irq                    (),
        .led                    (ports_led),
        .pins                   (),
        .key                    (key),
        .sdram0_address         (),
        .sdram0_write           (),
        .sdram0_writedata       (),
        .sdram0_waitrequest     (),
        .slave_1_address        (),
        .slave_1_chipselect     (),
        .slave_1_read           (),
        .slave_1_readdata       (),
        .slave_1_waitrequest    (),
        .master_1_write         (),
        .master_1_writedata     (),
        .master_1_waitrequest   (),
        .master_1_address       ()
    );

    altera_avalon_sc_fifo #(
        .SYMBOLS_PER_BEAT    (1),
        .BITS_PER_SYMBOL     (32),
        .FIFO_DEPTH          (8192),
        .CHANNEL_WIDTH       (8),
        .ERROR_WIDTH         (8),
        .USE_PACKETS         (0),
        .USE_FILL_LEVEL      (1),
        .EMPTY_LATENCY       (3),
        .USE_MEMORY_BLOCKS   (1),
        .USE_STORE_FORWARD   (1),
        .USE_ALMOST_FULL_IF  (0),
        .USE_ALMOST_EMPTY_IF (0)
    ) sc_fifo_0 (
        .clk               (clk),
        .reset             (reset),
        .csr_address       (adc_fifo_avalon_master_address),
        .csr_read          (adc_fifo_avalon_master_read),
        .csr_write         (adc_fifo_avalon_master_write),
        .csr_readdata      (adc_fifo_avalon_master_readdata),
        .csr_writedata     (adc_fifo_avalon_master_writedata),
        .in_data           (adc_fifo_avalon_streaming_source_data),
        .in_valid          (adc_fifo_avalon_streaming_source_valid),
        .in_ready          (fifo_ready),
        .in_error          (),
        .in_channel        (),
        .out_data          (avalon_st_adapter_001_out_0_data),
        .out_valid         (avalon_st_adapter_001_out_0_valid),
        .out_ready         (avalon_st_adapter_001_out_0_ready),
        .out_error         (avalon_st_adapter_001_out_0_error),
        .out_channel       (avalon_st_adapter_001_out_0_channel),
        .almost_full_data  (),
        .almost_empty_data (),
        .in_startofpacket  (1'b0),
        .in_endofpacket    (1'b0),
        .out_startofpacket (),
        .out_endofpacket   (),
        .in_empty          (1'b0),
        .out_empty         ()
    );

    // soc_system_avalon_st_adapter #(
    //     .inBitsPerSymbol (32),
    //     .inUsePackets    (0),
    //     .inDataWidth     (32),
    //     .inChannelWidth  (0),
    //     .inErrorWidth    (0),
    //     .inUseEmptyPort  (0),
    //     .inUseValid      (1),
    //     .inUseReady      (0),
    //     .inReadyLatency  (0),
    //     .outDataWidth    (32),
    //     .outChannelWidth (8),
    //     .outErrorWidth   (8),
    //     .outUseEmptyPort (0),
    //     .outUseValid     (1),
    //     .outUseReady     (0),
    //     .outReadyLatency (0)
    // ) avalon_st_adapter (
    //     .in_clk_0_clk   (clk),                      // in_clk_0.clk
    //     .in_rst_0_reset (rst_controller_reset_out_reset),         // in_rst_0.reset
    //     .in_0_data      (adc_fifo_avalon_streaming_source_data),  //     in_0.data
    //     .in_0_valid     (adc_fifo_avalon_streaming_source_valid), //         .valid
    //     .out_0_data     (avalon_st_adapter_out_0_data),           //    out_0.data
    //     .out_0_valid    (avalon_st_adapter_out_0_valid),          //         .valid
    //     .out_0_error    (avalon_st_adapter_out_0_error),          //         .error
    //     .out_0_channel  (avalon_st_adapter_out_0_channel)         //         .channel
    // );

    initial begin
        forever #5 clk = ~clk;
    end

    initial
        #200 reset = 0;
endmodule