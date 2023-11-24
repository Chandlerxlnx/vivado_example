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


module lvds_in(
input   clk,clkb,
input   clkdiv,
input   rst,
input [3:0] lvdsin_p,
input [3:0] lvdsin_n,
output [27:0] dat_out
    );
 
 wire     CE1,CE2;
wire      CLKDIVP;
wire      OCLK;

wire [3:0] lvds_din;

assign CE1 =1;
assign CE2 =1;
assign CLKDIVP =0;
assign OCLK =0; 
//wire [27:0] lvds_out;
//
IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst[3:0] (
      .O(lvds_din),  // Buffer output
      .I(lvdsin_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(lvdsin_n) // Diff_n buffer input (connect directly to top-level port)
   );
generate 
genvar i;
  for(i=0;i<4;i=i+1) begin
      ISERDESE2 #(
      .DATA_RATE		("DDR"),           // DDR, SDR
      .DATA_WIDTH		(7),              // Parallel data width 		(2-8,10,14)
      .DYN_CLKDIV_INV_EN		("FALSE"), // Enable DYNCLKDIVINVSEL inversion 		(FALSE, TRUE)
      .DYN_CLK_INV_EN		("FALSE"),    // Enable DYNCLKINVSEL inversion 		(FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs 		(0/1)
      .INIT_Q1		(1'b0),
      .INIT_Q2		(1'b0),
      .INIT_Q3		(1'b0),
      .INIT_Q4		(1'b0),
      .INTERFACE_TYPE		("MEMORY"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY		("NONE"),           // NONE, BOTH, IBUF, IFD
      .NUM_CE		(2),                  // Number of clock enables 		(1,2)
      .OFB_USED		("FALSE"),          // Select OFB path 		(FALSE, TRUE)
      .SERDES_MODE		("MASTER"),      // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used 		(0/1)
      .SRVAL_Q1		(1'b0),
      .SRVAL_Q2		(1'b0),
      .SRVAL_Q3		(1'b0),
      .SRVAL_Q4		(1'b0)
   )
   ISERDESE2_inst 		(
      .O		(O),                       // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit 		(each) output: Registered data outputs
      .Q1		(dat_out[i*7]),
      .Q2		(dat_out[i*7+1]),
      .Q3		(dat_out[i*7+2]),
      .Q4		(dat_out[i*7+3]),
      .Q5		(dat_out[i*7+4]),
      .Q6		(dat_out[i*7+5]),
      .Q7		(dat_out[i*7+6]),
      .Q8		(),
      // SHIFTOUT1, SHIFTOUT2: 1-bit 		(each) output: Data width expansion output ports
      .SHIFTOUT1		(),
      .SHIFTOUT2		(),
      .BITSLIP		(BITSLIP),           // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                   // CLKDIV when asserted 		(active High). Subsequently, the data seen on the Q1
                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                   // position every time Bitslip is invoked 		(DDR operation is different from
                                   // SDR).

      // CE1, CE2: 1-bit 		(each) input: Data register clock enable inputs
      .CE1		(CE1),
      .CE2		(CE2),
      .CLKDIVP		(CLKDIVP),           // 1-bit input: TBD
      // Clocks: 1-bit 		(each) input: ISERDESE2 clock input ports
      .CLK		(clk),                   // 1-bit input: High-speed clock
      .CLKB		(clkb),                 // 1-bit input: High-speed secondary clock
      .CLKDIV		(clkdiv),             // 1-bit input: Divided clock
      .OCLK		(OCLK),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      // Dynamic Clock Inversions: 1-bit 		(each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL		(DYNCLKDIVSEL), // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL		(DYNCLKSEL),       // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit 		(each) input: ISERDESE2 data input ports
      .D		(lvds_din[i]),                       // 1-bit input: Data input
      .DDLY		(1'b0),//(DDLY[i]),                 // 1-bit input: Serial data from IDELAYE2
      .OFB		(1'b0),//(OFB),                   // 1-bit input: Data feedback from OSERDESE2
      .OCLKB		(OCLKB),               // 1-bit input: High speed negative edge output clock
      .RST		(rst),                   // 1-bit input: Active high asynchronous reset
      // SHIFTIN1, SHIFTIN2: 1-bit 		(each) input: Data width expansion input ports
      .SHIFTIN1		(SHIFTIN1),
      .SHIFTIN2		(SHIFTIN2)
   );
 end
 endgenerate
 
endmodule
