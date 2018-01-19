`timescale 1 ps / 1 ps
module pinger_simulator (
        input wire                 clk,
        input wire                 reset,

        input wire                 next_channel,
        output reg         [15:0]  adc_value,

        input wire         [11:0]  nco_sin_out,
        output reg         [31:0]  nco_phase_inc,

        input wire         [7:0]   pinger_param_channel,
        input wire         [31:0]  pinger_param_data
    );

    reg [31:0] wait_counter;
    reg [31:0] pingers_delay  [2:0];
    reg [2:0]  pingers_valid;
    reg [2:0]  pingers_were_active;
    reg [31:0] delay_counter;
    reg [31:0] ping_counter;
    reg [3:0]  current_channel;
    reg [7:0]  state;
    reg [31:0] wait_time;
    reg [31:0] ping_time;


    reg [31:0] wait_time_param;
    reg [31:0] ping_time_param;
    reg [31:0] nco_phase_inc_param;
    reg [31:0] pingers_delay_param [2:0];


    parameter WAIT_TIME      = 32'd99000000
            , PING_TIME      = 32'd1000000
            , PHASE_INC      = 32'd1288490 //30kHz

            , WAIT           = 8'd0
            , DELAY_AND_PING = 8'd1

            , MEM_SIM_DELAY_1 = 8'd8
            , MEM_SIM_DELAY_2 = 8'd12
            , MEM_SIM_DELAY_3 = 8'd16
            , MEM_SIM_PHASE_INC = 8'd20
            , MEM_SIM_PING_TIME = 8'd28
            , MEM_SIM_WAIT_TIME = 8'd32;


    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            wait_time_param <= WAIT_TIME;
            ping_time_param <= PING_TIME;
            nco_phase_inc_param <= PHASE_INC;
            pingers_delay_param[0] <= 32'd0;
            pingers_delay_param[1] <= 32'd0;
            pingers_delay_param[2] <= 32'd0;
        end else begin
            case (pinger_param_channel)
                MEM_SIM_WAIT_TIME:
                    begin
                        if (wait_time_param != pinger_param_data) begin
                            wait_time_param <= pinger_param_data;
                        end
                    end
                MEM_SIM_PING_TIME:
                    begin
                        if (ping_time_param != pinger_param_data) begin
                            ping_time_param <= pinger_param_data;
                        end
                    end
                MEM_SIM_PHASE_INC:
                    begin
                        if (nco_phase_inc_param != pinger_param_data) begin
                            nco_phase_inc_param <= pinger_param_data;
                        end
                    end
                MEM_SIM_DELAY_1:
                    begin
                        if (pingers_delay_param[0] != pinger_param_data) begin
                            pingers_delay_param[0] <= pinger_param_data;
                        end
                    end
                MEM_SIM_DELAY_2:
                    begin
                        if (pingers_delay_param[1] != pinger_param_data) begin
                            pingers_delay_param[1] <= pinger_param_data;
                        end
                    end
                MEM_SIM_DELAY_3:
                    begin
                        if (pingers_delay_param[2] != pinger_param_data) begin
                            pingers_delay_param[2] <= pinger_param_data;
                        end
                    end
            endcase
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            wait_counter <= 32'd0;
        end else begin
            if (wait_counter < wait_time) begin
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
            pingers_delay[0] <= 32'd0;
            pingers_delay[1] <= 32'd0;
            pingers_delay[2] <= 32'd0;
            wait_time <= WAIT_TIME;
            ping_time <= PING_TIME;
            nco_phase_inc <= PHASE_INC;
        end else begin
            case (state)
                WAIT:
                    begin
                        pingers_delay[0] <= pingers_delay_param[0];
                        pingers_delay[1] <= pingers_delay_param[1];
                        pingers_delay[2] <= pingers_delay_param[2];
                        wait_time <= wait_time_param;
                        ping_time <= ping_time_param;
                        nco_phase_inc <= nco_phase_inc_param;
                        if (wait_counter >= wait_time) begin
                            state <= DELAY_AND_PING;
                        end
                    end
                DELAY_AND_PING:
                    begin
                        if (pingers_were_active == 3'b111 && pingers_valid == 3'd0) begin
                            delay_counter <= 32'd0;
                            pingers_were_active <= 3'd0;
                            state <= WAIT;
                        end else begin
                            delay_counter <= delay_counter + 1;
                            if (delay_counter >= pingers_delay[0] && delay_counter < pingers_delay[0] + ping_time) begin
                                pingers_valid[0] <= 1'b1;
                                pingers_were_active[0] <= 1'b1;
                            end else begin
                                pingers_valid[0] <= 1'b0;
                            end
                            if (delay_counter >= pingers_delay[1] && delay_counter < pingers_delay[1] + ping_time) begin
                                pingers_valid[1] <= 1'b1;
                                pingers_were_active[1] <= 1'b1;
                            end else begin
                                pingers_valid[1] <= 1'b0;
                            end
                            if (delay_counter >= pingers_delay[2] && delay_counter < pingers_delay[2] + ping_time) begin
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
            current_channel <= 3'd0;
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