`timescale 1 ps / 1 ps

// Latency: 403
// Gap: 128
// module_name_is:dft_top
module dft_top(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [15:0] t0_0;
   wire [15:0] t0_1;
   wire [15:0] t0_2;
   wire [15:0] t0_3;
   wire next_0;
   wire [15:0] t1_0;
   wire [15:0] t1_1;
   wire [15:0] t1_2;
   wire [15:0] t1_3;
   wire next_1;
   wire [15:0] t2_0;
   wire [15:0] t2_1;
   wire [15:0] t2_2;
   wire [15:0] t2_3;
   wire next_2;
   wire [15:0] t3_0;
   wire [15:0] t3_1;
   wire [15:0] t3_2;
   wire [15:0] t3_3;
   wire next_3;
   wire [15:0] t4_0;
   wire [15:0] t4_1;
   wire [15:0] t4_2;
   wire [15:0] t4_3;
   wire next_4;
   wire [15:0] t5_0;
   wire [15:0] t5_1;
   wire [15:0] t5_2;
   wire [15:0] t5_3;
   wire next_5;
   wire [15:0] t6_0;
   wire [15:0] t6_1;
   wire [15:0] t6_2;
   wire [15:0] t6_3;
   wire next_6;
   wire [15:0] t7_0;
   wire [15:0] t7_1;
   wire [15:0] t7_2;
   wire [15:0] t7_3;
   wire next_7;
   wire [15:0] t8_0;
   wire [15:0] t8_1;
   wire [15:0] t8_2;
   wire [15:0] t8_3;
   wire next_8;
   wire [15:0] t9_0;
   wire [15:0] t9_1;
   wire [15:0] t9_2;
   wire [15:0] t9_3;
   wire next_9;
   wire [15:0] t10_0;
   wire [15:0] t10_1;
   wire [15:0] t10_2;
   wire [15:0] t10_3;
   wire next_10;
   wire [15:0] t11_0;
   wire [15:0] t11_1;
   wire [15:0] t11_2;
   wire [15:0] t11_3;
   wire next_11;
   wire [15:0] t12_0;
   wire [15:0] t12_1;
   wire [15:0] t12_2;
   wire [15:0] t12_3;
   wire next_12;
   wire [15:0] t13_0;
   wire [15:0] t13_1;
   wire [15:0] t13_2;
   wire [15:0] t13_3;
   wire next_13;
   wire [15:0] t14_0;
   wire [15:0] t14_1;
   wire [15:0] t14_2;
   wire [15:0] t14_3;
   wire next_14;
   wire [15:0] t15_0;
   wire [15:0] t15_1;
   wire [15:0] t15_2;
   wire [15:0] t15_3;
   wire next_15;
   wire [15:0] t16_0;
   wire [15:0] t16_1;
   wire [15:0] t16_2;
   wire [15:0] t16_3;
   wire next_16;
   wire [15:0] t17_0;
   wire [15:0] t17_1;
   wire [15:0] t17_2;
   wire [15:0] t17_3;
   wire next_17;
   wire [15:0] t18_0;
   wire [15:0] t18_1;
   wire [15:0] t18_2;
   wire [15:0] t18_3;
   wire next_18;
   wire [15:0] t19_0;
   wire [15:0] t19_1;
   wire [15:0] t19_2;
   wire [15:0] t19_3;
   wire next_19;
   wire [15:0] t20_0;
   wire [15:0] t20_1;
   wire [15:0] t20_2;
   wire [15:0] t20_3;
   wire next_20;
   wire [15:0] t21_0;
   wire [15:0] t21_1;
   wire [15:0] t21_2;
   wire [15:0] t21_3;
   wire next_21;
   wire [15:0] t22_0;
   wire [15:0] t22_1;
   wire [15:0] t22_2;
   wire [15:0] t22_3;
   wire next_22;
   wire [15:0] t23_0;
   wire [15:0] t23_1;
   wire [15:0] t23_2;
   wire [15:0] t23_3;
   wire next_23;
   wire [15:0] t24_0;
   wire [15:0] t24_1;
   wire [15:0] t24_2;
   wire [15:0] t24_3;
   wire next_24;
   assign t0_0 = X0;
   assign Y0 = t24_0;
   assign t0_1 = X1;
   assign Y1 = t24_1;
   assign t0_2 = X2;
   assign Y2 = t24_2;
   assign t0_3 = X3;
   assign Y3 = t24_3;
   assign next_0 = next;
   assign next_out = next_24;

// latency=116, gap=128
   rc53791 stage0(.clk(clk), .reset(reset), .next(next_0), .next_out(next_1),
    .X0(t0_0), .Y0(t1_0),
    .X1(t0_1), .Y1(t1_1),
    .X2(t0_2), .Y2(t1_2),
    .X3(t0_3), .Y3(t1_3));


// latency=2, gap=128
   codeBlock53793 stage1(.clk(clk), .reset(reset), .next_in(next_1), .next_out(next_2),
       .X0_in(t1_0), .Y0(t2_0),
       .X1_in(t1_1), .Y1(t2_1),
       .X2_in(t1_2), .Y2(t2_2),
       .X3_in(t1_3), .Y3(t2_3));


// latency=4, gap=128
   rc53874 stage2(.clk(clk), .reset(reset), .next(next_2), .next_out(next_3),
    .X0(t2_0), .Y0(t3_0),
    .X1(t2_1), .Y1(t3_1),
    .X2(t2_2), .Y2(t3_2),
    .X3(t2_3), .Y3(t3_3));


// latency=8, gap=128
   DirSum_54055 stage3(.next(next_3), .clk(clk), .reset(reset), .next_out(next_4),
       .X0(t3_0), .Y0(t4_0),
       .X1(t3_1), .Y1(t4_1),
       .X2(t3_2), .Y2(t4_2),
       .X3(t3_3), .Y3(t4_3));


// latency=2, gap=128
   codeBlock54058 stage4(.clk(clk), .reset(reset), .next_in(next_4), .next_out(next_5),
       .X0_in(t4_0), .Y0(t5_0),
       .X1_in(t4_1), .Y1(t5_1),
       .X2_in(t4_2), .Y2(t5_2),
       .X3_in(t4_3), .Y3(t5_3));


// latency=5, gap=128
   rc54139 stage5(.clk(clk), .reset(reset), .next(next_5), .next_out(next_6),
    .X0(t5_0), .Y0(t6_0),
    .X1(t5_1), .Y1(t6_1),
    .X2(t5_2), .Y2(t6_2),
    .X3(t5_3), .Y3(t6_3));


// latency=8, gap=128
   DirSum_54328 stage6(.next(next_6), .clk(clk), .reset(reset), .next_out(next_7),
       .X0(t6_0), .Y0(t7_0),
       .X1(t6_1), .Y1(t7_1),
       .X2(t6_2), .Y2(t7_2),
       .X3(t6_3), .Y3(t7_3));


// latency=2, gap=128
   codeBlock54331 stage7(.clk(clk), .reset(reset), .next_in(next_7), .next_out(next_8),
       .X0_in(t7_0), .Y0(t8_0),
       .X1_in(t7_1), .Y1(t8_1),
       .X2_in(t7_2), .Y2(t8_2),
       .X3_in(t7_3), .Y3(t8_3));


// latency=7, gap=128
   rc54412 stage8(.clk(clk), .reset(reset), .next(next_8), .next_out(next_9),
    .X0(t8_0), .Y0(t9_0),
    .X1(t8_1), .Y1(t9_1),
    .X2(t8_2), .Y2(t9_2),
    .X3(t8_3), .Y3(t9_3));


// latency=8, gap=128
   DirSum_54617 stage9(.next(next_9), .clk(clk), .reset(reset), .next_out(next_10),
       .X0(t9_0), .Y0(t10_0),
       .X1(t9_1), .Y1(t10_1),
       .X2(t9_2), .Y2(t10_2),
       .X3(t9_3), .Y3(t10_3));


// latency=2, gap=128
   codeBlock54620 stage10(.clk(clk), .reset(reset), .next_in(next_10), .next_out(next_11),
       .X0_in(t10_0), .Y0(t11_0),
       .X1_in(t10_1), .Y1(t11_1),
       .X2_in(t10_2), .Y2(t11_2),
       .X3_in(t10_3), .Y3(t11_3));


// latency=11, gap=128
   rc54701 stage11(.clk(clk), .reset(reset), .next(next_11), .next_out(next_12),
    .X0(t11_0), .Y0(t12_0),
    .X1(t11_1), .Y1(t12_1),
    .X2(t11_2), .Y2(t12_2),
    .X3(t11_3), .Y3(t12_3));


// latency=8, gap=128
   DirSum_54938 stage12(.next(next_12), .clk(clk), .reset(reset), .next_out(next_13),
       .X0(t12_0), .Y0(t13_0),
       .X1(t12_1), .Y1(t13_1),
       .X2(t12_2), .Y2(t13_2),
       .X3(t12_3), .Y3(t13_3));


// latency=2, gap=128
   codeBlock54941 stage13(.clk(clk), .reset(reset), .next_in(next_13), .next_out(next_14),
       .X0_in(t13_0), .Y0(t14_0),
       .X1_in(t13_1), .Y1(t14_1),
       .X2_in(t13_2), .Y2(t14_2),
       .X3_in(t13_3), .Y3(t14_3));


// latency=19, gap=128
   rc55022 stage14(.clk(clk), .reset(reset), .next(next_14), .next_out(next_15),
    .X0(t14_0), .Y0(t15_0),
    .X1(t14_1), .Y1(t15_1),
    .X2(t14_2), .Y2(t15_2),
    .X3(t14_3), .Y3(t15_3));


// latency=8, gap=128
   DirSum_55323 stage15(.next(next_15), .clk(clk), .reset(reset), .next_out(next_16),
       .X0(t15_0), .Y0(t16_0),
       .X1(t15_1), .Y1(t16_1),
       .X2(t15_2), .Y2(t16_2),
       .X3(t15_3), .Y3(t16_3));


// latency=2, gap=128
   codeBlock55326 stage16(.clk(clk), .reset(reset), .next_in(next_16), .next_out(next_17),
       .X0_in(t16_0), .Y0(t17_0),
       .X1_in(t16_1), .Y1(t17_1),
       .X2_in(t16_2), .Y2(t17_2),
       .X3_in(t16_3), .Y3(t17_3));


// latency=35, gap=128
   rc55407 stage17(.clk(clk), .reset(reset), .next(next_17), .next_out(next_18),
    .X0(t17_0), .Y0(t18_0),
    .X1(t17_1), .Y1(t18_1),
    .X2(t17_2), .Y2(t18_2),
    .X3(t17_3), .Y3(t18_3));


// latency=8, gap=128
   DirSum_55836 stage18(.next(next_18), .clk(clk), .reset(reset), .next_out(next_19),
       .X0(t18_0), .Y0(t19_0),
       .X1(t18_1), .Y1(t19_1),
       .X2(t18_2), .Y2(t19_2),
       .X3(t18_3), .Y3(t19_3));


// latency=2, gap=128
   codeBlock55839 stage19(.clk(clk), .reset(reset), .next_in(next_19), .next_out(next_20),
       .X0_in(t19_0), .Y0(t20_0),
       .X1_in(t19_1), .Y1(t20_1),
       .X2_in(t19_2), .Y2(t20_2),
       .X3_in(t19_3), .Y3(t20_3));


// latency=67, gap=128
   rc55920 stage20(.clk(clk), .reset(reset), .next(next_20), .next_out(next_21),
    .X0(t20_0), .Y0(t21_0),
    .X1(t20_1), .Y1(t21_1),
    .X2(t20_2), .Y2(t21_2),
    .X3(t20_3), .Y3(t21_3));


// latency=8, gap=128
   DirSum_56604 stage21(.next(next_21), .clk(clk), .reset(reset), .next_out(next_22),
       .X0(t21_0), .Y0(t22_0),
       .X1(t21_1), .Y1(t22_1),
       .X2(t21_2), .Y2(t22_2),
       .X3(t21_3), .Y3(t22_3));


// latency=2, gap=128
   codeBlock56607 stage22(.clk(clk), .reset(reset), .next_in(next_22), .next_out(next_23),
       .X0_in(t22_0), .Y0(t23_0),
       .X1_in(t22_1), .Y1(t23_1),
       .X2_in(t22_2), .Y2(t23_2),
       .X3_in(t22_3), .Y3(t23_3));


// latency=67, gap=128
   rc56688 stage23(.clk(clk), .reset(reset), .next(next_23), .next_out(next_24),
    .X0(t23_0), .Y0(t24_0),
    .X1(t23_1), .Y1(t24_1),
    .X2(t23_2), .Y2(t24_2),
    .X3(t23_3), .Y3(t24_3));


endmodule

// Latency: 116
// Gap: 128
module rc53791(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm53789 instPerm57853(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 116
// Gap: 128
module perm53789(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 128;
   parameter logDepth = 7;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[7] ^ addr0[0];
   assign inAddr0[0] = addr0[6];
   assign inAddr0[1] = addr0[5];
   assign inAddr0[2] = addr0[4];
   assign inAddr0[3] = addr0[3];
   assign inAddr0[4] = addr0[2];
   assign inAddr0[5] = addr0[1];
   assign inAddr0[6] = addr0[0];
   assign outBank0[0] = addr0b[7] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outAddr0[1] = addr0b[2];
   assign outAddr0[2] = addr0b[3];
   assign outAddr0[3] = addr0b[4];
   assign outAddr0[4] = addr0b[5];
   assign outAddr0[5] = addr0b[6];
   assign outAddr0[6] = addr0b[7];
   assign outBank_a0[0] = addr0c[7] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];
   assign outAddr_a0[1] = addr0c[2];
   assign outAddr_a0[2] = addr0c[3];
   assign outAddr_a0[3] = addr0c[4];
   assign outAddr_a0[4] = addr0c[5];
   assign outAddr_a0[5] = addr0c[6];
   assign outAddr_a0[6] = addr0c[7];

   assign inBank1[0] = addr1[7] ^ addr1[0];
   assign inAddr1[0] = addr1[6];
   assign inAddr1[1] = addr1[5];
   assign inAddr1[2] = addr1[4];
   assign inAddr1[3] = addr1[3];
   assign inAddr1[4] = addr1[2];
   assign inAddr1[5] = addr1[1];
   assign inAddr1[6] = addr1[0];
   assign outBank1[0] = addr1b[7] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outAddr1[1] = addr1b[2];
   assign outAddr1[2] = addr1b[3];
   assign outAddr1[3] = addr1b[4];
   assign outAddr1[4] = addr1b[5];
   assign outAddr1[5] = addr1b[6];
   assign outAddr1[6] = addr1b[7];
   assign outBank_a1[0] = addr1c[7] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];
   assign outAddr_a1[1] = addr1c[2];
   assign outAddr_a1[2] = addr1c[3];
   assign outAddr_a1[3] = addr1c[4];
   assign outAddr_a1[4] = addr1c[5];
   assign outAddr_a1[5] = addr1c[6];
   assign outAddr_a1[6] = addr1c[7];

   nextReg #(114, 7) nextReg_57858(.X(next), .Y(next0), .reset(reset), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_57861(.X(next0), .Y(next_out), .clk(clk));


   memArray256_53789 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
        outCount_for_rd_data <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 113)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
         if (inCount == 115)
            outCount_for_rd_data <= 0;
         else
            outCount_for_rd_data <= outCount_for_rd_data+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 113) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 127) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 113)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[6];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[6];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[6];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray256_53789(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 128;
   parameter logDepth = 7;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   nextReg #(128, 7) nextReg_57866(.X(next), .Y(next0), .reset(reset), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule

module nextReg(X, Y, reset, clk);
   parameter depth=2, logDepth=1;

   output Y;
   input X;
   input              clk, reset;
   reg [logDepth:0] count;
   reg                active;

   assign Y = (count == depth) ? 1 : 0;

   always @ (posedge clk) begin
      if (reset == 1) begin
         count <= 0;
         active <= 0;
      end
      else if (X == 1) begin
         active <= 1;
         count <= 1;
      end
      else if (count == depth) begin
         count <= 0;
         active <= 0;
      end
      else if (active)
         count <= count+1;
   end
endmodule


module memMod(in, out, inAddr, outAddr, writeSel, clk);

   parameter depth=1024, width=16, logDepth=10;

   input [width-1:0]    in;
   input [logDepth-1:0] inAddr, outAddr;
   input            writeSel, clk;
   output [width-1:0]   out;
   reg [width-1:0]  out;

   // synthesis attribute ram_style of mem is block

   reg [width-1:0]  mem[depth-1:0];

   always @(posedge clk) begin
      out <= mem[outAddr];

      if (writeSel)
        mem[inAddr] <= in;
   end
endmodule



module memMod_dist(in, out, inAddr, outAddr, writeSel, clk);

   parameter depth=1024, width=16, logDepth=10;

   input [width-1:0]    in;
   input [logDepth-1:0] inAddr, outAddr;
   input            writeSel, clk;
   output [width-1:0]   out;
   reg [width-1:0]  out;

   // synthesis attribute ram_style of mem is distributed

   reg [width-1:0]  mem[depth-1:0];

   always @(posedge clk) begin
      out <= mem[outAddr];

      if (writeSel)
        mem[inAddr] <= in;
   end
endmodule

module switch(ctrl, x0, x1, y0, y1);
    parameter width = 16;
    input [width-1:0] x0, x1;
    output [width-1:0] y0, y1;
    input ctrl;
    assign y0 = (ctrl == 0) ? x0 : x1;
    assign y1 = (ctrl == 0) ? x1 : x0;
endmodule

module shiftRegFIFO(X, Y, clk);
   parameter depth=1, width=1;

   output [width-1:0] Y;
   input  [width-1:0] X;
   input              clk;

   reg [width-1:0]    mem [depth-1:0];
   integer            index;

   assign Y = mem[depth-1];

   always @ (posedge clk) begin
      for(index=1;index<depth;index=index+1) begin
         mem[index] <= mem[index-1];
      end
      mem[0]<=X;
   end
endmodule

// Latency: 2
// Gap: 1
module codeBlock53793(clk, reset, next_in, next_out,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(1, 1) shiftFIFO_57873(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a430;
   wire signed [15:0] a431;
   wire signed [15:0] a432;
   wire signed [15:0] a433;
   wire signed [15:0] t189;
   wire signed [15:0] t190;
   wire signed [15:0] t191;
   wire signed [15:0] t192;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;


   assign a430 = X0;
   assign a431 = X2;
   assign a432 = X1;
   assign a433 = X3;
   assign Y0 = t189;
   assign Y1 = t190;
   assign Y2 = t191;
   assign Y3 = t192;

    addfxp #(16, 1) add53805(.a(a430), .b(a431), .clk(clk), .q(t189));    // 0
    addfxp #(16, 1) add53820(.a(a432), .b(a433), .clk(clk), .q(t190));    // 0
    subfxp #(16, 1) sub53835(.a(a430), .b(a431), .clk(clk), .q(t191));    // 0
    subfxp #(16, 1) sub53850(.a(a432), .b(a433), .clk(clk), .q(t192));    // 0


   always @(posedge clk) begin
      if (reset == 1) begin
      end
      else begin
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
      end
   end
endmodule

// Latency: 4
// Gap: 2
module rc53874(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm53872 instPerm57874(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 4
// Gap: 2
module perm53872(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 2;
   parameter logDepth = 1;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[1] ^ addr0[0];
   assign inAddr0[0] = addr0[0];
   assign outBank0[0] = addr0b[1] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outBank_a0[0] = addr0c[1] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];

   assign inBank1[0] = addr1[1] ^ addr1[0];
   assign inAddr1[0] = addr1[0];
   assign outBank1[0] = addr1b[1] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outBank_a1[0] = addr1c[1] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];

   shiftRegFIFO #(2, 1) shiftFIFO_57877(.X(next), .Y(next0), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_57880(.X(next0), .Y(next_out), .clk(clk));


   memArray4_53872 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

    reg resetOutCountRd2_2;
    reg resetOutCountRd2_3;

    always @(posedge clk) begin
        if (reset == 1) begin
            resetOutCountRd2_2 <= 0;
            resetOutCountRd2_3 <= 0;
        end
        else begin
            resetOutCountRd2_2 <= (inCount == 1) ? 1'b1 : 1'b0;
            resetOutCountRd2_3 <= resetOutCountRd2_2;
            if (resetOutCountRd2_3 == 1'b1)
                outCount_for_rd_data <= 0;
            else
                outCount_for_rd_data <= outCount_for_rd_data+1;
        end
    end
   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 1)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 1) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 1) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 1)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[0];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[0];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[0];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray4_53872(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 2;
   parameter logDepth = 1;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   shiftRegFIFO #(2, 1) shiftFIFO_57883(.X(next), .Y(next0), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule

// Latency: 8
// Gap: 2
module DirSum_54055(clk, reset, next, next_out,
      X0, Y0,
      X1, Y1,
      X2, Y2,
      X3, Y3);

   output next_out;
   input clk, reset, next;

   reg [0:0] i7;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   always @(posedge clk) begin
      if (reset == 1) begin
         i7 <= 0;
      end
      else begin
         if (next == 1)
            i7 <= 0;
         else if (i7 == 1)
            i7 <= 0;
         else
            i7 <= i7 + 1;
      end
   end

   codeBlock53877 codeBlockIsnt57884(.clk(clk), .reset(reset), .next_in(next), .next_out(next_out),
.i7_in(i7),
       .X0_in(X0), .Y0(Y0),
       .X1_in(X1), .Y1(Y1),
       .X2_in(X2), .Y2(Y2),
       .X3_in(X3), .Y3(Y3));

endmodule

module D26_54045(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [0:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h0;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



module D28_54053(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [0:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'hc000;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



// Latency: 8
// Gap: 1
module codeBlock53877(clk, reset, next_in, next_out,
   i7_in,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;
   input [0:0] i7_in;
   reg [0:0] i7;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(7, 1) shiftFIFO_57887(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a414;
   wire signed [15:0] a403;
   wire signed [15:0] a417;
   wire signed [15:0] a407;
   wire signed [15:0] a418;
   wire signed [15:0] a419;
   reg signed [15:0] tm182;
   reg signed [15:0] tm186;
   reg signed [15:0] tm198;
   reg signed [15:0] tm205;
   reg signed [15:0] tm183;
   reg signed [15:0] tm187;
   reg signed [15:0] tm199;
   reg signed [15:0] tm206;
   wire signed [15:0] tm2;
   wire signed [15:0] a408;
   wire signed [15:0] tm3;
   wire signed [15:0] a410;
   reg signed [15:0] tm184;
   reg signed [15:0] tm188;
   reg signed [15:0] tm200;
   reg signed [15:0] tm207;
   reg signed [15:0] tm32;
   reg signed [15:0] tm33;
   reg signed [15:0] tm185;
   reg signed [15:0] tm189;
   reg signed [15:0] tm201;
   reg signed [15:0] tm208;
   reg signed [15:0] tm202;
   reg signed [15:0] tm209;
   wire signed [15:0] a409;
   wire signed [15:0] a411;
   wire signed [15:0] a412;
   wire signed [15:0] a413;
   reg signed [15:0] tm203;
   reg signed [15:0] tm210;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;
   reg signed [15:0] tm204;
   reg signed [15:0] tm211;


   assign a414 = X0;
   assign a403 = a414;
   assign a417 = X1;
   assign a407 = a417;
   assign a418 = X2;
   assign a419 = X3;
   assign a408 = tm2;
   assign a410 = tm3;
   assign Y0 = tm204;
   assign Y1 = tm211;

   D26_54045 instD26inst0_54045(.addr(i7[0:0]), .out(tm2), .clk(clk));

   D28_54053 instD28inst0_54053(.addr(i7[0:0]), .out(tm3), .clk(clk));

    multfix #(16, 2) m53976(.a(tm32), .b(tm185), .clk(clk), .q_sc(a409), .q_unsc(), .rst(reset));
    multfix #(16, 2) m53998(.a(tm33), .b(tm189), .clk(clk), .q_sc(a411), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54016(.a(tm33), .b(tm185), .clk(clk), .q_sc(a412), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54027(.a(tm32), .b(tm189), .clk(clk), .q_sc(a413), .q_unsc(), .rst(reset));
    subfxp #(16, 1) sub54005(.a(a409), .b(a411), .clk(clk), .q(Y2));    // 6
    addfxp #(16, 1) add54034(.a(a412), .b(a413), .clk(clk), .q(Y3));    // 6


   always @(posedge clk) begin
      if (reset == 1) begin
         tm32 <= 0;
         tm185 <= 0;
         tm33 <= 0;
         tm189 <= 0;
         tm33 <= 0;
         tm185 <= 0;
         tm32 <= 0;
         tm189 <= 0;
      end
      else begin
         i7 <= i7_in;
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
         tm182 <= a418;
         tm186 <= a419;
         tm198 <= a403;
         tm205 <= a407;
         tm183 <= tm182;
         tm187 <= tm186;
         tm199 <= tm198;
         tm206 <= tm205;
         tm184 <= tm183;
         tm188 <= tm187;
         tm200 <= tm199;
         tm207 <= tm206;
         tm32 <= a408;
         tm33 <= a410;
         tm185 <= tm184;
         tm189 <= tm188;
         tm201 <= tm200;
         tm208 <= tm207;
         tm202 <= tm201;
         tm209 <= tm208;
         tm203 <= tm202;
         tm210 <= tm209;
         tm204 <= tm203;
         tm211 <= tm210;
      end
   end
endmodule

// Latency: 2
// Gap: 1
module codeBlock54058(clk, reset, next_in, next_out,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(1, 1) shiftFIFO_57890(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a369;
   wire signed [15:0] a370;
   wire signed [15:0] a371;
   wire signed [15:0] a372;
   wire signed [15:0] t165;
   wire signed [15:0] t166;
   wire signed [15:0] t167;
   wire signed [15:0] t168;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;


   assign a369 = X0;
   assign a370 = X2;
   assign a371 = X1;
   assign a372 = X3;
   assign Y0 = t165;
   assign Y1 = t166;
   assign Y2 = t167;
   assign Y3 = t168;

    addfxp #(16, 1) add54070(.a(a369), .b(a370), .clk(clk), .q(t165));    // 0
    addfxp #(16, 1) add54085(.a(a371), .b(a372), .clk(clk), .q(t166));    // 0
    subfxp #(16, 1) sub54100(.a(a369), .b(a370), .clk(clk), .q(t167));    // 0
    subfxp #(16, 1) sub54115(.a(a371), .b(a372), .clk(clk), .q(t168));    // 0


   always @(posedge clk) begin
      if (reset == 1) begin
      end
      else begin
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
      end
   end
endmodule

// Latency: 5
// Gap: 4
module rc54139(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm54137 instPerm57891(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 5
// Gap: 4
module perm54137(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 4;
   parameter logDepth = 2;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[2] ^ addr0[0];
   assign inAddr0[0] = addr0[1];
   assign inAddr0[1] = addr0[0];
   assign outBank0[0] = addr0b[2] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outAddr0[1] = addr0b[2];
   assign outBank_a0[0] = addr0c[2] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];
   assign outAddr_a0[1] = addr0c[2];

   assign inBank1[0] = addr1[2] ^ addr1[0];
   assign inAddr1[0] = addr1[1];
   assign inAddr1[1] = addr1[0];
   assign outBank1[0] = addr1b[2] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outAddr1[1] = addr1b[2];
   assign outBank_a1[0] = addr1c[2] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];
   assign outAddr_a1[1] = addr1c[2];

   shiftRegFIFO #(3, 1) shiftFIFO_57894(.X(next), .Y(next0), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_57897(.X(next0), .Y(next_out), .clk(clk));


   memArray8_54137 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

    reg resetOutCountRd2_4;

    always @(posedge clk) begin
        if (reset == 1) begin
            resetOutCountRd2_4 <= 0;
        end
        else begin
            resetOutCountRd2_4 <= (inCount == 3) ? 1'b1 : 1'b0;
            if (resetOutCountRd2_4 == 1'b1)
                outCount_for_rd_data <= 0;
            else
                outCount_for_rd_data <= outCount_for_rd_data+1;
        end
    end
   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 2)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 2) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 3) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 2)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[1];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[1];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[1];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray8_54137(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 4;
   parameter logDepth = 2;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   shiftRegFIFO #(4, 1) shiftFIFO_57900(.X(next), .Y(next0), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule

// Latency: 8
// Gap: 4
module DirSum_54328(clk, reset, next, next_out,
      X0, Y0,
      X1, Y1,
      X2, Y2,
      X3, Y3);

   output next_out;
   input clk, reset, next;

   reg [1:0] i6;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   always @(posedge clk) begin
      if (reset == 1) begin
         i6 <= 0;
      end
      else begin
         if (next == 1)
            i6 <= 0;
         else if (i6 == 3)
            i6 <= 0;
         else
            i6 <= i6 + 1;
      end
   end

   codeBlock54142 codeBlockIsnt57901(.clk(clk), .reset(reset), .next_in(next), .next_out(next_out),
.i6_in(i6),
       .X0_in(X0), .Y0(Y0),
       .X1_in(X1), .Y1(Y1),
       .X2_in(X2), .Y2(Y2),
       .X3_in(X3), .Y3(Y3));

endmodule

module D22_54314(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [1:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h2d41;
      2: out3 <= 16'h0;
      3: out3 <= 16'hd2bf;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



module D24_54326(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [1:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'hd2bf;
      2: out3 <= 16'hc000;
      3: out3 <= 16'hd2bf;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



// Latency: 8
// Gap: 1
module codeBlock54142(clk, reset, next_in, next_out,
   i6_in,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;
   input [1:0] i6_in;
   reg [1:0] i6;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(7, 1) shiftFIFO_57904(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a353;
   wire signed [15:0] a342;
   wire signed [15:0] a356;
   wire signed [15:0] a346;
   wire signed [15:0] a357;
   wire signed [15:0] a358;
   reg signed [15:0] tm212;
   reg signed [15:0] tm216;
   reg signed [15:0] tm228;
   reg signed [15:0] tm235;
   reg signed [15:0] tm213;
   reg signed [15:0] tm217;
   reg signed [15:0] tm229;
   reg signed [15:0] tm236;
   wire signed [15:0] tm6;
   wire signed [15:0] a347;
   wire signed [15:0] tm7;
   wire signed [15:0] a349;
   reg signed [15:0] tm214;
   reg signed [15:0] tm218;
   reg signed [15:0] tm230;
   reg signed [15:0] tm237;
   reg signed [15:0] tm40;
   reg signed [15:0] tm41;
   reg signed [15:0] tm215;
   reg signed [15:0] tm219;
   reg signed [15:0] tm231;
   reg signed [15:0] tm238;
   reg signed [15:0] tm232;
   reg signed [15:0] tm239;
   wire signed [15:0] a348;
   wire signed [15:0] a350;
   wire signed [15:0] a351;
   wire signed [15:0] a352;
   reg signed [15:0] tm233;
   reg signed [15:0] tm240;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;
   reg signed [15:0] tm234;
   reg signed [15:0] tm241;


   assign a353 = X0;
   assign a342 = a353;
   assign a356 = X1;
   assign a346 = a356;
   assign a357 = X2;
   assign a358 = X3;
   assign a347 = tm6;
   assign a349 = tm7;
   assign Y0 = tm234;
   assign Y1 = tm241;

   D22_54314 instD22inst0_54314(.addr(i6[1:0]), .out(tm6), .clk(clk));

   D24_54326 instD24inst0_54326(.addr(i6[1:0]), .out(tm7), .clk(clk));

    multfix #(16, 2) m54241(.a(tm40), .b(tm215), .clk(clk), .q_sc(a348), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54263(.a(tm41), .b(tm219), .clk(clk), .q_sc(a350), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54281(.a(tm41), .b(tm215), .clk(clk), .q_sc(a351), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54292(.a(tm40), .b(tm219), .clk(clk), .q_sc(a352), .q_unsc(), .rst(reset));
    subfxp #(16, 1) sub54270(.a(a348), .b(a350), .clk(clk), .q(Y2));    // 6
    addfxp #(16, 1) add54299(.a(a351), .b(a352), .clk(clk), .q(Y3));    // 6


   always @(posedge clk) begin
      if (reset == 1) begin
         tm40 <= 0;
         tm215 <= 0;
         tm41 <= 0;
         tm219 <= 0;
         tm41 <= 0;
         tm215 <= 0;
         tm40 <= 0;
         tm219 <= 0;
      end
      else begin
         i6 <= i6_in;
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
         tm212 <= a357;
         tm216 <= a358;
         tm228 <= a342;
         tm235 <= a346;
         tm213 <= tm212;
         tm217 <= tm216;
         tm229 <= tm228;
         tm236 <= tm235;
         tm214 <= tm213;
         tm218 <= tm217;
         tm230 <= tm229;
         tm237 <= tm236;
         tm40 <= a347;
         tm41 <= a349;
         tm215 <= tm214;
         tm219 <= tm218;
         tm231 <= tm230;
         tm238 <= tm237;
         tm232 <= tm231;
         tm239 <= tm238;
         tm233 <= tm232;
         tm240 <= tm239;
         tm234 <= tm233;
         tm241 <= tm240;
      end
   end
endmodule

// Latency: 2
// Gap: 1
module codeBlock54331(clk, reset, next_in, next_out,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(1, 1) shiftFIFO_57907(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a309;
   wire signed [15:0] a310;
   wire signed [15:0] a311;
   wire signed [15:0] a312;
   wire signed [15:0] t141;
   wire signed [15:0] t142;
   wire signed [15:0] t143;
   wire signed [15:0] t144;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;


   assign a309 = X0;
   assign a310 = X2;
   assign a311 = X1;
   assign a312 = X3;
   assign Y0 = t141;
   assign Y1 = t142;
   assign Y2 = t143;
   assign Y3 = t144;

    addfxp #(16, 1) add54343(.a(a309), .b(a310), .clk(clk), .q(t141));    // 0
    addfxp #(16, 1) add54358(.a(a311), .b(a312), .clk(clk), .q(t142));    // 0
    subfxp #(16, 1) sub54373(.a(a309), .b(a310), .clk(clk), .q(t143));    // 0
    subfxp #(16, 1) sub54388(.a(a311), .b(a312), .clk(clk), .q(t144));    // 0


   always @(posedge clk) begin
      if (reset == 1) begin
      end
      else begin
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
      end
   end
endmodule

// Latency: 7
// Gap: 8
module rc54412(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm54410 instPerm57908(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 7
// Gap: 8
module perm54410(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 8;
   parameter logDepth = 3;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[3] ^ addr0[0];
   assign inAddr0[0] = addr0[1];
   assign inAddr0[1] = addr0[2];
   assign inAddr0[2] = addr0[0];
   assign outBank0[0] = addr0b[3] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outAddr0[1] = addr0b[2];
   assign outAddr0[2] = addr0b[3];
   assign outBank_a0[0] = addr0c[3] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];
   assign outAddr_a0[1] = addr0c[2];
   assign outAddr_a0[2] = addr0c[3];

   assign inBank1[0] = addr1[3] ^ addr1[0];
   assign inAddr1[0] = addr1[1];
   assign inAddr1[1] = addr1[2];
   assign inAddr1[2] = addr1[0];
   assign outBank1[0] = addr1b[3] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outAddr1[1] = addr1b[2];
   assign outAddr1[2] = addr1b[3];
   assign outBank_a1[0] = addr1c[3] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];
   assign outAddr_a1[1] = addr1c[2];
   assign outAddr_a1[2] = addr1c[3];

   shiftRegFIFO #(5, 1) shiftFIFO_57911(.X(next), .Y(next0), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_57914(.X(next0), .Y(next_out), .clk(clk));


   memArray16_54410 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
        outCount_for_rd_data <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 4)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
         if (inCount == 6)
            outCount_for_rd_data <= 0;
         else
            outCount_for_rd_data <= outCount_for_rd_data+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 4) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 7) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 4)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[2];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[2];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[2];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray16_54410(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 8;
   parameter logDepth = 3;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   shiftRegFIFO #(8, 1) shiftFIFO_57917(.X(next), .Y(next0), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule

// Latency: 8
// Gap: 8
module DirSum_54617(clk, reset, next, next_out,
      X0, Y0,
      X1, Y1,
      X2, Y2,
      X3, Y3);

   output next_out;
   input clk, reset, next;

   reg [2:0] i5;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   always @(posedge clk) begin
      if (reset == 1) begin
         i5 <= 0;
      end
      else begin
         if (next == 1)
            i5 <= 0;
         else if (i5 == 7)
            i5 <= 0;
         else
            i5 <= i5 + 1;
      end
   end

   codeBlock54415 codeBlockIsnt57918(.clk(clk), .reset(reset), .next_in(next), .next_out(next_out),
.i5_in(i5),
       .X0_in(X0), .Y0(Y0),
       .X1_in(X1), .Y1(Y1),
       .X2_in(X2), .Y2(Y2),
       .X3_in(X3), .Y3(Y3));

endmodule

module D18_54595(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [2:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h3b21;
      2: out3 <= 16'h2d41;
      3: out3 <= 16'h187e;
      4: out3 <= 16'h0;
      5: out3 <= 16'he782;
      6: out3 <= 16'hd2bf;
      7: out3 <= 16'hc4df;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



module D20_54615(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [2:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'he782;
      2: out3 <= 16'hd2bf;
      3: out3 <= 16'hc4df;
      4: out3 <= 16'hc000;
      5: out3 <= 16'hc4df;
      6: out3 <= 16'hd2bf;
      7: out3 <= 16'he782;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



// Latency: 8
// Gap: 1
module codeBlock54415(clk, reset, next_in, next_out,
   i5_in,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;
   input [2:0] i5_in;
   reg [2:0] i5;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(7, 1) shiftFIFO_57921(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a293;
   wire signed [15:0] a282;
   wire signed [15:0] a296;
   wire signed [15:0] a286;
   wire signed [15:0] a297;
   wire signed [15:0] a298;
   reg signed [15:0] tm242;
   reg signed [15:0] tm246;
   reg signed [15:0] tm258;
   reg signed [15:0] tm265;
   reg signed [15:0] tm243;
   reg signed [15:0] tm247;
   reg signed [15:0] tm259;
   reg signed [15:0] tm266;
   wire signed [15:0] tm10;
   wire signed [15:0] a287;
   wire signed [15:0] tm11;
   wire signed [15:0] a289;
   reg signed [15:0] tm244;
   reg signed [15:0] tm248;
   reg signed [15:0] tm260;
   reg signed [15:0] tm267;
   reg signed [15:0] tm48;
   reg signed [15:0] tm49;
   reg signed [15:0] tm245;
   reg signed [15:0] tm249;
   reg signed [15:0] tm261;
   reg signed [15:0] tm268;
   reg signed [15:0] tm262;
   reg signed [15:0] tm269;
   wire signed [15:0] a288;
   wire signed [15:0] a290;
   wire signed [15:0] a291;
   wire signed [15:0] a292;
   reg signed [15:0] tm263;
   reg signed [15:0] tm270;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;
   reg signed [15:0] tm264;
   reg signed [15:0] tm271;


   assign a293 = X0;
   assign a282 = a293;
   assign a296 = X1;
   assign a286 = a296;
   assign a297 = X2;
   assign a298 = X3;
   assign a287 = tm10;
   assign a289 = tm11;
   assign Y0 = tm264;
   assign Y1 = tm271;

   D18_54595 instD18inst0_54595(.addr(i5[2:0]), .out(tm10), .clk(clk));

   D20_54615 instD20inst0_54615(.addr(i5[2:0]), .out(tm11), .clk(clk));

    multfix #(16, 2) m54514(.a(tm48), .b(tm245), .clk(clk), .q_sc(a288), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54536(.a(tm49), .b(tm249), .clk(clk), .q_sc(a290), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54554(.a(tm49), .b(tm245), .clk(clk), .q_sc(a291), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54565(.a(tm48), .b(tm249), .clk(clk), .q_sc(a292), .q_unsc(), .rst(reset));
    subfxp #(16, 1) sub54543(.a(a288), .b(a290), .clk(clk), .q(Y2));    // 6
    addfxp #(16, 1) add54572(.a(a291), .b(a292), .clk(clk), .q(Y3));    // 6


   always @(posedge clk) begin
      if (reset == 1) begin
         tm48 <= 0;
         tm245 <= 0;
         tm49 <= 0;
         tm249 <= 0;
         tm49 <= 0;
         tm245 <= 0;
         tm48 <= 0;
         tm249 <= 0;
      end
      else begin
         i5 <= i5_in;
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
         tm242 <= a297;
         tm246 <= a298;
         tm258 <= a282;
         tm265 <= a286;
         tm243 <= tm242;
         tm247 <= tm246;
         tm259 <= tm258;
         tm266 <= tm265;
         tm244 <= tm243;
         tm248 <= tm247;
         tm260 <= tm259;
         tm267 <= tm266;
         tm48 <= a287;
         tm49 <= a289;
         tm245 <= tm244;
         tm249 <= tm248;
         tm261 <= tm260;
         tm268 <= tm267;
         tm262 <= tm261;
         tm269 <= tm268;
         tm263 <= tm262;
         tm270 <= tm269;
         tm264 <= tm263;
         tm271 <= tm270;
      end
   end
endmodule

// Latency: 2
// Gap: 1
module codeBlock54620(clk, reset, next_in, next_out,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(1, 1) shiftFIFO_57924(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a249;
   wire signed [15:0] a250;
   wire signed [15:0] a251;
   wire signed [15:0] a252;
   wire signed [15:0] t117;
   wire signed [15:0] t118;
   wire signed [15:0] t119;
   wire signed [15:0] t120;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;


   assign a249 = X0;
   assign a250 = X2;
   assign a251 = X1;
   assign a252 = X3;
   assign Y0 = t117;
   assign Y1 = t118;
   assign Y2 = t119;
   assign Y3 = t120;

    addfxp #(16, 1) add54632(.a(a249), .b(a250), .clk(clk), .q(t117));    // 0
    addfxp #(16, 1) add54647(.a(a251), .b(a252), .clk(clk), .q(t118));    // 0
    subfxp #(16, 1) sub54662(.a(a249), .b(a250), .clk(clk), .q(t119));    // 0
    subfxp #(16, 1) sub54677(.a(a251), .b(a252), .clk(clk), .q(t120));    // 0


   always @(posedge clk) begin
      if (reset == 1) begin
      end
      else begin
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
      end
   end
endmodule

// Latency: 11
// Gap: 16
module rc54701(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm54699 instPerm57925(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 11
// Gap: 16
module perm54699(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 16;
   parameter logDepth = 4;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[4] ^ addr0[0];
   assign inAddr0[0] = addr0[1];
   assign inAddr0[1] = addr0[2];
   assign inAddr0[2] = addr0[3];
   assign inAddr0[3] = addr0[0];
   assign outBank0[0] = addr0b[4] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outAddr0[1] = addr0b[2];
   assign outAddr0[2] = addr0b[3];
   assign outAddr0[3] = addr0b[4];
   assign outBank_a0[0] = addr0c[4] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];
   assign outAddr_a0[1] = addr0c[2];
   assign outAddr_a0[2] = addr0c[3];
   assign outAddr_a0[3] = addr0c[4];

   assign inBank1[0] = addr1[4] ^ addr1[0];
   assign inAddr1[0] = addr1[1];
   assign inAddr1[1] = addr1[2];
   assign inAddr1[2] = addr1[3];
   assign inAddr1[3] = addr1[0];
   assign outBank1[0] = addr1b[4] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outAddr1[1] = addr1b[2];
   assign outAddr1[2] = addr1b[3];
   assign outAddr1[3] = addr1b[4];
   assign outBank_a1[0] = addr1c[4] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];
   assign outAddr_a1[1] = addr1c[2];
   assign outAddr_a1[2] = addr1c[3];
   assign outAddr_a1[3] = addr1c[4];

   nextReg #(9, 4) nextReg_57930(.X(next), .Y(next0), .reset(reset), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_57933(.X(next0), .Y(next_out), .clk(clk));


   memArray32_54699 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
        outCount_for_rd_data <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 8)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
         if (inCount == 10)
            outCount_for_rd_data <= 0;
         else
            outCount_for_rd_data <= outCount_for_rd_data+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 8) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 15) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 8)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[3];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[3];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[3];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray32_54699(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 16;
   parameter logDepth = 4;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   nextReg #(16, 4) nextReg_57938(.X(next), .Y(next0), .reset(reset), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule

// Latency: 8
// Gap: 16
module DirSum_54938(clk, reset, next, next_out,
      X0, Y0,
      X1, Y1,
      X2, Y2,
      X3, Y3);

   output next_out;
   input clk, reset, next;

   reg [3:0] i4;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   always @(posedge clk) begin
      if (reset == 1) begin
         i4 <= 0;
      end
      else begin
         if (next == 1)
            i4 <= 0;
         else if (i4 == 15)
            i4 <= 0;
         else
            i4 <= i4 + 1;
      end
   end

   codeBlock54704 codeBlockIsnt57943(.clk(clk), .reset(reset), .next_in(next), .next_out(next_out),
.i4_in(i4),
       .X0_in(X0), .Y0(Y0),
       .X1_in(X1), .Y1(Y1),
       .X2_in(X2), .Y2(Y2),
       .X3_in(X3), .Y3(Y3));

endmodule

module D14_54900(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [3:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h3ec5;
      2: out3 <= 16'h3b21;
      3: out3 <= 16'h3537;
      4: out3 <= 16'h2d41;
      5: out3 <= 16'h238e;
      6: out3 <= 16'h187e;
      7: out3 <= 16'hc7c;
      8: out3 <= 16'h0;
      9: out3 <= 16'hf384;
      10: out3 <= 16'he782;
      11: out3 <= 16'hdc72;
      12: out3 <= 16'hd2bf;
      13: out3 <= 16'hcac9;
      14: out3 <= 16'hc4df;
      15: out3 <= 16'hc13b;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



module D16_54936(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [3:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'hf384;
      2: out3 <= 16'he782;
      3: out3 <= 16'hdc72;
      4: out3 <= 16'hd2bf;
      5: out3 <= 16'hcac9;
      6: out3 <= 16'hc4df;
      7: out3 <= 16'hc13b;
      8: out3 <= 16'hc000;
      9: out3 <= 16'hc13b;
      10: out3 <= 16'hc4df;
      11: out3 <= 16'hcac9;
      12: out3 <= 16'hd2bf;
      13: out3 <= 16'hdc72;
      14: out3 <= 16'he782;
      15: out3 <= 16'hf384;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



// Latency: 8
// Gap: 1
module codeBlock54704(clk, reset, next_in, next_out,
   i4_in,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;
   input [3:0] i4_in;
   reg [3:0] i4;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(7, 1) shiftFIFO_57946(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a233;
   wire signed [15:0] a222;
   wire signed [15:0] a236;
   wire signed [15:0] a226;
   wire signed [15:0] a237;
   wire signed [15:0] a238;
   reg signed [15:0] tm272;
   reg signed [15:0] tm276;
   reg signed [15:0] tm288;
   reg signed [15:0] tm295;
   reg signed [15:0] tm273;
   reg signed [15:0] tm277;
   reg signed [15:0] tm289;
   reg signed [15:0] tm296;
   wire signed [15:0] tm14;
   wire signed [15:0] a227;
   wire signed [15:0] tm15;
   wire signed [15:0] a229;
   reg signed [15:0] tm274;
   reg signed [15:0] tm278;
   reg signed [15:0] tm290;
   reg signed [15:0] tm297;
   reg signed [15:0] tm56;
   reg signed [15:0] tm57;
   reg signed [15:0] tm275;
   reg signed [15:0] tm279;
   reg signed [15:0] tm291;
   reg signed [15:0] tm298;
   reg signed [15:0] tm292;
   reg signed [15:0] tm299;
   wire signed [15:0] a228;
   wire signed [15:0] a230;
   wire signed [15:0] a231;
   wire signed [15:0] a232;
   reg signed [15:0] tm293;
   reg signed [15:0] tm300;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;
   reg signed [15:0] tm294;
   reg signed [15:0] tm301;


   assign a233 = X0;
   assign a222 = a233;
   assign a236 = X1;
   assign a226 = a236;
   assign a237 = X2;
   assign a238 = X3;
   assign a227 = tm14;
   assign a229 = tm15;
   assign Y0 = tm294;
   assign Y1 = tm301;

   D14_54900 instD14inst0_54900(.addr(i4[3:0]), .out(tm14), .clk(clk));

   D16_54936 instD16inst0_54936(.addr(i4[3:0]), .out(tm15), .clk(clk));

    multfix #(16, 2) m54803(.a(tm56), .b(tm275), .clk(clk), .q_sc(a228), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54825(.a(tm57), .b(tm279), .clk(clk), .q_sc(a230), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54843(.a(tm57), .b(tm275), .clk(clk), .q_sc(a231), .q_unsc(), .rst(reset));
    multfix #(16, 2) m54854(.a(tm56), .b(tm279), .clk(clk), .q_sc(a232), .q_unsc(), .rst(reset));
    subfxp #(16, 1) sub54832(.a(a228), .b(a230), .clk(clk), .q(Y2));    // 6
    addfxp #(16, 1) add54861(.a(a231), .b(a232), .clk(clk), .q(Y3));    // 6


   always @(posedge clk) begin
      if (reset == 1) begin
         tm56 <= 0;
         tm275 <= 0;
         tm57 <= 0;
         tm279 <= 0;
         tm57 <= 0;
         tm275 <= 0;
         tm56 <= 0;
         tm279 <= 0;
      end
      else begin
         i4 <= i4_in;
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
         tm272 <= a237;
         tm276 <= a238;
         tm288 <= a222;
         tm295 <= a226;
         tm273 <= tm272;
         tm277 <= tm276;
         tm289 <= tm288;
         tm296 <= tm295;
         tm274 <= tm273;
         tm278 <= tm277;
         tm290 <= tm289;
         tm297 <= tm296;
         tm56 <= a227;
         tm57 <= a229;
         tm275 <= tm274;
         tm279 <= tm278;
         tm291 <= tm290;
         tm298 <= tm297;
         tm292 <= tm291;
         tm299 <= tm298;
         tm293 <= tm292;
         tm300 <= tm299;
         tm294 <= tm293;
         tm301 <= tm300;
      end
   end
endmodule

// Latency: 2
// Gap: 1
module codeBlock54941(clk, reset, next_in, next_out,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(1, 1) shiftFIFO_57949(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a189;
   wire signed [15:0] a190;
   wire signed [15:0] a191;
   wire signed [15:0] a192;
   wire signed [15:0] t93;
   wire signed [15:0] t94;
   wire signed [15:0] t95;
   wire signed [15:0] t96;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;


   assign a189 = X0;
   assign a190 = X2;
   assign a191 = X1;
   assign a192 = X3;
   assign Y0 = t93;
   assign Y1 = t94;
   assign Y2 = t95;
   assign Y3 = t96;

    addfxp #(16, 1) add54953(.a(a189), .b(a190), .clk(clk), .q(t93));    // 0
    addfxp #(16, 1) add54968(.a(a191), .b(a192), .clk(clk), .q(t94));    // 0
    subfxp #(16, 1) sub54983(.a(a189), .b(a190), .clk(clk), .q(t95));    // 0
    subfxp #(16, 1) sub54998(.a(a191), .b(a192), .clk(clk), .q(t96));    // 0


   always @(posedge clk) begin
      if (reset == 1) begin
      end
      else begin
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
      end
   end
endmodule

// Latency: 19
// Gap: 32
module rc55022(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm55020 instPerm57950(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 19
// Gap: 32
module perm55020(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 32;
   parameter logDepth = 5;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[5] ^ addr0[0];
   assign inAddr0[0] = addr0[1];
   assign inAddr0[1] = addr0[2];
   assign inAddr0[2] = addr0[3];
   assign inAddr0[3] = addr0[4];
   assign inAddr0[4] = addr0[0];
   assign outBank0[0] = addr0b[5] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outAddr0[1] = addr0b[2];
   assign outAddr0[2] = addr0b[3];
   assign outAddr0[3] = addr0b[4];
   assign outAddr0[4] = addr0b[5];
   assign outBank_a0[0] = addr0c[5] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];
   assign outAddr_a0[1] = addr0c[2];
   assign outAddr_a0[2] = addr0c[3];
   assign outAddr_a0[3] = addr0c[4];
   assign outAddr_a0[4] = addr0c[5];

   assign inBank1[0] = addr1[5] ^ addr1[0];
   assign inAddr1[0] = addr1[1];
   assign inAddr1[1] = addr1[2];
   assign inAddr1[2] = addr1[3];
   assign inAddr1[3] = addr1[4];
   assign inAddr1[4] = addr1[0];
   assign outBank1[0] = addr1b[5] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outAddr1[1] = addr1b[2];
   assign outAddr1[2] = addr1b[3];
   assign outAddr1[3] = addr1b[4];
   assign outAddr1[4] = addr1b[5];
   assign outBank_a1[0] = addr1c[5] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];
   assign outAddr_a1[1] = addr1c[2];
   assign outAddr_a1[2] = addr1c[3];
   assign outAddr_a1[3] = addr1c[4];
   assign outAddr_a1[4] = addr1c[5];

   nextReg #(17, 5) nextReg_57955(.X(next), .Y(next0), .reset(reset), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_57958(.X(next0), .Y(next_out), .clk(clk));


   memArray64_55020 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
        outCount_for_rd_data <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 16)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
         if (inCount == 18)
            outCount_for_rd_data <= 0;
         else
            outCount_for_rd_data <= outCount_for_rd_data+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 16) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 31) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 16)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[4];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[4];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[4];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray64_55020(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 32;
   parameter logDepth = 5;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   nextReg #(32, 5) nextReg_57963(.X(next), .Y(next0), .reset(reset), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule

// Latency: 8
// Gap: 32
module DirSum_55323(clk, reset, next, next_out,
      X0, Y0,
      X1, Y1,
      X2, Y2,
      X3, Y3);

   output next_out;
   input clk, reset, next;

   reg [4:0] i3;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   always @(posedge clk) begin
      if (reset == 1) begin
         i3 <= 0;
      end
      else begin
         if (next == 1)
            i3 <= 0;
         else if (i3 == 31)
            i3 <= 0;
         else
            i3 <= i3 + 1;
      end
   end

   codeBlock55025 codeBlockIsnt57968(.clk(clk), .reset(reset), .next_in(next), .next_out(next_out),
.i3_in(i3),
       .X0_in(X0), .Y0(Y0),
       .X1_in(X1), .Y1(Y1),
       .X2_in(X2), .Y2(Y2),
       .X3_in(X3), .Y3(Y3));

endmodule

module D10_55253(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [4:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h3fb1;
      2: out3 <= 16'h3ec5;
      3: out3 <= 16'h3d3f;
      4: out3 <= 16'h3b21;
      5: out3 <= 16'h3871;
      6: out3 <= 16'h3537;
      7: out3 <= 16'h3179;
      8: out3 <= 16'h2d41;
      9: out3 <= 16'h289a;
      10: out3 <= 16'h238e;
      11: out3 <= 16'h1e2b;
      12: out3 <= 16'h187e;
      13: out3 <= 16'h1294;
      14: out3 <= 16'hc7c;
      15: out3 <= 16'h646;
      16: out3 <= 16'h0;
      17: out3 <= 16'hf9ba;
      18: out3 <= 16'hf384;
      19: out3 <= 16'hed6c;
      20: out3 <= 16'he782;
      21: out3 <= 16'he1d5;
      22: out3 <= 16'hdc72;
      23: out3 <= 16'hd766;
      24: out3 <= 16'hd2bf;
      25: out3 <= 16'hce87;
      26: out3 <= 16'hcac9;
      27: out3 <= 16'hc78f;
      28: out3 <= 16'hc4df;
      29: out3 <= 16'hc2c1;
      30: out3 <= 16'hc13b;
      31: out3 <= 16'hc04f;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



module D12_55321(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [4:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'hf9ba;
      2: out3 <= 16'hf384;
      3: out3 <= 16'hed6c;
      4: out3 <= 16'he782;
      5: out3 <= 16'he1d5;
      6: out3 <= 16'hdc72;
      7: out3 <= 16'hd766;
      8: out3 <= 16'hd2bf;
      9: out3 <= 16'hce87;
      10: out3 <= 16'hcac9;
      11: out3 <= 16'hc78f;
      12: out3 <= 16'hc4df;
      13: out3 <= 16'hc2c1;
      14: out3 <= 16'hc13b;
      15: out3 <= 16'hc04f;
      16: out3 <= 16'hc000;
      17: out3 <= 16'hc04f;
      18: out3 <= 16'hc13b;
      19: out3 <= 16'hc2c1;
      20: out3 <= 16'hc4df;
      21: out3 <= 16'hc78f;
      22: out3 <= 16'hcac9;
      23: out3 <= 16'hce87;
      24: out3 <= 16'hd2bf;
      25: out3 <= 16'hd766;
      26: out3 <= 16'hdc72;
      27: out3 <= 16'he1d5;
      28: out3 <= 16'he782;
      29: out3 <= 16'hed6c;
      30: out3 <= 16'hf384;
      31: out3 <= 16'hf9ba;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



// Latency: 8
// Gap: 1
module codeBlock55025(clk, reset, next_in, next_out,
   i3_in,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;
   input [4:0] i3_in;
   reg [4:0] i3;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(7, 1) shiftFIFO_57971(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a173;
   wire signed [15:0] a162;
   wire signed [15:0] a176;
   wire signed [15:0] a166;
   wire signed [15:0] a177;
   wire signed [15:0] a178;
   reg signed [15:0] tm302;
   reg signed [15:0] tm306;
   reg signed [15:0] tm318;
   reg signed [15:0] tm325;
   reg signed [15:0] tm303;
   reg signed [15:0] tm307;
   reg signed [15:0] tm319;
   reg signed [15:0] tm326;
   wire signed [15:0] tm18;
   wire signed [15:0] a167;
   wire signed [15:0] tm19;
   wire signed [15:0] a169;
   reg signed [15:0] tm304;
   reg signed [15:0] tm308;
   reg signed [15:0] tm320;
   reg signed [15:0] tm327;
   reg signed [15:0] tm64;
   reg signed [15:0] tm65;
   reg signed [15:0] tm305;
   reg signed [15:0] tm309;
   reg signed [15:0] tm321;
   reg signed [15:0] tm328;
   reg signed [15:0] tm322;
   reg signed [15:0] tm329;
   wire signed [15:0] a168;
   wire signed [15:0] a170;
   wire signed [15:0] a171;
   wire signed [15:0] a172;
   reg signed [15:0] tm323;
   reg signed [15:0] tm330;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;
   reg signed [15:0] tm324;
   reg signed [15:0] tm331;


   assign a173 = X0;
   assign a162 = a173;
   assign a176 = X1;
   assign a166 = a176;
   assign a177 = X2;
   assign a178 = X3;
   assign a167 = tm18;
   assign a169 = tm19;
   assign Y0 = tm324;
   assign Y1 = tm331;

   D10_55253 instD10inst0_55253(.addr(i3[4:0]), .out(tm18), .clk(clk));

   D12_55321 instD12inst0_55321(.addr(i3[4:0]), .out(tm19), .clk(clk));

    multfix #(16, 2) m55124(.a(tm64), .b(tm305), .clk(clk), .q_sc(a168), .q_unsc(), .rst(reset));
    multfix #(16, 2) m55146(.a(tm65), .b(tm309), .clk(clk), .q_sc(a170), .q_unsc(), .rst(reset));
    multfix #(16, 2) m55164(.a(tm65), .b(tm305), .clk(clk), .q_sc(a171), .q_unsc(), .rst(reset));
    multfix #(16, 2) m55175(.a(tm64), .b(tm309), .clk(clk), .q_sc(a172), .q_unsc(), .rst(reset));
    subfxp #(16, 1) sub55153(.a(a168), .b(a170), .clk(clk), .q(Y2));    // 6
    addfxp #(16, 1) add55182(.a(a171), .b(a172), .clk(clk), .q(Y3));    // 6


   always @(posedge clk) begin
      if (reset == 1) begin
         tm64 <= 0;
         tm305 <= 0;
         tm65 <= 0;
         tm309 <= 0;
         tm65 <= 0;
         tm305 <= 0;
         tm64 <= 0;
         tm309 <= 0;
      end
      else begin
         i3 <= i3_in;
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
         tm302 <= a177;
         tm306 <= a178;
         tm318 <= a162;
         tm325 <= a166;
         tm303 <= tm302;
         tm307 <= tm306;
         tm319 <= tm318;
         tm326 <= tm325;
         tm304 <= tm303;
         tm308 <= tm307;
         tm320 <= tm319;
         tm327 <= tm326;
         tm64 <= a167;
         tm65 <= a169;
         tm305 <= tm304;
         tm309 <= tm308;
         tm321 <= tm320;
         tm328 <= tm327;
         tm322 <= tm321;
         tm329 <= tm328;
         tm323 <= tm322;
         tm330 <= tm329;
         tm324 <= tm323;
         tm331 <= tm330;
      end
   end
endmodule

// Latency: 2
// Gap: 1
module codeBlock55326(clk, reset, next_in, next_out,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(1, 1) shiftFIFO_57974(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a129;
   wire signed [15:0] a130;
   wire signed [15:0] a131;
   wire signed [15:0] a132;
   wire signed [15:0] t69;
   wire signed [15:0] t70;
   wire signed [15:0] t71;
   wire signed [15:0] t72;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;


   assign a129 = X0;
   assign a130 = X2;
   assign a131 = X1;
   assign a132 = X3;
   assign Y0 = t69;
   assign Y1 = t70;
   assign Y2 = t71;
   assign Y3 = t72;

    addfxp #(16, 1) add55338(.a(a129), .b(a130), .clk(clk), .q(t69));    // 0
    addfxp #(16, 1) add55353(.a(a131), .b(a132), .clk(clk), .q(t70));    // 0
    subfxp #(16, 1) sub55368(.a(a129), .b(a130), .clk(clk), .q(t71));    // 0
    subfxp #(16, 1) sub55383(.a(a131), .b(a132), .clk(clk), .q(t72));    // 0


   always @(posedge clk) begin
      if (reset == 1) begin
      end
      else begin
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
      end
   end
endmodule

// Latency: 35
// Gap: 64
module rc55407(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm55405 instPerm57975(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 35
// Gap: 64
module perm55405(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 64;
   parameter logDepth = 6;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[6] ^ addr0[0];
   assign inAddr0[0] = addr0[1];
   assign inAddr0[1] = addr0[2];
   assign inAddr0[2] = addr0[3];
   assign inAddr0[3] = addr0[4];
   assign inAddr0[4] = addr0[5];
   assign inAddr0[5] = addr0[0];
   assign outBank0[0] = addr0b[6] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outAddr0[1] = addr0b[2];
   assign outAddr0[2] = addr0b[3];
   assign outAddr0[3] = addr0b[4];
   assign outAddr0[4] = addr0b[5];
   assign outAddr0[5] = addr0b[6];
   assign outBank_a0[0] = addr0c[6] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];
   assign outAddr_a0[1] = addr0c[2];
   assign outAddr_a0[2] = addr0c[3];
   assign outAddr_a0[3] = addr0c[4];
   assign outAddr_a0[4] = addr0c[5];
   assign outAddr_a0[5] = addr0c[6];

   assign inBank1[0] = addr1[6] ^ addr1[0];
   assign inAddr1[0] = addr1[1];
   assign inAddr1[1] = addr1[2];
   assign inAddr1[2] = addr1[3];
   assign inAddr1[3] = addr1[4];
   assign inAddr1[4] = addr1[5];
   assign inAddr1[5] = addr1[0];
   assign outBank1[0] = addr1b[6] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outAddr1[1] = addr1b[2];
   assign outAddr1[2] = addr1b[3];
   assign outAddr1[3] = addr1b[4];
   assign outAddr1[4] = addr1b[5];
   assign outAddr1[5] = addr1b[6];
   assign outBank_a1[0] = addr1c[6] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];
   assign outAddr_a1[1] = addr1c[2];
   assign outAddr_a1[2] = addr1c[3];
   assign outAddr_a1[3] = addr1c[4];
   assign outAddr_a1[4] = addr1c[5];
   assign outAddr_a1[5] = addr1c[6];

   nextReg #(33, 6) nextReg_57980(.X(next), .Y(next0), .reset(reset), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_57983(.X(next0), .Y(next_out), .clk(clk));


   memArray128_55405 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
        outCount_for_rd_data <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 32)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
         if (inCount == 34)
            outCount_for_rd_data <= 0;
         else
            outCount_for_rd_data <= outCount_for_rd_data+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 32) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 63) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 32)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[5];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[5];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[5];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray128_55405(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 64;
   parameter logDepth = 6;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   nextReg #(64, 6) nextReg_57988(.X(next), .Y(next0), .reset(reset), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule

// Latency: 8
// Gap: 64
module DirSum_55836(clk, reset, next, next_out,
      X0, Y0,
      X1, Y1,
      X2, Y2,
      X3, Y3);

   output next_out;
   input clk, reset, next;

   reg [5:0] i2;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   always @(posedge clk) begin
      if (reset == 1) begin
         i2 <= 0;
      end
      else begin
         if (next == 1)
            i2 <= 0;
         else if (i2 == 63)
            i2 <= 0;
         else
            i2 <= i2 + 1;
      end
   end

   codeBlock55410 codeBlockIsnt57993(.clk(clk), .reset(reset), .next_in(next), .next_out(next_out),
.i2_in(i2),
       .X0_in(X0), .Y0(Y0),
       .X1_in(X1), .Y1(Y1),
       .X2_in(X2), .Y2(Y2),
       .X3_in(X3), .Y3(Y3));

endmodule

module D8_55636(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [5:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'hfcdc;
      2: out3 <= 16'hf9ba;
      3: out3 <= 16'hf69c;
      4: out3 <= 16'hf384;
      5: out3 <= 16'hf073;
      6: out3 <= 16'hed6c;
      7: out3 <= 16'hea70;
      8: out3 <= 16'he782;
      9: out3 <= 16'he4a3;
      10: out3 <= 16'he1d5;
      11: out3 <= 16'hdf19;
      12: out3 <= 16'hdc72;
      13: out3 <= 16'hd9e0;
      14: out3 <= 16'hd766;
      15: out3 <= 16'hd505;
      16: out3 <= 16'hd2bf;
      17: out3 <= 16'hd094;
      18: out3 <= 16'hce87;
      19: out3 <= 16'hcc98;
      20: out3 <= 16'hcac9;
      21: out3 <= 16'hc91b;
      22: out3 <= 16'hc78f;
      23: out3 <= 16'hc625;
      24: out3 <= 16'hc4df;
      25: out3 <= 16'hc3be;
      26: out3 <= 16'hc2c1;
      27: out3 <= 16'hc1eb;
      28: out3 <= 16'hc13b;
      29: out3 <= 16'hc0b1;
      30: out3 <= 16'hc04f;
      31: out3 <= 16'hc014;
      32: out3 <= 16'hc000;
      33: out3 <= 16'hc014;
      34: out3 <= 16'hc04f;
      35: out3 <= 16'hc0b1;
      36: out3 <= 16'hc13b;
      37: out3 <= 16'hc1eb;
      38: out3 <= 16'hc2c1;
      39: out3 <= 16'hc3be;
      40: out3 <= 16'hc4df;
      41: out3 <= 16'hc625;
      42: out3 <= 16'hc78f;
      43: out3 <= 16'hc91b;
      44: out3 <= 16'hcac9;
      45: out3 <= 16'hcc98;
      46: out3 <= 16'hce87;
      47: out3 <= 16'hd094;
      48: out3 <= 16'hd2bf;
      49: out3 <= 16'hd505;
      50: out3 <= 16'hd766;
      51: out3 <= 16'hd9e0;
      52: out3 <= 16'hdc72;
      53: out3 <= 16'hdf19;
      54: out3 <= 16'he1d5;
      55: out3 <= 16'he4a3;
      56: out3 <= 16'he782;
      57: out3 <= 16'hea70;
      58: out3 <= 16'hed6c;
      59: out3 <= 16'hf073;
      60: out3 <= 16'hf384;
      61: out3 <= 16'hf69c;
      62: out3 <= 16'hf9ba;
      63: out3 <= 16'hfcdc;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



module D6_55768(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [5:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h3fec;
      2: out3 <= 16'h3fb1;
      3: out3 <= 16'h3f4f;
      4: out3 <= 16'h3ec5;
      5: out3 <= 16'h3e15;
      6: out3 <= 16'h3d3f;
      7: out3 <= 16'h3c42;
      8: out3 <= 16'h3b21;
      9: out3 <= 16'h39db;
      10: out3 <= 16'h3871;
      11: out3 <= 16'h36e5;
      12: out3 <= 16'h3537;
      13: out3 <= 16'h3368;
      14: out3 <= 16'h3179;
      15: out3 <= 16'h2f6c;
      16: out3 <= 16'h2d41;
      17: out3 <= 16'h2afb;
      18: out3 <= 16'h289a;
      19: out3 <= 16'h2620;
      20: out3 <= 16'h238e;
      21: out3 <= 16'h20e7;
      22: out3 <= 16'h1e2b;
      23: out3 <= 16'h1b5d;
      24: out3 <= 16'h187e;
      25: out3 <= 16'h1590;
      26: out3 <= 16'h1294;
      27: out3 <= 16'hf8d;
      28: out3 <= 16'hc7c;
      29: out3 <= 16'h964;
      30: out3 <= 16'h646;
      31: out3 <= 16'h324;
      32: out3 <= 16'h0;
      33: out3 <= 16'hfcdc;
      34: out3 <= 16'hf9ba;
      35: out3 <= 16'hf69c;
      36: out3 <= 16'hf384;
      37: out3 <= 16'hf073;
      38: out3 <= 16'hed6c;
      39: out3 <= 16'hea70;
      40: out3 <= 16'he782;
      41: out3 <= 16'he4a3;
      42: out3 <= 16'he1d5;
      43: out3 <= 16'hdf19;
      44: out3 <= 16'hdc72;
      45: out3 <= 16'hd9e0;
      46: out3 <= 16'hd766;
      47: out3 <= 16'hd505;
      48: out3 <= 16'hd2bf;
      49: out3 <= 16'hd094;
      50: out3 <= 16'hce87;
      51: out3 <= 16'hcc98;
      52: out3 <= 16'hcac9;
      53: out3 <= 16'hc91b;
      54: out3 <= 16'hc78f;
      55: out3 <= 16'hc625;
      56: out3 <= 16'hc4df;
      57: out3 <= 16'hc3be;
      58: out3 <= 16'hc2c1;
      59: out3 <= 16'hc1eb;
      60: out3 <= 16'hc13b;
      61: out3 <= 16'hc0b1;
      62: out3 <= 16'hc04f;
      63: out3 <= 16'hc014;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



// Latency: 8
// Gap: 1
module codeBlock55410(clk, reset, next_in, next_out,
   i2_in,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;
   input [5:0] i2_in;
   reg [5:0] i2;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(7, 1) shiftFIFO_57996(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a113;
   wire signed [15:0] a102;
   wire signed [15:0] a116;
   wire signed [15:0] a106;
   wire signed [15:0] a117;
   wire signed [15:0] a118;
   reg signed [15:0] tm332;
   reg signed [15:0] tm336;
   reg signed [15:0] tm348;
   reg signed [15:0] tm355;
   reg signed [15:0] tm333;
   reg signed [15:0] tm337;
   reg signed [15:0] tm349;
   reg signed [15:0] tm356;
   wire signed [15:0] tm22;
   wire signed [15:0] a107;
   wire signed [15:0] tm23;
   wire signed [15:0] a109;
   reg signed [15:0] tm334;
   reg signed [15:0] tm338;
   reg signed [15:0] tm350;
   reg signed [15:0] tm357;
   reg signed [15:0] tm72;
   reg signed [15:0] tm73;
   reg signed [15:0] tm335;
   reg signed [15:0] tm339;
   reg signed [15:0] tm351;
   reg signed [15:0] tm358;
   reg signed [15:0] tm352;
   reg signed [15:0] tm359;
   wire signed [15:0] a108;
   wire signed [15:0] a110;
   wire signed [15:0] a111;
   wire signed [15:0] a112;
   reg signed [15:0] tm353;
   reg signed [15:0] tm360;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;
   reg signed [15:0] tm354;
   reg signed [15:0] tm361;


   assign a113 = X0;
   assign a102 = a113;
   assign a116 = X1;
   assign a106 = a116;
   assign a117 = X2;
   assign a118 = X3;
   assign a107 = tm22;
   assign a109 = tm23;
   assign Y0 = tm354;
   assign Y1 = tm361;

   D8_55636 instD8inst0_55636(.addr(i2[5:0]), .out(tm23), .clk(clk));

   D6_55768 instD6inst0_55768(.addr(i2[5:0]), .out(tm22), .clk(clk));

    multfix #(16, 2) m55509(.a(tm72), .b(tm335), .clk(clk), .q_sc(a108), .q_unsc(), .rst(reset));
    multfix #(16, 2) m55531(.a(tm73), .b(tm339), .clk(clk), .q_sc(a110), .q_unsc(), .rst(reset));
    multfix #(16, 2) m55549(.a(tm73), .b(tm335), .clk(clk), .q_sc(a111), .q_unsc(), .rst(reset));
    multfix #(16, 2) m55560(.a(tm72), .b(tm339), .clk(clk), .q_sc(a112), .q_unsc(), .rst(reset));
    subfxp #(16, 1) sub55538(.a(a108), .b(a110), .clk(clk), .q(Y2));    // 6
    addfxp #(16, 1) add55567(.a(a111), .b(a112), .clk(clk), .q(Y3));    // 6


   always @(posedge clk) begin
      if (reset == 1) begin
         tm72 <= 0;
         tm335 <= 0;
         tm73 <= 0;
         tm339 <= 0;
         tm73 <= 0;
         tm335 <= 0;
         tm72 <= 0;
         tm339 <= 0;
      end
      else begin
         i2 <= i2_in;
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
         tm332 <= a117;
         tm336 <= a118;
         tm348 <= a102;
         tm355 <= a106;
         tm333 <= tm332;
         tm337 <= tm336;
         tm349 <= tm348;
         tm356 <= tm355;
         tm334 <= tm333;
         tm338 <= tm337;
         tm350 <= tm349;
         tm357 <= tm356;
         tm72 <= a107;
         tm73 <= a109;
         tm335 <= tm334;
         tm339 <= tm338;
         tm351 <= tm350;
         tm358 <= tm357;
         tm352 <= tm351;
         tm359 <= tm358;
         tm353 <= tm352;
         tm360 <= tm359;
         tm354 <= tm353;
         tm361 <= tm360;
      end
   end
endmodule

// Latency: 2
// Gap: 1
module codeBlock55839(clk, reset, next_in, next_out,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(1, 1) shiftFIFO_57999(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a69;
   wire signed [15:0] a70;
   wire signed [15:0] a71;
   wire signed [15:0] a72;
   wire signed [15:0] t45;
   wire signed [15:0] t46;
   wire signed [15:0] t47;
   wire signed [15:0] t48;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;


   assign a69 = X0;
   assign a70 = X2;
   assign a71 = X1;
   assign a72 = X3;
   assign Y0 = t45;
   assign Y1 = t46;
   assign Y2 = t47;
   assign Y3 = t48;

    addfxp #(16, 1) add55851(.a(a69), .b(a70), .clk(clk), .q(t45));    // 0
    addfxp #(16, 1) add55866(.a(a71), .b(a72), .clk(clk), .q(t46));    // 0
    subfxp #(16, 1) sub55881(.a(a69), .b(a70), .clk(clk), .q(t47));    // 0
    subfxp #(16, 1) sub55896(.a(a71), .b(a72), .clk(clk), .q(t48));    // 0


   always @(posedge clk) begin
      if (reset == 1) begin
      end
      else begin
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
      end
   end
endmodule

// Latency: 67
// Gap: 128
module rc55920(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm55918 instPerm58000(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 67
// Gap: 128
module perm55918(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 128;
   parameter logDepth = 7;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[7] ^ addr0[0];
   assign inAddr0[0] = addr0[1];
   assign inAddr0[1] = addr0[2];
   assign inAddr0[2] = addr0[3];
   assign inAddr0[3] = addr0[4];
   assign inAddr0[4] = addr0[5];
   assign inAddr0[5] = addr0[6];
   assign inAddr0[6] = addr0[0];
   assign outBank0[0] = addr0b[7] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outAddr0[1] = addr0b[2];
   assign outAddr0[2] = addr0b[3];
   assign outAddr0[3] = addr0b[4];
   assign outAddr0[4] = addr0b[5];
   assign outAddr0[5] = addr0b[6];
   assign outAddr0[6] = addr0b[7];
   assign outBank_a0[0] = addr0c[7] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];
   assign outAddr_a0[1] = addr0c[2];
   assign outAddr_a0[2] = addr0c[3];
   assign outAddr_a0[3] = addr0c[4];
   assign outAddr_a0[4] = addr0c[5];
   assign outAddr_a0[5] = addr0c[6];
   assign outAddr_a0[6] = addr0c[7];

   assign inBank1[0] = addr1[7] ^ addr1[0];
   assign inAddr1[0] = addr1[1];
   assign inAddr1[1] = addr1[2];
   assign inAddr1[2] = addr1[3];
   assign inAddr1[3] = addr1[4];
   assign inAddr1[4] = addr1[5];
   assign inAddr1[5] = addr1[6];
   assign inAddr1[6] = addr1[0];
   assign outBank1[0] = addr1b[7] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outAddr1[1] = addr1b[2];
   assign outAddr1[2] = addr1b[3];
   assign outAddr1[3] = addr1b[4];
   assign outAddr1[4] = addr1b[5];
   assign outAddr1[5] = addr1b[6];
   assign outAddr1[6] = addr1b[7];
   assign outBank_a1[0] = addr1c[7] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];
   assign outAddr_a1[1] = addr1c[2];
   assign outAddr_a1[2] = addr1c[3];
   assign outAddr_a1[3] = addr1c[4];
   assign outAddr_a1[4] = addr1c[5];
   assign outAddr_a1[5] = addr1c[6];
   assign outAddr_a1[6] = addr1c[7];

   nextReg #(65, 7) nextReg_58005(.X(next), .Y(next0), .reset(reset), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_58008(.X(next0), .Y(next_out), .clk(clk));


   memArray256_55918 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
        outCount_for_rd_data <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 64)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
         if (inCount == 66)
            outCount_for_rd_data <= 0;
         else
            outCount_for_rd_data <= outCount_for_rd_data+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 64) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 127) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 64)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[6];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[6];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[6];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray256_55918(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 128;
   parameter logDepth = 7;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   nextReg #(128, 7) nextReg_58013(.X(next), .Y(next0), .reset(reset), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule

// Latency: 8
// Gap: 128
module DirSum_56604(clk, reset, next, next_out,
      X0, Y0,
      X1, Y1,
      X2, Y2,
      X3, Y3);

   output next_out;
   input clk, reset, next;

   reg [6:0] i1;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   always @(posedge clk) begin
      if (reset == 1) begin
         i1 <= 0;
      end
      else begin
         if (next == 1)
            i1 <= 0;
         else if (i1 == 127)
            i1 <= 0;
         else
            i1 <= i1 + 1;
      end
   end

   codeBlock55922 codeBlockIsnt58018(.clk(clk), .reset(reset), .next_in(next), .next_out(next_out),
.i1_in(i1),
       .X0_in(X0), .Y0(Y0),
       .X1_in(X1), .Y1(Y1),
       .X2_in(X2), .Y2(Y2),
       .X3_in(X3), .Y3(Y3));

endmodule

module D4_56212(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [6:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'hfe6e;
      2: out3 <= 16'hfcdc;
      3: out3 <= 16'hfb4b;
      4: out3 <= 16'hf9ba;
      5: out3 <= 16'hf82a;
      6: out3 <= 16'hf69c;
      7: out3 <= 16'hf50f;
      8: out3 <= 16'hf384;
      9: out3 <= 16'hf1fa;
      10: out3 <= 16'hf073;
      11: out3 <= 16'heeee;
      12: out3 <= 16'hed6c;
      13: out3 <= 16'hebed;
      14: out3 <= 16'hea70;
      15: out3 <= 16'he8f7;
      16: out3 <= 16'he782;
      17: out3 <= 16'he611;
      18: out3 <= 16'he4a3;
      19: out3 <= 16'he33a;
      20: out3 <= 16'he1d5;
      21: out3 <= 16'he074;
      22: out3 <= 16'hdf19;
      23: out3 <= 16'hddc3;
      24: out3 <= 16'hdc72;
      25: out3 <= 16'hdb26;
      26: out3 <= 16'hd9e0;
      27: out3 <= 16'hd8a0;
      28: out3 <= 16'hd766;
      29: out3 <= 16'hd632;
      30: out3 <= 16'hd505;
      31: out3 <= 16'hd3df;
      32: out3 <= 16'hd2bf;
      33: out3 <= 16'hd1a6;
      34: out3 <= 16'hd094;
      35: out3 <= 16'hcf8a;
      36: out3 <= 16'hce87;
      37: out3 <= 16'hcd8c;
      38: out3 <= 16'hcc98;
      39: out3 <= 16'hcbad;
      40: out3 <= 16'hcac9;
      41: out3 <= 16'hc9ee;
      42: out3 <= 16'hc91b;
      43: out3 <= 16'hc850;
      44: out3 <= 16'hc78f;
      45: out3 <= 16'hc6d5;
      46: out3 <= 16'hc625;
      47: out3 <= 16'hc57e;
      48: out3 <= 16'hc4df;
      49: out3 <= 16'hc44a;
      50: out3 <= 16'hc3be;
      51: out3 <= 16'hc33b;
      52: out3 <= 16'hc2c1;
      53: out3 <= 16'hc251;
      54: out3 <= 16'hc1eb;
      55: out3 <= 16'hc18e;
      56: out3 <= 16'hc13b;
      57: out3 <= 16'hc0f1;
      58: out3 <= 16'hc0b1;
      59: out3 <= 16'hc07b;
      60: out3 <= 16'hc04f;
      61: out3 <= 16'hc02c;
      62: out3 <= 16'hc014;
      63: out3 <= 16'hc005;
      64: out3 <= 16'hc000;
      65: out3 <= 16'hc005;
      66: out3 <= 16'hc014;
      67: out3 <= 16'hc02c;
      68: out3 <= 16'hc04f;
      69: out3 <= 16'hc07b;
      70: out3 <= 16'hc0b1;
      71: out3 <= 16'hc0f1;
      72: out3 <= 16'hc13b;
      73: out3 <= 16'hc18e;
      74: out3 <= 16'hc1eb;
      75: out3 <= 16'hc251;
      76: out3 <= 16'hc2c1;
      77: out3 <= 16'hc33b;
      78: out3 <= 16'hc3be;
      79: out3 <= 16'hc44a;
      80: out3 <= 16'hc4df;
      81: out3 <= 16'hc57e;
      82: out3 <= 16'hc625;
      83: out3 <= 16'hc6d5;
      84: out3 <= 16'hc78f;
      85: out3 <= 16'hc850;
      86: out3 <= 16'hc91b;
      87: out3 <= 16'hc9ee;
      88: out3 <= 16'hcac9;
      89: out3 <= 16'hcbad;
      90: out3 <= 16'hcc98;
      91: out3 <= 16'hcd8c;
      92: out3 <= 16'hce87;
      93: out3 <= 16'hcf8a;
      94: out3 <= 16'hd094;
      95: out3 <= 16'hd1a6;
      96: out3 <= 16'hd2bf;
      97: out3 <= 16'hd3df;
      98: out3 <= 16'hd505;
      99: out3 <= 16'hd632;
      100: out3 <= 16'hd766;
      101: out3 <= 16'hd8a0;
      102: out3 <= 16'hd9e0;
      103: out3 <= 16'hdb26;
      104: out3 <= 16'hdc72;
      105: out3 <= 16'hddc3;
      106: out3 <= 16'hdf19;
      107: out3 <= 16'he074;
      108: out3 <= 16'he1d5;
      109: out3 <= 16'he33a;
      110: out3 <= 16'he4a3;
      111: out3 <= 16'he611;
      112: out3 <= 16'he782;
      113: out3 <= 16'he8f7;
      114: out3 <= 16'hea70;
      115: out3 <= 16'hebed;
      116: out3 <= 16'hed6c;
      117: out3 <= 16'heeee;
      118: out3 <= 16'hf073;
      119: out3 <= 16'hf1fa;
      120: out3 <= 16'hf384;
      121: out3 <= 16'hf50f;
      122: out3 <= 16'hf69c;
      123: out3 <= 16'hf82a;
      124: out3 <= 16'hf9ba;
      125: out3 <= 16'hfb4b;
      126: out3 <= 16'hfcdc;
      127: out3 <= 16'hfe6e;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



module D2_56472(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [6:0] addr;

   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h3ffb;
      2: out3 <= 16'h3fec;
      3: out3 <= 16'h3fd4;
      4: out3 <= 16'h3fb1;
      5: out3 <= 16'h3f85;
      6: out3 <= 16'h3f4f;
      7: out3 <= 16'h3f0f;
      8: out3 <= 16'h3ec5;
      9: out3 <= 16'h3e72;
      10: out3 <= 16'h3e15;
      11: out3 <= 16'h3daf;
      12: out3 <= 16'h3d3f;
      13: out3 <= 16'h3cc5;
      14: out3 <= 16'h3c42;
      15: out3 <= 16'h3bb6;
      16: out3 <= 16'h3b21;
      17: out3 <= 16'h3a82;
      18: out3 <= 16'h39db;
      19: out3 <= 16'h392b;
      20: out3 <= 16'h3871;
      21: out3 <= 16'h37b0;
      22: out3 <= 16'h36e5;
      23: out3 <= 16'h3612;
      24: out3 <= 16'h3537;
      25: out3 <= 16'h3453;
      26: out3 <= 16'h3368;
      27: out3 <= 16'h3274;
      28: out3 <= 16'h3179;
      29: out3 <= 16'h3076;
      30: out3 <= 16'h2f6c;
      31: out3 <= 16'h2e5a;
      32: out3 <= 16'h2d41;
      33: out3 <= 16'h2c21;
      34: out3 <= 16'h2afb;
      35: out3 <= 16'h29ce;
      36: out3 <= 16'h289a;
      37: out3 <= 16'h2760;
      38: out3 <= 16'h2620;
      39: out3 <= 16'h24da;
      40: out3 <= 16'h238e;
      41: out3 <= 16'h223d;
      42: out3 <= 16'h20e7;
      43: out3 <= 16'h1f8c;
      44: out3 <= 16'h1e2b;
      45: out3 <= 16'h1cc6;
      46: out3 <= 16'h1b5d;
      47: out3 <= 16'h19ef;
      48: out3 <= 16'h187e;
      49: out3 <= 16'h1709;
      50: out3 <= 16'h1590;
      51: out3 <= 16'h1413;
      52: out3 <= 16'h1294;
      53: out3 <= 16'h1112;
      54: out3 <= 16'hf8d;
      55: out3 <= 16'he06;
      56: out3 <= 16'hc7c;
      57: out3 <= 16'haf1;
      58: out3 <= 16'h964;
      59: out3 <= 16'h7d6;
      60: out3 <= 16'h646;
      61: out3 <= 16'h4b5;
      62: out3 <= 16'h324;
      63: out3 <= 16'h192;
      64: out3 <= 16'h0;
      65: out3 <= 16'hfe6e;
      66: out3 <= 16'hfcdc;
      67: out3 <= 16'hfb4b;
      68: out3 <= 16'hf9ba;
      69: out3 <= 16'hf82a;
      70: out3 <= 16'hf69c;
      71: out3 <= 16'hf50f;
      72: out3 <= 16'hf384;
      73: out3 <= 16'hf1fa;
      74: out3 <= 16'hf073;
      75: out3 <= 16'heeee;
      76: out3 <= 16'hed6c;
      77: out3 <= 16'hebed;
      78: out3 <= 16'hea70;
      79: out3 <= 16'he8f7;
      80: out3 <= 16'he782;
      81: out3 <= 16'he611;
      82: out3 <= 16'he4a3;
      83: out3 <= 16'he33a;
      84: out3 <= 16'he1d5;
      85: out3 <= 16'he074;
      86: out3 <= 16'hdf19;
      87: out3 <= 16'hddc3;
      88: out3 <= 16'hdc72;
      89: out3 <= 16'hdb26;
      90: out3 <= 16'hd9e0;
      91: out3 <= 16'hd8a0;
      92: out3 <= 16'hd766;
      93: out3 <= 16'hd632;
      94: out3 <= 16'hd505;
      95: out3 <= 16'hd3df;
      96: out3 <= 16'hd2bf;
      97: out3 <= 16'hd1a6;
      98: out3 <= 16'hd094;
      99: out3 <= 16'hcf8a;
      100: out3 <= 16'hce87;
      101: out3 <= 16'hcd8c;
      102: out3 <= 16'hcc98;
      103: out3 <= 16'hcbad;
      104: out3 <= 16'hcac9;
      105: out3 <= 16'hc9ee;
      106: out3 <= 16'hc91b;
      107: out3 <= 16'hc850;
      108: out3 <= 16'hc78f;
      109: out3 <= 16'hc6d5;
      110: out3 <= 16'hc625;
      111: out3 <= 16'hc57e;
      112: out3 <= 16'hc4df;
      113: out3 <= 16'hc44a;
      114: out3 <= 16'hc3be;
      115: out3 <= 16'hc33b;
      116: out3 <= 16'hc2c1;
      117: out3 <= 16'hc251;
      118: out3 <= 16'hc1eb;
      119: out3 <= 16'hc18e;
      120: out3 <= 16'hc13b;
      121: out3 <= 16'hc0f1;
      122: out3 <= 16'hc0b1;
      123: out3 <= 16'hc07b;
      124: out3 <= 16'hc04f;
      125: out3 <= 16'hc02c;
      126: out3 <= 16'hc014;
      127: out3 <= 16'hc005;
      default: out3 <= 0;
   endcase
   end
// synthesis attribute rom_style of out3 is "block"
endmodule



// Latency: 8
// Gap: 1
module codeBlock55922(clk, reset, next_in, next_out,
   i1_in,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;
   input [6:0] i1_in;
   reg [6:0] i1;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(7, 1) shiftFIFO_58021(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a53;
   wire signed [15:0] a42;
   wire signed [15:0] a56;
   wire signed [15:0] a46;
   wire signed [15:0] a57;
   wire signed [15:0] a58;
   reg signed [15:0] tm362;
   reg signed [15:0] tm366;
   reg signed [15:0] tm378;
   reg signed [15:0] tm385;
   reg signed [15:0] tm363;
   reg signed [15:0] tm367;
   reg signed [15:0] tm379;
   reg signed [15:0] tm386;
   wire signed [15:0] tm26;
   wire signed [15:0] a47;
   wire signed [15:0] tm27;
   wire signed [15:0] a49;
   reg signed [15:0] tm364;
   reg signed [15:0] tm368;
   reg signed [15:0] tm380;
   reg signed [15:0] tm387;
   reg signed [15:0] tm80;
   reg signed [15:0] tm81;
   reg signed [15:0] tm365;
   reg signed [15:0] tm369;
   reg signed [15:0] tm381;
   reg signed [15:0] tm388;
   reg signed [15:0] tm382;
   reg signed [15:0] tm389;
   wire signed [15:0] a48;
   wire signed [15:0] a50;
   wire signed [15:0] a51;
   wire signed [15:0] a52;
   reg signed [15:0] tm383;
   reg signed [15:0] tm390;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;
   reg signed [15:0] tm384;
   reg signed [15:0] tm391;


   assign a53 = X0;
   assign a42 = a53;
   assign a56 = X1;
   assign a46 = a56;
   assign a57 = X2;
   assign a58 = X3;
   assign a47 = tm26;
   assign a49 = tm27;
   assign Y0 = tm384;
   assign Y1 = tm391;

   D4_56212 instD4inst0_56212(.addr(i1[6:0]), .out(tm27), .clk(clk));

   D2_56472 instD2inst0_56472(.addr(i1[6:0]), .out(tm26), .clk(clk));

    multfix #(16, 2) m56021(.a(tm80), .b(tm365), .clk(clk), .q_sc(a48), .q_unsc(), .rst(reset));
    multfix #(16, 2) m56043(.a(tm81), .b(tm369), .clk(clk), .q_sc(a50), .q_unsc(), .rst(reset));
    multfix #(16, 2) m56061(.a(tm81), .b(tm365), .clk(clk), .q_sc(a51), .q_unsc(), .rst(reset));
    multfix #(16, 2) m56072(.a(tm80), .b(tm369), .clk(clk), .q_sc(a52), .q_unsc(), .rst(reset));
    subfxp #(16, 1) sub56050(.a(a48), .b(a50), .clk(clk), .q(Y2));    // 6
    addfxp #(16, 1) add56079(.a(a51), .b(a52), .clk(clk), .q(Y3));    // 6


   always @(posedge clk) begin
      if (reset == 1) begin
         tm80 <= 0;
         tm365 <= 0;
         tm81 <= 0;
         tm369 <= 0;
         tm81 <= 0;
         tm365 <= 0;
         tm80 <= 0;
         tm369 <= 0;
      end
      else begin
         i1 <= i1_in;
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
         tm362 <= a57;
         tm366 <= a58;
         tm378 <= a42;
         tm385 <= a46;
         tm363 <= tm362;
         tm367 <= tm366;
         tm379 <= tm378;
         tm386 <= tm385;
         tm364 <= tm363;
         tm368 <= tm367;
         tm380 <= tm379;
         tm387 <= tm386;
         tm80 <= a47;
         tm81 <= a49;
         tm365 <= tm364;
         tm369 <= tm368;
         tm381 <= tm380;
         tm388 <= tm387;
         tm382 <= tm381;
         tm389 <= tm388;
         tm383 <= tm382;
         tm390 <= tm389;
         tm384 <= tm383;
         tm391 <= tm390;
      end
   end
endmodule

// Latency: 2
// Gap: 1
module codeBlock56607(clk, reset, next_in, next_out,
   X0_in, Y0,
   X1_in, Y1,
   X2_in, Y2,
   X3_in, Y3);

   output next_out;
   input clk, reset, next_in;

   reg next;

   input [15:0] X0_in,
      X1_in,
      X2_in,
      X3_in;

   reg   [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   shiftRegFIFO #(1, 1) shiftFIFO_58024(.X(next), .Y(next_out), .clk(clk));


   wire signed [15:0] a9;
   wire signed [15:0] a10;
   wire signed [15:0] a11;
   wire signed [15:0] a12;
   wire signed [15:0] t21;
   wire signed [15:0] t22;
   wire signed [15:0] t23;
   wire signed [15:0] t24;
   wire signed [15:0] Y0;
   wire signed [15:0] Y1;
   wire signed [15:0] Y2;
   wire signed [15:0] Y3;


   assign a9 = X0;
   assign a10 = X2;
   assign a11 = X1;
   assign a12 = X3;
   assign Y0 = t21;
   assign Y1 = t22;
   assign Y2 = t23;
   assign Y3 = t24;

    addfxp #(16, 1) add56619(.a(a9), .b(a10), .clk(clk), .q(t21));    // 0
    addfxp #(16, 1) add56634(.a(a11), .b(a12), .clk(clk), .q(t22));    // 0
    subfxp #(16, 1) sub56649(.a(a9), .b(a10), .clk(clk), .q(t23));    // 0
    subfxp #(16, 1) sub56664(.a(a11), .b(a12), .clk(clk), .q(t24));    // 0


   always @(posedge clk) begin
      if (reset == 1) begin
      end
      else begin
         X0 <= X0_in;
         X1 <= X1_in;
         X2 <= X2_in;
         X3 <= X3_in;
         next <= next_in;
      end
   end
endmodule

// Latency: 67
// Gap: 128
module rc56688(clk, reset, next, next_out,
   X0, Y0,
   X1, Y1,
   X2, Y2,
   X3, Y3);

   output next_out;
   input clk, reset, next;

   input [15:0] X0,
      X1,
      X2,
      X3;

   output [15:0] Y0,
      Y1,
      Y2,
      Y3;

   wire [31:0] t0;
   wire [31:0] s0;
   assign t0 = {X0, X1};
   wire [31:0] t1;
   wire [31:0] s1;
   assign t1 = {X2, X3};
   assign Y0 = s0[31:16];
   assign Y1 = s0[15:0];
   assign Y2 = s1[31:16];
   assign Y3 = s1[15:0];

   perm56686 instPerm58025(.x0(t0), .y0(s0),
    .x1(t1), .y1(s1),
   .clk(clk), .next(next), .next_out(next_out), .reset(reset)
);



endmodule

// Latency: 67
// Gap: 128
module perm56686(clk, next, reset, next_out,
   x0, y0,
   x1, y1);
   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 128;
   parameter logDepth = 7;
   parameter width = 32;

   input [width-1:0]  x0;
   output [width-1:0]  y0;
   wire [width-1:0]  ybuff0;
   input [width-1:0]  x1;
   output [width-1:0]  y1;
   wire [width-1:0]  ybuff1;
   input          clk, next, reset;
   output        next_out;

   wire          next0;

   reg              inFlip0, outFlip0;
   reg              inActive, outActive;

   wire [logBanks-1:0] inBank0, outBank0;
   wire [logDepth-1:0] inAddr0, outAddr0;
   wire [logBanks-1:0] outBank_a0;
   wire [logDepth-1:0] outAddr_a0;
   wire [logDepth+logBanks-1:0] addr0, addr0b, addr0c;
   wire [logBanks-1:0] inBank1, outBank1;
   wire [logDepth-1:0] inAddr1, outAddr1;
   wire [logBanks-1:0] outBank_a1;
   wire [logDepth-1:0] outAddr_a1;
   wire [logDepth+logBanks-1:0] addr1, addr1b, addr1c;


   reg [logDepth-1:0]  inCount, outCount, outCount_d, outCount_dd, outCount_for_rd_addr, outCount_for_rd_data;

   assign    addr0 = {inCount, 1'd0};
   assign    addr0b = {outCount, 1'd0};
   assign    addr0c = {outCount_for_rd_addr, 1'd0};
   assign    addr1 = {inCount, 1'd1};
   assign    addr1b = {outCount, 1'd1};
   assign    addr1c = {outCount_for_rd_addr, 1'd1};
    wire [width+logDepth-1:0] w_0_0, w_0_1, w_1_0, w_1_1;

    reg [width-1:0] z_0_0;
    reg [width-1:0] z_0_1;
    wire [width-1:0] z_1_0, z_1_1;

    wire [logDepth-1:0] u_0_0, u_0_1, u_1_0, u_1_1;

    always @(posedge clk) begin
    end

   assign inBank0[0] = addr0[1] ^ addr0[0];
   assign inAddr0[0] = addr0[2];
   assign inAddr0[1] = addr0[3];
   assign inAddr0[2] = addr0[4];
   assign inAddr0[3] = addr0[5];
   assign inAddr0[4] = addr0[6];
   assign inAddr0[5] = addr0[7];
   assign inAddr0[6] = addr0[0];
   assign outBank0[0] = addr0b[7] ^ addr0b[0];
   assign outAddr0[0] = addr0b[1];
   assign outAddr0[1] = addr0b[2];
   assign outAddr0[2] = addr0b[3];
   assign outAddr0[3] = addr0b[4];
   assign outAddr0[4] = addr0b[5];
   assign outAddr0[5] = addr0b[6];
   assign outAddr0[6] = addr0b[7];
   assign outBank_a0[0] = addr0c[7] ^ addr0c[0];
   assign outAddr_a0[0] = addr0c[1];
   assign outAddr_a0[1] = addr0c[2];
   assign outAddr_a0[2] = addr0c[3];
   assign outAddr_a0[3] = addr0c[4];
   assign outAddr_a0[4] = addr0c[5];
   assign outAddr_a0[5] = addr0c[6];
   assign outAddr_a0[6] = addr0c[7];

   assign inBank1[0] = addr1[1] ^ addr1[0];
   assign inAddr1[0] = addr1[2];
   assign inAddr1[1] = addr1[3];
   assign inAddr1[2] = addr1[4];
   assign inAddr1[3] = addr1[5];
   assign inAddr1[4] = addr1[6];
   assign inAddr1[5] = addr1[7];
   assign inAddr1[6] = addr1[0];
   assign outBank1[0] = addr1b[7] ^ addr1b[0];
   assign outAddr1[0] = addr1b[1];
   assign outAddr1[1] = addr1b[2];
   assign outAddr1[2] = addr1b[3];
   assign outAddr1[3] = addr1b[4];
   assign outAddr1[4] = addr1b[5];
   assign outAddr1[5] = addr1b[6];
   assign outAddr1[6] = addr1b[7];
   assign outBank_a1[0] = addr1c[7] ^ addr1c[0];
   assign outAddr_a1[0] = addr1c[1];
   assign outAddr_a1[1] = addr1c[2];
   assign outAddr_a1[2] = addr1c[3];
   assign outAddr_a1[3] = addr1c[4];
   assign outAddr_a1[4] = addr1c[5];
   assign outAddr_a1[5] = addr1c[6];
   assign outAddr_a1[6] = addr1c[7];

   nextReg #(65, 7) nextReg_58030(.X(next), .Y(next0), .reset(reset), .clk(clk));


   shiftRegFIFO #(2, 1) shiftFIFO_58033(.X(next0), .Y(next_out), .clk(clk));


   memArray256_56686 #(numBanks, logBanks, depth, logDepth, width)
     memSys(.inFlip(inFlip0), .outFlip(outFlip0), .next(next), .reset(reset),
        .x0(w_1_0[width+logDepth-1:logDepth]), .y0(ybuff0),
        .inAddr0(w_1_0[logDepth-1:0]),
        .outAddr0(u_1_0),
        .x1(w_1_1[width+logDepth-1:logDepth]), .y1(ybuff1),
        .inAddr1(w_1_1[logDepth-1:0]),
        .outAddr1(u_1_1),
        .clk(clk));

   always @(posedge clk) begin
      if (reset == 1) begin
      z_0_0 <= 0;
      z_0_1 <= 0;
         inFlip0 <= 0; outFlip0 <= 1; outCount <= 0; inCount <= 0;
        outCount_for_rd_addr <= 0;
        outCount_for_rd_data <= 0;
      end
      else begin
          outCount_d <= outCount;
          outCount_dd <= outCount_d;
         if (inCount == 64)
            outCount_for_rd_addr <= 0;
         else
            outCount_for_rd_addr <= outCount_for_rd_addr+1;
         if (inCount == 66)
            outCount_for_rd_data <= 0;
         else
            outCount_for_rd_data <= outCount_for_rd_data+1;
      z_0_0 <= ybuff0;
      z_0_1 <= ybuff1;
         if (inCount == 64) begin
            outFlip0 <= ~outFlip0;
            outCount <= 0;
         end
         else
            outCount <= outCount+1;
         if (inCount == 127) begin
            inFlip0 <= ~inFlip0;
         end
         if (next == 1) begin
            if (inCount >= 64)
               inFlip0 <= ~inFlip0;
            inCount <= 0;
         end
         else
            inCount <= inCount + 1;
      end
   end
    assign w_0_0 = {x0, inAddr0};
    assign w_0_1 = {x1, inAddr1};
    assign y0 = z_1_0;
    assign y1 = z_1_1;
    assign u_0_0 = outAddr_a0;
    assign u_0_1 = outAddr_a1;
    wire wr_ctrl_st_0;
    assign wr_ctrl_st_0 = inCount[0];

    switch #(logDepth+width) in_sw_0_0(.x0(w_0_0), .x1(w_0_1), .y0(w_1_0), .y1(w_1_1), .ctrl(wr_ctrl_st_0));
    wire rdd_ctrl_st_0;
    assign rdd_ctrl_st_0 = outCount_for_rd_data[6];

    switch #(width) out_sw_0_0(.x0(z_0_0), .x1(z_0_1), .y0(z_1_0), .y1(z_1_1), .ctrl(rdd_ctrl_st_0));
    wire rda_ctrl_st_0;
    assign rda_ctrl_st_0 = outCount_for_rd_addr[6];

    switch #(logDepth) rdaddr_sw_0_0(.x0(u_0_0), .x1(u_0_1), .y0(u_1_0), .y1(u_1_1), .ctrl(rda_ctrl_st_0));
endmodule

module memArray256_56686(next, reset,
                x0, y0,
                inAddr0,
                outAddr0,
                x1, y1,
                inAddr1,
                outAddr1,
                clk, inFlip, outFlip);

   parameter numBanks = 2;
   parameter logBanks = 1;
   parameter depth = 128;
   parameter logDepth = 7;
   parameter width = 32;

   input     clk, next, reset;
   input    inFlip, outFlip;
   wire    next0;

   input [width-1:0]   x0;
   output [width-1:0]  y0;
   input [logDepth-1:0] inAddr0, outAddr0;
   input [width-1:0]   x1;
   output [width-1:0]  y1;
   input [logDepth-1:0] inAddr1, outAddr1;
   nextReg #(128, 7) nextReg_58038(.X(next), .Y(next0), .reset(reset), .clk(clk));


   memMod #(depth*2, width, logDepth+1)
     memMod0(.in(x0), .out(y0), .inAddr({inFlip, inAddr0}),
       .outAddr({outFlip, outAddr0}), .writeSel(1'b1), .clk(clk));
   memMod #(depth*2, width, logDepth+1)
     memMod1(.in(x1), .out(y1), .inAddr({inFlip, inAddr1}),
       .outAddr({outFlip, outAddr1}), .writeSel(1'b1), .clk(clk));
endmodule


                        module multfix(clk, rst, a, b, q_sc, q_unsc);
                           parameter WIDTH=35, CYCLES=6;

                           input signed [WIDTH-1:0]    a,b;
                           output [WIDTH-1:0]          q_sc;
                           output [WIDTH-1:0]              q_unsc;

                           input                       clk, rst;

                           reg signed [2*WIDTH-1:0]    q[CYCLES-1:0];
                           wire signed [2*WIDTH-1:0]   res;
                           integer                     i;

                           assign                      res = q[CYCLES-1];

                           assign                      q_unsc = res[WIDTH-1:0];
                           assign                      q_sc = {res[2*WIDTH-1], res[2*WIDTH-4:WIDTH-2]};

                           always @(posedge clk) begin
                              q[0] <= a * b;
                              for (i = 1; i < CYCLES; i=i+1) begin
                                 q[i] <= q[i-1];
                              end
                           end

                        endmodule
module addfxp(a, b, q, clk);

   parameter width = 16, cycles=1;

   input signed [width-1:0]  a, b;
   input                     clk;
   output signed [width-1:0] q;
   reg signed [width-1:0]    res[cycles-1:0];

   assign                    q = res[cycles-1];

   integer                   i;

   always @(posedge clk) begin
     res[0] <= a+b;
      for (i=1; i < cycles; i = i+1)
        res[i] <= res[i-1];

   end

endmodule

module subfxp(a, b, q, clk);

   parameter width = 16, cycles=1;

   input signed [width-1:0]  a, b;
   input                     clk;
   output signed [width-1:0] q;
   reg signed [width-1:0]    res[cycles-1:0];

   assign                    q = res[cycles-1];

   integer                   i;

   always @(posedge clk) begin
     res[0] <= a-b;
      for (i=1; i < cycles; i = i+1)
        res[i] <= res[i-1];

   end

endmodule

module fft_dft (
        input wire                 clk,
        input wire                 reset,

        input wire                 in_valid,
        input wire         [31:0]  X,

        output reg                 out_valid,
        output reg         [63:0]  Y
);

    wire [15:0] X0;
    wire [15:0] X1;
    wire [15:0] X2;
    wire [15:0] X3;

    wire [15:0] Y0;
    wire [15:0] Y1;
    wire [15:0] Y2;
    wire [15:0] Y3;

    dft_top fft_gen (
        .clk     (clk),
        .reset   (reset),
        .next    (next_in),
        .next_out(next_out),
        .X0(X0), .Y0(Y0),
        .X1(X1), .Y1(Y1),
        .X2(X2), .Y2(Y2),
        .X3(X3), .Y3(Y3)
    );

    reg [31:0] fft_cntr_out;
    reg [7:0]  state;
    reg        flag_fft_out;
    reg [7:0]  state_in;
    reg [7:0]  state_out;

    parameter WAIT   = 8'd0
            , UNSET_IN = 8'd3
            , END      = 8'd4
            , VALID_OUT = 8'd5
            , GET_IN = 8'd6
            , FFT_SIZE = 32'd128;

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            next_in <= 0;
            state_in <= WAIT;
        end begin
            case (state_in)
                WAIT:
                    if (in_valid == 1'b1) begin
                        next_in  <= 1;
                        state_in <= UNSET_IN;
                    end
                UNSET_IN:
                    begin
                        next_in  <= 0;
                        state_in <= GET_IN;
                    end
                GET_IN:
                    if (in_valid == 1) begin
                        X0 <= X[31:16];
                        X1 <= 16'b0;
                        X2 <= X[15:0];
                        X3 <= 16'b0;
                    end else begin
                        state_in <= END;
                    end
            endcase
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            fft_cntr_out <= 0;
        end else begin
            if (fft_cntr_out < FFT_SIZE && state_out == VALID_OUT) begin
                fft_cntr_out <= fft_cntr_out + 1;
            end else if (fft_cntr_out >= FFT_SIZE) begin
                fft_cntr_out <= 0;
            end
        end
    end

    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            state_out <= WAIT;
            out_valid <= 1'b0;
        end begin
            case (state_out)
                WAIT:
                    if (next_out) begin
                        state_out <= VALID_OUT;
                    end
                VALID_OUT:
                    if (fft_cntr_out < FFT_SIZE) begin
                        out_valid <= 1'b1;
                        Y[63:48] = Y0;
                        Y[47:32] = Y1;
                        Y[31:16] = Y2;
                        Y[15:0]  = Y3;
                        state_out <= END;
                    end else begin
                        out_valid <= 1'b0;
                    end
            endcase
        end
    end

endmodule