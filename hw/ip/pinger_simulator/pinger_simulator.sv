`timescale 1 ps / 1 ps
module pinger_simulator (
        input wire                 clk,
        input wire                 reset,

        input wire                 next_channel,
        output reg         [15:0]  adc_value,

        input wire         [11:0]  nco_sin_out,
        output reg         [31:0]  nco_phase_inc
    );

    reg [31:0] wait_counter;
    reg [31:0] pingers_delay  [2:0];
    reg [2:0]  pingers_valid;
    reg [2:0]  pingers_were_active;
    reg [31:0] delay_counter;
    reg [31:0] ping_counter;
    reg [3:0]  current_channel;
    reg [7:0]  state;

    parameter WAIT_TIME      = 32'd99000000
            , PING_TIME      = 32'd1000000
            , WAIT           = 8'd0
            , DELAY_AND_PING = 8'd1;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            wait_counter <= 32'd0;
        end else begin
            if (wait_counter < WAIT_TIME) begin
                wait_counter <= wait_counter + 1;
            end else begin
                wait_counter <= 32'd0;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            delay_counter <= 32'd0;
            pingers_were_active <= 3'd0;
            pingers_valid <= 3'd0;
            state <= WAIT;
            pingers_delay[0] = 32'd1000;
            pingers_delay[1] = 32'd0;
            pingers_delay[2] = 32'd3000;
        end else begin
            case (state)
                WAIT:
                    if (wait_counter >= WAIT_TIME) begin
                        state <= DELAY_AND_PING;
                    end
                DELAY_AND_PING:
                    begin
                        if (pingers_were_active == 3'b111 && pingers_valid == 3'd0) begin
                            delay_counter <= 32'd0;
                            pingers_were_active <= 3'd0;
                            state <= WAIT;
                        end else begin
                            delay_counter <= delay_counter + 1;
                            if (delay_counter >= pingers_delay[0] && delay_counter < pingers_delay[0] + PING_TIME) begin
                                pingers_valid[0] <= 1'b1;
                                pingers_were_active[0] <= 1'b1;
                            end else begin
                                pingers_valid[0] <= 1'b0;
                            end
                            if (delay_counter >= pingers_delay[1] && delay_counter < pingers_delay[1] + PING_TIME) begin
                                pingers_valid[1] <= 1'b1;
                                pingers_were_active[1] <= 1'b1;
                            end else begin
                                pingers_valid[1] <= 1'b0;
                            end
                            if (delay_counter >= pingers_delay[2] && delay_counter < pingers_delay[2] + PING_TIME) begin
                                pingers_valid[2] <= 1'b1;
                                pingers_were_active[2] <= 1'b1;
                            end else begin
                                pingers_valid[2] <= 1'b0;
                            end
                        end
                    end
            endcase // state
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            current_channel <= 3'd1;
        end else begin
            if (next_channel == 1'b1) begin
                if (current_channel == 3'd3) begin
                    current_channel <= 3'd1;
                end else begin
                    current_channel <= current_channel + 1;
                end
            end 
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            adc_value <= 16'd0;
            nco_phase_inc <= 32'd1288490; //30kHz
        end else begin
            if (pingers_valid[current_channel - 1] == 1'b1) begin
                if  (nco_sin_out[11] == 1'b1) begin
                    adc_value <= {4'b1111, nco_sin_out};
                end else begin
                    adc_value <= nco_sin_out;
                end
            end else begin
                adc_value <= 16'd0;
            end
        end
    end

endmodule //pinger_simulator