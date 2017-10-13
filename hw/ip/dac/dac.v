`timescale 1ns / 1ps

module dac(
	input 							clk,
	input							dac_clk,
	input							reset,
	input					[7:0] 	streaming_sink_data,
	input 							streaming_sink_valid,
	output 						 	SCLK,
	output reg					 	SYNC,
	output reg					 	DIN
    );

	assign SCLK = dac_clk;

	reg 	 			[4:0]	 cnt = 5'd16;
	reg					[16:0]   data;

	always @ (posedge dac_clk or posedge reset)
	begin
		if (reset) begin
			cnt <= 5'd16;
			SYNC <= 1'b1;
		end
		else begin
			cnt <= cnt - 1'b1;
			DIN <= data[cnt];
			SYNC <= 1'b0;
			if (!cnt) begin
				SYNC <= 1'b1;
				cnt <= 5'd16;
			end
		end
	end

	always @(posedge clk or posedge reset) 
	begin
		if(reset) begin
			data <= 17'd0;
		end
		else if (!cnt && streaming_sink_valid) begin
			data = {5'b00000, streaming_sink_data[7:0], 4'h0};
		end
	end

endmodule