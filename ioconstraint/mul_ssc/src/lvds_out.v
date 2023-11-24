`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2023 06:18:34 AM
// Design Name: 
// Module Name: lvds_in
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lvds_out #(parameter CLOCK_DATA=7'B1000011)(
input   clk,clkb,
input   clkdiv,
input   rst,
output [3:0] lvdsout_p,
output [3:0] lvdsout_n,
output       lvdsclk_p,
output       lvdsclk_n,
input [27:0] dat_in
    );
 
 wire     CE1,CE2;
wire      CLKDIVP;
wire      OCLK;

wire [3:0] lvds_dout;
wire		lvds_clk;

assign CE1 =1;
assign CE2 =1;
assign CLKDIVP =0;
assign OCLK =0; 
//wire [27:0] lvds_out;
//
   OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_inst[3:0] (
      .O(lvdsout_p),     // Diff_p output (connect directly to top-level port)
      .OB(lvdsout_n),   // Diff_n output (connect directly to top-level port)
      .I(lvds_dout)      // Buffer input
   );
   OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_clk (
      .O(lvdsclk_p),     // Diff_p output (connect directly to top-level port)
      .OB(lvdsclk_n),   // Diff_n output (connect directly to top-level port)
      .I(lvds_clk)      // Buffer input
   );

generate 
genvar i;
  for(i=0;i<4;i=i+1) begin
OSERDESE2 #(
      .DATA_RATE_OQ		("DDR"),   // DDR, SDR
      .DATA_RATE_TQ		("DDR"),   // DDR, BUF, SDR
      .DATA_WIDTH		(7),         // Parallel data width 		(2-8,10,14)
      .INIT_OQ			(1'b0),         // Initial value of OQ output 		(1'b0,1'b1)
      .INIT_TQ			(1'b0),         // Initial value of TQ output 		(1'b0,1'b1)
      .SERDES_MODE		("MASTER"), // MASTER, SLAVE
      .SRVAL_OQ			(1'b0),        // OQ output value when SR is used 		(1'b0,1'b1)
      .SRVAL_TQ			(1'b0),        // TQ output value when SR is used 		(1'b0,1'b1)
      .TBYTE_CTL		("FALSE"),    // Enable tristate byte operation 		(FALSE, TRUE)
      .TBYTE_SRC		("FALSE"),    // Tristate byte source 		(FALSE, TRUE)
      .TRISTATE_WIDTH		(1)      // 3-state converter width 		(1,4)
   )
   OSERDAT_inst 		(
      .OFB			(),//(OFB),             // 1-bit output: Feedback path for data
      .OQ			(lvds_dout[i]),//(OQ),               // 1-bit output: Data path output
      // SHIFTOUT1 / SHIFTOUT2: 1-bit 		(each) output: Data output expansion 		(1-bit each)
      .SHIFTOUT1		(),//(SHIFTOUT1),
      .SHIFTOUT2		(),//(SHIFTOUT2),
      .TBYTEOUT		(),//(TBYTEOUT),   // 1-bit output: Byte group tristate
      .TFB		(),//(TFB),             // 1-bit output: 3-state control
      .TQ		(),//(TQ),               // 1-bit output: 3-state control
      .CLK		(clk),             // 1-bit input: High speed clock
      .CLKDIV		(clkdiv),       // 1-bit input: Divided clock
      // D1 - D8: 1-bit 		(each) input: Parallel data inputs 		(1-bit each)
      .D1		(dat_in[i*7+0]),
      .D2		(dat_in[i*7+1]),
      .D3		(dat_in[i*7+2]),
      .D4		(dat_in[i*7+3]),
      .D5		(dat_in[i*7+4]),
      .D6		(dat_in[i*7+5]),
      .D7		(dat_in[i*7+6]),
      .D8		(1'b0),
      .OCE		(1'b1),             // 1-bit input: Output data clock enable
      .RST		(rst),             // 1-bit input: Reset
      // SHIFTIN1 / SHIFTIN2: 1-bit 		(each) input: Data input expansion 		(1-bit each)
      .SHIFTIN1		(1'b0),
      .SHIFTIN2		(1'b0),
      // T1 - T4: 1-bit 		(each) input: Parallel 3-state inputs
      .T1		(1'b0),
      .T2		(1'b0),
      .T3		(1'b0),
      .T4		(1'b0),
      .TBYTEIN		(1'b0),     // 1-bit input: Byte group tristate
      .TCE		(1'b0)              // 1-bit input: 3-state clock enable
   );
	
 end
 endgenerate

 OSERDESE2 #(
      .DATA_RATE_OQ		("DDR"),   // DDR, SDR
      .DATA_RATE_TQ		("DDR"),   // DDR, BUF, SDR
      .DATA_WIDTH		(7),         // Parallel data width 		(2-8,10,14)
      .INIT_OQ			(1'b0),         // Initial value of OQ output 		(1'b0,1'b1)
      .INIT_TQ			(1'b0),         // Initial value of TQ output 		(1'b0,1'b1)
      .SERDES_MODE		("MASTER"), // MASTER, SLAVE
      .SRVAL_OQ			(1'b0),        // OQ output value when SR is used 		(1'b0,1'b1)
      .SRVAL_TQ			(1'b0),        // TQ output value when SR is used 		(1'b0,1'b1)
      .TBYTE_CTL		("FALSE"),    // Enable tristate byte operation 		(FALSE, TRUE)
      .TBYTE_SRC		("FALSE"),    // Tristate byte source 		(FALSE, TRUE)
      .TRISTATE_WIDTH		(1)      // 3-state converter width 		(1,4)
   )
   OSERCLK_inst 		(
      .OFB			(),//(OFB),             // 1-bit output: Feedback path for data
      .OQ			(lvds_clk),//(OQ),               // 1-bit output: Data path output
      // SHIFTOUT1 / SHIFTOUT2: 1-bit 		(each) output: Data output expansion 		(1-bit each)
      .SHIFTOUT1		(),//(SHIFTOUT1),
      .SHIFTOUT2		(),//(SHIFTOUT2),
      .TBYTEOUT		(),//(TBYTEOUT),   // 1-bit output: Byte group tristate
      .TFB		(),//(TFB),             // 1-bit output: 3-state control
      .TQ		(),//(TQ),               // 1-bit output: 3-state control
      .CLK		(clk),             // 1-bit input: High speed clock
      .CLKDIV		(clkdiv),       // 1-bit input: Divided clock
      // D1 - D8: 1-bit 		(each) input: Parallel data inputs 		(1-bit each)
      .D1		(CLOCK_DATA[0]),
      .D2		(CLOCK_DATA[1]),
      .D3		(CLOCK_DATA[2]),
      .D4		(CLOCK_DATA[3]),
      .D5		(CLOCK_DATA[4]),
      .D6		(CLOCK_DATA[5]),
      .D7		(CLOCK_DATA[6]),
      .D8		(1'b0),
      .OCE		(1'b1),             // 1-bit input: Output data clock enable
      .RST		(rst),             // 1-bit input: Reset
      // SHIFTIN1 / SHIFTIN2: 1-bit 		(each) input: Data input expansion 		(1-bit each)
      .SHIFTIN1		(1'b0),
      .SHIFTIN2		(1'b0),
      // T1 - T4: 1-bit 		(each) input: Parallel 3-state inputs
      .T1		(1'b0),
      .T2		(1'b0),
      .T3		(1'b0),
      .T4		(1'b0),
      .TBYTEIN		(1'b0),     // 1-bit input: Byte group tristate
      .TCE		(1'b0)              // 1-bit input: 3-state clock enable
   );

endmodule
