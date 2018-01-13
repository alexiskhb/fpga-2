/* note for avalon interface
    bus type: nagtive
    read legacy = 0 (to consistent to FIFO)

*/

module adc(
    // avalon slave port
    slave_clk,
    slave_reset,
    slave_chipselect,
    slave_address,
    slave_read,
    slave_readdata,

    //avalon stream port
    streaming_source_data,
    streaming_source_valid,
    streaming_source_channel,

    adc_clk, // max 40mhz
    // adc interface
    CONVST,
    SCK,
    SDI,
    SDO
);

    // avalon slave port
input                                   slave_clk;
input                                   slave_reset;
input                                   slave_chipselect;
input                                   slave_address;
input                                   slave_read;
output    reg             [15:0]        slave_readdata;

output    reg signed      [15:0]        streaming_source_data;
output    reg                           streaming_source_valid;
output    reg             [2:0]         streaming_source_channel;


input                                   adc_clk;

output                                  CONVST;
output                                  SCK;
output                                  SDI;
input                                   SDO;


`define READ_REG_ADC_VALUE              0

wire slave_read_data;
wire signed [11:0] measure_dataread;
wire measure_done;

assign slave_read_data = (~slave_chipselect && ~slave_read && slave_address == `READ_REG_ADC_VALUE) ?1'b1:1'b0;


always @ (posedge slave_clk)
begin
    if(slave_reset)
        streaming_source_valid <= 1'b0;
    else begin
        if(slave_read_data)
            slave_readdata <= {3'h0, streaming_source_data};
        if(measure_done) begin
            streaming_source_valid <= 1'b1;
            streaming_source_data <= $signed({4'd0, measure_dataread}) - 16'sh800;
            streaming_source_channel <= measure_ch;
        end else begin
            streaming_source_valid <= 1'b0;
        end
    end
end

////////////////////////////////////
// control measure_start

reg wait_measure_done = 1'b0;
reg measure_start = 1'b0;
reg [2:0] measure_ch = 3'd1;

always @ (posedge adc_clk or posedge slave_reset)
begin
    if (slave_reset)
    begin
        measure_start <= 1'b0;
        wait_measure_done <= 1'b0;
        measure_ch <= 3'd2;
    end
    else if (~measure_start & ~wait_measure_done)
    begin
        if (measure_ch == 3'd3) begin
            measure_ch <= 3'd1;
        end else begin
            measure_ch <= measure_ch + 1;
        end
        measure_start <= 1'b1;
        wait_measure_done <= 1'b1;
    end
    else if (wait_measure_done) // && measure_start)
    begin
        measure_start <= 1'b0;
        if (measure_done)
        begin
            wait_measure_done <= 1'b0;
        end
    end
end

///////////////////////////////////////
// SPI

adc_ltc2308 adc_ltc2308_inst(
    .clk(adc_clk), // max 40mhz

    // start measure
    .measure_start(measure_start), // posedge triggle
    .measure_done(measure_done),
    .measure_ch(measure_ch),
    .measure_dataread(measure_dataread),


    // adc interface
    .ADC_CONVST(CONVST),
    .ADC_SCK(SCK),
    .ADC_SDI(SDI),
    .ADC_SDO(SDO)
);

endmodule
