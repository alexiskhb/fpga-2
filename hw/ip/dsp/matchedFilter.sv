module m_filter #(
parameter DETECTOR_COEFFS_NUM = 28,
parameter DETECTOR_COEFFS = 28'b0100101101110111011100001110,
parameter DELAY_STEP = 5,                    //40kHz / 4kHz, 4kHz - symbol frequency
parameter MAX_COUNT = 2500                 //    (100MHz / 40kHz)
) (    
    input                                                   clk,
    input signed            [31:0]                          data_in,
    output reg signed       [31:0]                          data_out);

    


    integer j;


    reg signed              [DETECTOR_COEFFS_NUM - 1:0][31:0]       data_delayed;
    wire                    [DETECTOR_COEFFS_NUM - 1:0]             fifo_rd_en;
    reg                     [31:0]                                  cnt = 16'h0000;
    reg signed              [31:0]                                  data_buf;
    reg                                                             clk_1 = 1'b0;



        altshift_taps   ALTSHIFT_TAPS_component (
            .clock (clk_1),
            .shiftin (data_in),
            .shiftout (),
            .taps (data_delayed[DETECTOR_COEFFS_NUM - 1:1]),
            .aclr (),
            .clken (),
            .sclr ());

        defparam
            ALTSHIFT_TAPS_component.intended_device_family = "Cyclone V",
            ALTSHIFT_TAPS_component.lpm_hint = "RAM_BLOCK_TYPE=AUTO",
            ALTSHIFT_TAPS_component.lpm_type = "altshift_taps",
            ALTSHIFT_TAPS_component.number_of_taps = DETECTOR_COEFFS_NUM - 1,
            ALTSHIFT_TAPS_component.tap_distance = DELAY_STEP,
            ALTSHIFT_TAPS_component.width = 32;

    always @(posedge clk_1)
    begin
        data_buf = 32'd0;
        data_delayed[0] = data_in;
        for(j = 0; j < DETECTOR_COEFFS_NUM; j = j + 1)
            data_buf = $signed(data_buf) + $signed(data_delayed[j]) * $signed(DETECTOR_COEFFS[j] ? 1 : -1);
        data_out = data_buf;
    end

    always @(posedge clk)
    begin
        if((cnt + 1'b1) == MAX_COUNT)
        begin
            clk_1 <= ~clk_1;
            cnt <= 32'd0;
        end else begin
            cnt <= cnt + 1'b1;
        end
    end
endmodule
