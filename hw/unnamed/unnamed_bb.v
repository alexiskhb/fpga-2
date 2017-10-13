
module unnamed (
	streaming_source_data,
	streaming_source_valid,
	CONVST,
	SCK,
	SDI,
	SDO,
	slave_clk,
	slave_readdata,
	slave_chipselect,
	slave_read,
	slave_address,
	slave_reset,
	adc_clk);	

	output	[12:0]	streaming_source_data;
	output		streaming_source_valid;
	output		CONVST;
	output		SCK;
	output		SDI;
	input		SDO;
	input		slave_clk;
	output	[15:0]	slave_readdata;
	input		slave_chipselect;
	input		slave_read;
	input		slave_address;
	input		slave_reset;
	input		adc_clk;
endmodule
