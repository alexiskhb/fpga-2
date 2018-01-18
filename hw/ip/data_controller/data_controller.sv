`timescale 1 ps / 1 ps

module data_controller (

    input wire clk,
    input wire reset,

    input wire                 adc_valid,
    input wire         [2:0]   adc_channel,
    input wire         [15:0]  adc_data,

    output reg                 fifo0_valid,
    output reg         [31:0]  fifo0_data,

    output reg         [31:0]  fifo0_csr_address,
    output reg                 fifo0_csr_read,
    input wire         [31:0]  fifo0_csr_readdata,
    input wire                 fifo0_csr_waitrequest,
    output reg                 fifo0_csr_write,
    output reg         [31:0]  fifo0_csr_writedata,

    output reg                 fifo1_valid,
    output reg         [31:0]  fifo1_data,

    output reg         [31:0]  fifo1_csr_address,
    output reg                 fifo1_csr_read,
    input wire         [31:0]  fifo1_csr_readdata,
    input wire                 fifo1_csr_waitrequest,
    output reg                 fifo1_csr_write,
    output reg         [31:0]  fifo1_csr_writedata,

    output reg                 fifo2_valid,
    output reg         [31:0]  fifo2_data,

    output reg         [31:0]  fifo2_csr_address,
    output reg                 fifo2_csr_read,
    input wire         [31:0]  fifo2_csr_readdata,
    input wire                 fifo2_csr_waitrequest,
    output reg                 fifo2_csr_write,
    output reg         [31:0]  fifo2_csr_writedata

    );

reg [15:0] buf_adc_data0;
reg [15:0] buf_adc_data1;
reg [15:0] buf_adc_data2;
reg [7:0] state0;
reg [7:0] state1;
reg [7:0] state2;


parameter VALUE_1 = 8'd0
        , VALUE_2 = 8'd1
        , SIZE_FIFO = 32'd128;


always @ (posedge clk or posedge reset)
begin
    if (reset) begin
        state0 <= VALUE_1;
        fifo0_csr_address                <= 4;
        fifo0_csr_writedata              <= SIZE_FIFO;
        fifo0_csr_write                  <= 1'b1;
        fifo0_data                       <= 0;
        fifo0_valid                      <= 0;
    end else begin
        case(state0)
            VALUE_1:
                begin
                    fifo0_valid <= 1'b0;
                    if (adc_valid == 1'b1 && adc_channel == 3'd0) begin
                        buf_adc_data0 <= adc_data;
                        state0 <= VALUE_2;
                    end 
                end
            VALUE_2:
                begin
                    if (adc_valid == 1'b1 && adc_channel == 3'd0) begin
                        fifo0_data <= {buf_adc_data0, adc_data};
                        fifo0_valid <= 1'b1;
                        state0 <= VALUE_1;
                    end
                end
        endcase
    end
end

always @ (posedge clk or posedge reset)
begin
    if (reset) begin
        state1 <= VALUE_1;
        fifo1_csr_address                <= 4;
        fifo1_csr_writedata              <= SIZE_FIFO;
        fifo1_csr_write                  <= 1'b1;
        fifo1_data                       <= 0;
        fifo1_valid                      <= 0;
    end else begin
        case(state1)
            VALUE_1:
                begin
                    fifo1_valid <= 1'b0;
                    if (adc_valid == 1'b1 && adc_channel == 3'd1) begin
                        buf_adc_data1 <= adc_data;
                        state1 <= VALUE_2;
                    end 
                end
            VALUE_2:
                begin
                    if (adc_valid == 1'b1 && adc_channel == 3'd1) begin
                        fifo1_data <= {buf_adc_data1, adc_data};
                        fifo1_valid <= 1'b1;
                        state1 <= VALUE_1;
                    end
                end
        endcase
    end
end

always @ (posedge clk or posedge reset)
begin
    if (reset) begin
        state2 <= VALUE_1;
        fifo2_csr_address                <= 4;
        fifo2_csr_writedata              <= SIZE_FIFO;
        fifo2_csr_write                  <= 1'b1;
        fifo2_data                       <= 0;
        fifo2_valid                      <= 0;
    end else begin
        case(state2)
            VALUE_1:
                begin
                    fifo2_valid <= 1'b0;
                    if (adc_valid == 1'b1 && adc_channel == 3'd2) begin
                        buf_adc_data2 <= adc_data;
                        state2 <= VALUE_2;
                    end 
                end
            VALUE_2:
                begin
                    if (adc_valid == 1'b1 && adc_channel == 3'd2) begin
                        fifo2_data <= {buf_adc_data2, adc_data};
                        fifo2_valid <= 1'b1;
                        state2 <= VALUE_1;
                    end
                end
        endcase
    end
end

endmodule