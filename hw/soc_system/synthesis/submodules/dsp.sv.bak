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
        output wire        [7:0]   led,                    //                        .led
        output reg         [7:0]   pins,                   //                        .led
        output wire                irq                     //                        .irq
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

    assign data_in = {1'b0, coder_data_out, 4'd0};//ready_tx ? streaming_sink_data : 13'd0;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            streaming_source_valid <= 1'b0;
        end
        else begin
            streaming_source_valid <= 1'b1;
            pins[0] <= coder_data_out[7];
            streaming_source_data <= test[13:6] ^ 8'h80;
        end
    end

    fir_ex fir28_inst (
        .clk              (clk),
        .reset_n          (~reset),
        .ast_sink_data    (data_in),
        .ast_sink_valid   (1'b1),
        .ast_source_data  (fir_sink_data),
        .ast_source_valid (fir_sink_valid)
    );

    coder_tx coder_tx_inst (
        .clk              (clk),
        .start            (start_tx),
        .ready            (ready_tx),
        .data_out         (coder_data_out),
        .data_in          (data_fifo_tx),
        .data_in_rden     (rden_fifo_tx),
        .data_in_size     (size_fifo_tx),
        .guard_interval   (guard_interval)
    );

    decoder_rx decoder_rx_inst (
        .clk              (clk),
        .reset            (reset),
        .data_valid       (fir_sink_valid),
        .data_in          (fir_sink_data),
        .data_out         (data_rx),
        .ram_wr_en        (wren_fifo_rx),
        .size             (size_fifo_rx),
        .interrupt_id     (interrupt_id),
        .navig_timer_start(navig_timer_start),
        .test             (test),
        .led              (),
        .rx_threshold     (rx_threshold),
        .comp_threshold   (comp_threshold),
        .guard_interval   (guard_interval)
    );

    hps_driver hps_driver_inst (
        .clk                (clk),
        .address            (slave_address),
        .read_en            (slave_read),
        .readdata           (slave_readdata),
        .write_en           (slave_write),
        .writedata          (slave_writedata),
        .chipselect         (slave_chipselect),
        .data_tx            (data_tx),
        .wren_fifo_tx       (wren_fifo_tx),
        .size_fifo_tx       (size_fifo_tx),
        .ready_tx           (ready_tx),
        .start_tx           (start_tx),
        .data_rx            (data_fifo_rx),
        .rden_fifo_rx       (rden_fifo_rx),
        .size_fifo_rx       (size_fifo_rx),
        .interrupt_id       (interrupt_id),
        .irq                (irq),
        .navig_timer_start  (navig_timer_start),
        .led                (led),
        .rx_threshold       (rx_threshold),
        .comp_threshold     (comp_threshold),
        .guard_interval     (guard_interval),
        .mem_addr           (mem_addr),
        .end_address        (end_address)
    );

    sdram_driver sdram_driver_inst (
        .clk                (clk),
        .address            (sdram0_address),
        .write_en           (sdram0_write),
        .writedata          (sdram0_writedata),
        .waitrequest        (sdram0_waitrequest),
        .data               (test),
        .interrupt_id       (interrupt_id),
        .mem_addr           (mem_addr),
        .end_address        (end_address)
    );


    scfifo    tx_fifo (
                .clock              (clk),
                .data               (data_tx),
                .rdreq              (rden_fifo_tx),
                .wrreq              (wren_fifo_tx),
                .q                  (data_fifo_tx),
                .aclr               (),
                .almost_empty       (),
                .almost_full        (),
                .eccstatus          (),
                .empty              (),
                .full               (),
                .sclr               (),
                .usedw              ());
            defparam
                tx_fifo.add_ram_output_register = "OFF",
                tx_fifo.intended_device_family = "Cyclone V",
                tx_fifo.lpm_numwords = 256,
                tx_fifo.lpm_showahead = "OFF",
                tx_fifo.lpm_type = "scfifo",
                tx_fifo.lpm_width = 8,
                tx_fifo.lpm_widthu = 8,
                tx_fifo.overflow_checking = "OFF",
                tx_fifo.underflow_checking = "OFF",
                tx_fifo.use_eab = "ON";

    scfifo  rx_fifo (
                .clock              (clk),
                .data               (data_rx),
                .rdreq              (rden_fifo_rx),
                .wrreq              (wren_fifo_rx),
                .q                  (data_fifo_rx),
                .aclr               (),
                .almost_empty       (),
                .almost_full        (),
                .eccstatus          (),
                .empty              (),
                .full               (),
                .sclr               (),
                .usedw              ());
            defparam
                rx_fifo.add_ram_output_register = "OFF",
                rx_fifo.intended_device_family = "Cyclone V",
                rx_fifo.lpm_numwords = 256,
                rx_fifo.lpm_showahead = "OFF",
                rx_fifo.lpm_type = "scfifo",
                rx_fifo.lpm_width = 8,
                rx_fifo.lpm_widthu = 8,
                rx_fifo.overflow_checking = "OFF",
                rx_fifo.underflow_checking = "OFF",
                rx_fifo.use_eab = "ON";

endmodule


module coder_tx (
    input                                               clk,
    input                                               start,
    output reg                                          ready,
    output reg              [7:0]                       data_out,
    input                   [7:0]                       data_in,
    output reg                                          data_in_rden = 1'b0,
    input                   [7:0]                       data_in_size,
    input                   [31:0]                      guard_interval);

    parameter                           GUARD_DELAY =               32'd112;
    parameter                           PREAMB_SIZE =               16'd5;
    parameter                           SIN_PER_CHIP =              16'd7;
    parameter                           BARKER_SIZE =               16'd29;
    parameter [0:1][BARKER_SIZE - 1:0]  DIF_COEFFS =                {29'b11010000010110100101101100011, 29'b10000101000011110000111001001};//{14'b01010111011001, 14'b11111101110011};
    parameter                           PREAMB =                    5'b11101;

    localparam  CNT_INTERVAL            = 223;
    localparam  GUARD_INTERVAL          = 30;

    localparam  wait_for_data           = 4'd0, 
                sending_preamb          = 4'd1,
                sending_data            = 4'd2;

    localparam [0:15][7:0] mysin = {8'd128, 8'd176, 8'd218, 8'd245, 8'd255, 8'd245, 8'd218, 8'd176, 8'd127, 8'd79, 8'd37, 8'd10, 8'd0, 8'd10, 8'd37, 8'd79};


    reg                     [31:0]                      cnt = 0;
    reg                     [3:0]                       state = wait_for_data;
    reg                     [3:0]                       next_state = wait_for_data;
    reg                                                 start_guard = 1'b0;

    reg                     [3:0]                       phase = 4'd0;
    reg                     [15:0]                      sin_cnt = 16'd0;
    reg                     [15:0]                      chip_cnt = 16'd0;
    reg                     [15:0]                      bit_cnt = 16'd0;
    reg                     [15:0]                      byte_cnt = 16'd0;
    reg                     [31:0]                      guard_cnt = 32'd0;

    reg                     [15:0]                      bits_size = 16'd8;
    reg                     [7:0]                       data_size = 8'd0;
    reg                     [7:0]                       tx_data = 8'd0;

    reg                                                 waiting_cnt_reset = 1'b0;

    reg                                                 data_in_rden_reset = 1'b0;

    reg pre_start;
    always @ (posedge clk)
    begin
        pre_start <= start;
    end

    wire start_edge;
    assign start_edge = (~pre_start & start)?1'b1:1'b0;

    logic cnt_reset;
    assign cnt_reset = ((cnt + 1) >= CNT_INTERVAL);

    always @(posedge clk)
    begin
        case(state)
            wait_for_data:
                if (start_edge) begin
                    state <= sending_preamb;
                    waiting_cnt_reset <= 1'b1;
                    phase <= 4'd0;
                    sin_cnt <= 16'd0;
                    chip_cnt <= 16'd0;
                    bit_cnt <= 16'd0;
                    byte_cnt <= 16'd0;
                    data_out <= mysin[0];
                    ready <= 0;
                end else begin
                    data_out <= 8'd128;
                    ready <= 1;
                end

            sending_preamb:
                begin
                    waiting_cnt_reset <= 1'b0;
                    next_state <= sending_data;
                    bits_size <= PREAMB_SIZE;
                    tx_data <= {{(8 - PREAMB_SIZE){1'b0}}, PREAMB};
                    data_size <= 8'd1;
                end

            sending_data:
                begin
                    next_state <= wait_for_data;
                    bits_size <= 16'd8;
                    data_size <= data_in_size;
                end
        endcase

        if(data_in_rden || data_in_rden_reset) begin
            data_in_rden <= 0;
            if(data_in_rden_reset) begin
                tx_data <= data_in;
                data_in_rden_reset <= 1'b0;
            end else
                data_in_rden_reset <= 1'b1;
        end

        if(state != wait_for_data) begin
            if(cnt_reset) begin
                if(phase == 4'hf) begin
                    if((sin_cnt + 1'b1) == SIN_PER_CHIP) begin
                        sin_cnt <= 16'd0;
                        if((chip_cnt + 1'b1) == BARKER_SIZE) begin
                            chip_cnt <= 16'd0;
                            start_guard <= 1'b1;
                            if((bit_cnt + 1'b1) == bits_size) begin
                                bit_cnt <= 16'd0;
                                if((byte_cnt + 1'b1) == data_size) begin
                                    byte_cnt <= 16'd0;
                                    state <= next_state;
                                    if(state == sending_preamb)
                                        data_in_rden <= 1'b1;
                                end else begin
                                    data_in_rden <= 1'b1;
                                    byte_cnt <= byte_cnt + 1'b1;
                                end
                            end else
                                bit_cnt <= bit_cnt + 1'b1;
                        end else
                            chip_cnt <= chip_cnt + 1'b1;
                    end else
                        sin_cnt <= sin_cnt + 1'b1;
                end
                if(~start_guard) begin
                    phase <= phase + 1'b1;
                    data_out <= (1 ^ DIF_COEFFS[tx_data[bit_cnt]][chip_cnt]) ? mysin[phase] : (8'd255 - mysin[phase]);
                end else begin
                    if((guard_cnt + 1'b1) == (GUARD_DELAY * GUARD_INTERVAL)) begin
                        guard_cnt <= 0;
                        start_guard <= 0;
                    end else begin
                        guard_cnt <= guard_cnt + 1'b1;
                    end
                    data_out <= 8'd128;
                end
            end
        end
    end

    always @(posedge clk) begin
       cnt <= cnt + 1;
       if(cnt_reset || waiting_cnt_reset) begin // 100MHz / (28kHz * 16) = 223
           cnt <= 0;
       end
    end

endmodule


module decoder_rx (
        input                                               clk,
        input                                               reset,
        input                                               data_valid,
        input signed            [31:0]                      data_in,
        output reg              [7:0]                       data_out,
        output reg                                          ram_wr_en = 1'b0,
        output reg              [7:0]                       size,
        output reg              [7:0]                       interrupt_id = 8'd0,
        input                                               navig_timer_start,
        output signed           [31:0]                      test,
        output reg              [7:0]                       led,
        input signed            [31:0]                      rx_threshold,
        input signed            [31:0]                      comp_threshold,
        input                   [31:0]                      guard_interval
    );

    localparam  SYMBOL_INTERVAL =       590;
    localparam  CNT_INTERVAL =          2500;
    localparam  PROCESSING_DELAY =      10;

    localparam  D_D =                   8'h01,
                N_A =                   8'h02,
                N_T =                   8'h03,
                N_Q =                   8'h04;

    localparam  wait_for_signal =       8'd0,
                processing_delay =      8'd1,
 //               send_interrupt =        8'd2,
                read_byte =             8'd3,
                read_type =             8'd4,
                read_size =             8'd5,
                read_data =             8'd6,
                navig_calc =            8'd7,
                send_answer =           8'd8;

    localparam int WAIT_NAVIG_TIMEOUT =    32'd2000000000;

    parameter                           PREAMB_SIZE =               16'd5;
    parameter                           BARKER_SIZE =               16'd29;

    reg                     [7:0]                       state = wait_for_signal;
    reg                     [7:0]                       next_state = wait_for_signal;

    wire signed             [31:0]                      mult_delay_data_out;
    reg signed              [15:0]                      input_data;

    wire signed             [31:0]                      data_out_fir;
    wire                                                data_valid_fir;

    reg signed              [31:0]                      data_in_mf;

    wire signed             [31:0]                      data_out_mf0;
    wire signed             [31:0]                      data_out_mf1;

    reg                     [31:0]                      cnt = 0;
    reg                     [31:0]                      data_cnt = 0;
    reg                     [15:0]                      bit_cnt = 0;
    reg                     [15:0]                      byte_cnt = 0;
    reg signed              [31:0]                      wait_navig_cnt = 0;

    reg                                                 main_cnt_reset = 1'b0;

    reg signed              [35:0]                      data_sum = 0;
    reg                     [7:0]                       received_byte = 8'd0;
    
    assign test = data_in_mf;

    wire pre_wait_cnt;
    wire wait_navig;
    assign wait_navig = (wait_navig_cnt != 0);

    logic cnt_reset;
    assign cnt_reset = ((cnt + 1) == CNT_INTERVAL);

    reg pre_wait_navig_cnt;
    always @ (posedge clk)  
    begin
        pre_wait_navig_cnt <= wait_navig;
        if(wait_navig || navig_timer_start) begin
            if(state != navig_calc) begin
                if(wait_navig_cnt < WAIT_NAVIG_TIMEOUT) begin
                    wait_navig_cnt <= wait_navig_cnt + 1'b1;
                end
                else begin
                    wait_navig_cnt <= 0;
                end
            end else begin
                wait_navig_cnt <= (wait_navig_cnt >> 4'd8);
            end
        end
    end

    wire navig_timeout;
    assign navig_timeout = (pre_wait_navig_cnt & ~wait_navig)?1'b1:1'b0;

    always @(posedge clk)
    begin
        if(data_valid) begin
            input_data <= $signed(data_in[31:16]) < $signed(comp_threshold) ? ($signed(data_in[31:16]) > $signed(-comp_threshold) ? 0 : -8) : 8;
        end

        if(data_valid_fir) begin
            data_in_mf <= data_out_fir;
        end
    end

    always @(posedge clk)
    begin
        case(state)
            wait_for_signal:        
                begin
                    ram_wr_en <= 1'b0;

                    if(data_out_mf1 >= rx_threshold) begin
                        state <= processing_delay;
                        main_cnt_reset = 1'b1;
                        data_cnt <= 0;
                    end
                    else if(navig_timeout) begin
                        interrupt_id <= N_T;
                    end
                end

            processing_delay:
                begin
                    main_cnt_reset = 1'b0;
                    if(cnt_reset) begin
                        data_cnt <= data_cnt + 1;
                    end

                    if((data_cnt + 1) >= PROCESSING_DELAY) begin               
                        state <= read_byte;
                        next_state <= read_type;
                        data_cnt <= 0;
                        bit_cnt <= 0;
                        byte_cnt <= 0;
                        data_sum <= 0;
                    end 
                end
        
            read_byte:
                begin
                    ram_wr_en <= 1'b0;
                    if(cnt_reset) begin
                        if(((data_cnt + 1) >= (SYMBOL_INTERVAL - PROCESSING_DELAY)) && ((data_cnt + 1) < SYMBOL_INTERVAL)) begin
                            data_cnt <= data_cnt + 1;
                            data_sum <= data_sum + data_out_mf0;
                        end else if((data_cnt + 1) == SYMBOL_INTERVAL) begin
                            bit_cnt <= bit_cnt + 1'b1;
                            received_byte[bit_cnt] <= (data_sum < $signed(0)) ? 1'b0 : 1'b1;
                            data_cnt <= 0;
                            data_sum <= 0;
                        end else begin
                            data_cnt <= data_cnt + 1;
                        end
                    end

                    if(bit_cnt == 8) begin
                        data_cnt <= 0;
                        bit_cnt <= 0;
                        byte_cnt <= byte_cnt + 1'b1;
                        state <= next_state;
                    end
                end

            read_type:
                begin
                    next_state <= read_size;
                    state <=    (received_byte == D_D) ? read_byte :
                                (received_byte == N_A) ? navig_calc :
                                (received_byte == N_Q) ? send_answer : wait_for_signal;
                end

            read_size:
                begin
                    size <= received_byte;
                    state <= read_byte;
                    next_state <= read_data;
                end

            read_data:
                begin
                    data_out <= received_byte;
                    ram_wr_en <= 1'b1;
                    if((byte_cnt - 2'd2) >= size) begin
                        interrupt_id <= D_D;
                        state <= wait_for_signal;
                    end else begin
                        state <= read_byte;
                    end
                end

            navig_calc:
                begin
                    led <= led + 1'b1;
                    if(byte_cnt < 15'd5) begin
                        byte_cnt <= byte_cnt + 1'b1;
                        data_out <= wait_navig_cnt[7:0];
                        ram_wr_en <= 1'b1;
                    end else begin
                        state <= wait_for_signal;
                        ram_wr_en <= 1'b0;
                        size <= 8'd4;
                        interrupt_id <= N_A;
                    end
                end

            send_answer:
                begin
                    interrupt_id <= N_Q;
                    state <= wait_for_signal;
                end

            endcase

            if(interrupt_id) begin
                interrupt_id <= 8'd0;
            end
    end

    always @(posedge clk) begin
        if(cnt_reset || main_cnt_reset) begin // 100MHz / 40kHz = 2500
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
        end
    end

    mult_delay mult_delay_preamb (.clk      (clk),
                                  .data_in  (input_data),
                                  .data_out (mult_delay_data_out));

    fir_in fir_lpf_inst  (.clk              (clk),
                          .reset_n          (~reset),
                          .ast_sink_data    (mult_delay_data_out),
                          .ast_sink_valid   (data_valid),
                          .ast_source_data  (data_out_fir),
                          .ast_source_valid (data_valid_fir));

    m_filter m_filter_inst0 (.clk            (clk),
                             .data_in        (data_in_mf),
                             .data_out       (data_out_mf0));

    m_filter m_filter_inst1 (.clk            (clk),
                             .data_in        (data_out_mf0),
                             .data_out       (data_out_mf1));
    defparam m_filter_inst1.DETECTOR_COEFFS = 5'b10111,
             m_filter_inst1.DETECTOR_COEFFS_NUM = 5,
             m_filter_inst1.DELAY_STEP = 295,                 // DETECTOR_COEFFS_NUM * (dif_coef_size + 1)    , dif_coef_size = 14
             m_filter_inst1.MAX_COUNT = 2500;                 // (100MHz / 20kHz), 20kHz - frequency of matched filter

endmodule


module mult_delay (
    input                           clk,
    input signed            [15:0]  data_in,
    output signed           [31:0]  data_out);

    parameter CNTR_DELAY = 50;

    reg                     [31:0]  cnt = 32'd0;
    reg                             clk_1 = 1'b0;

    wire signed             [15:0]  data_delayed;


    lpm_mult lpm_mult_inst0    (.dataa(data_in),
                                .datab(data_delayed),
                                .result(data_out),
                                .aclr(1'b0),
                                .clken(1'b1),
                                .clock(1'b0),
                                .sclr(1'b0),
                                .sum(1'b0));
    defparam
        lpm_mult_inst0.lpm_hint = "DEDICATED_MULTIPLIER_CIRCUITRY=YES,MAXIMIZE_SPEED=5",
        lpm_mult_inst0.lpm_representation = "SIGNED",
        lpm_mult_inst0.lpm_type = "LPM_MULT",
        lpm_mult_inst0.lpm_widtha = 16,
        lpm_mult_inst0.lpm_widthb = 16,
        lpm_mult_inst0.lpm_widthp = 32;

    always @(posedge clk)
    begin
        if((cnt + 1'b1) == CNTR_DELAY)
        begin
            clk_1 <= ~clk_1;
            cnt <= 32'd0;
        end else begin
            cnt <= cnt + 1'b1;
        end
    end

    altshift_taps   ALTSHIFT_TAPS_component (
                .clock (clk_1),
                .shiftin (data_in),
                .shiftout (data_delayed),
                .taps (),
                .aclr (),
                .clken (),
                .sclr ());

    defparam
        ALTSHIFT_TAPS_component.intended_device_family = "Cyclone V",
        ALTSHIFT_TAPS_component.lpm_hint = "RAM_BLOCK_TYPE=AUTO",
        ALTSHIFT_TAPS_component.lpm_type = "altshift_taps",
        ALTSHIFT_TAPS_component.number_of_taps = 1,
        ALTSHIFT_TAPS_component.tap_distance = 250,
        ALTSHIFT_TAPS_component.width = 16;
endmodule
