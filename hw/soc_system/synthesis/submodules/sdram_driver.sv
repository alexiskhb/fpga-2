`timescale 1 ps / 1 ps
module sdram_driver (
        input wire                  clk,
        output reg        [31:0]    address,
        output reg                  write_en,
        output reg        [63:0]    writedata,
        input wire                  waitrequest,
        input wire        [31:0]    data,
        input wire        [7:0]     interrupt_id,
        input wire        [31:0]    mem_addr,
        output reg        [31:0]    end_address
    );

localparam CNT_INTERVAL = 223;
localparam RBUF_SIZE = 20000;

int unsigned cnt, data_cnt;

logic cnt_reset;
assign cnt_reset = ((cnt + 1) >= CNT_INTERVAL);

always @ (posedge clk) begin
    if(!waitrequest) begin
        if(cnt_reset) begin
            write_en <= 1'b1;
            address <= mem_addr + data_cnt;
            writedata <= {32'd0, data};
        end else begin
            write_en <= 1'b0;
        end
    end
end

always @ (posedge clk) begin
    if(interrupt_id) begin
        end_address <= data_cnt;
    end
end

always @ (posedge clk) begin
    cnt <= cnt + 1'b1;
    if(cnt_reset) begin
        cnt <= 0;
        if(data_cnt >= RBUF_SIZE) begin
            data_cnt <= 0;
        end else begin
            data_cnt <= data_cnt + 2;
        end
    end
end

endmodule
