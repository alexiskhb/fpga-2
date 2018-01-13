`timescale 1 ps / 1 ps

module data_controller (

    input wire clk,
    input wire reset,

    input wire                 adc_valid,
    input wire         [2:0]   adc_channel,
    input wire         [15:0]  adc_data

    output reg                 fifo0_in_valid,
    output reg         [31:0]  fifo0_in_data,

    output reg         [31:0]  fifo0_csr_address,
    output reg                 fifo0_csr_read,
    input wire         [31:0]  fifo0_csr_readdata,
    input wire                 fifo0_csr_waitrequest,
    output reg                 fifo0_csr_write,
    output reg         [31:0]  fifo0_csr_writedata,

    );

reg [15:0] buf_adc_data;
reg [7:0] state;
reg [31:0] cntr_in;


parameter VALUE_1 = 8'd0
        , VALUE_2 = 8'd1
        , SIZE_FIFO = 32'd128;


always @ (posedge clk or posedge reset)
begin
    if (reset) begin
        state <= VALUE_1;
        fifo0_csr_address                <= 4;
        fifo0_csr_writedata              <= SIZE_FIFO;
        fifo0_csr_write                  <= 1'b1;
        fifo0_in_data                    <= 0;
        fifo0_in_valid                   <= 0;
    end else begin
        case(state)
            VALUE_1:
                begin
                    if (adc_valid) begin
                        buf_adc_data <= adc_data;
                        state <= VALUE_2;
                    end 
                end
            VALUE_2:
                begin
                    if (adc_valid) begin
                        fifo0_in_data <= {buf_adc_data, adc_data};
                        state <= VALUE_1
                    end
                end
        endcase
    end
end

endmodule