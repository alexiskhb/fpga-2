`timescale 1 ps / 1 ps
module hps_driver (
        input wire                  clk,
        input wire        [7:0]     address,
        input wire                  read_en,
        output reg        [31:0]    readdata,
        input wire                  write_en,
        input wire        [31:0]    writedata,
        input wire                  chipselect,
        output reg        [7:0]     data_tx,
        output reg                  wren_fifo_tx = 1'b0,
        output reg        [7:0]     size_fifo_tx,
        input                       ready_tx,
        output reg                  start_tx = 1'b0,
        input wire        [7:0]     data_rx,
        output reg                  rden_fifo_rx = 1'b0,
        input wire        [7:0]     size_fifo_rx,
        input wire        [7:0]     interrupt_id,
        output reg                  irq = 1'b0,
        output reg                  navig_timer_start = 1'b0,
        output reg        [7:0]     led,
        output reg        [31:0]    rx_threshold = 32'd600,
        output reg        [31:0]    comp_threshold = 32'd6,
        output reg        [31:0]    guard_interval,
        output reg        [31:0]    mem_addr = 32'd0,
        input wire        [31:0]    end_address
    );

localparam  memory_size =               8'h00,
            memory_data =               8'h04,
            memory_next_tx =            8'h08,
            memory_ready =              8'h0c,
            memory_type =               8'h10,
            memory_start_tx =           8'h14,
            memory_start_navig =        8'h18,
            memory_size_rx =            8'h1c,
            memory_data_rx =            8'h20,
            memory_next_rx =            8'h24,
            memory_get_rx_threshold =   8'h28,
            memory_get_comp_threshold = 8'h2c,
            memory_get_guard_interval = 8'h30,
            memory_set_rx_threshold =   8'h34,
            memory_set_comp_threshold = 8'h38,
            memory_set_guard_interval = 8'h3c,
            memory_set_mem_addr =       8'h40,
            memory_get_end_address =    8'h44;

localparam  D_D =                   8'h01,
            N_A =                   8'h02,
            N_T =                   8'h03,
            N_Q =                   8'h04;

reg         [7:0]                   data_type = 8'd0;

always @ (posedge clk) begin    
    if (chipselect) begin
        if(write_en) begin
            case(address)
                memory_data: begin					 
					     led <= writedata[7:0];
						  irq <= 1'b1;
					 end
            endcase
        end else 
	     if (read_en) begin
		      case(address)
				    memory_size : irq <= 1'b0;
				endcase	 
	     end 
    end 
end


endmodule
