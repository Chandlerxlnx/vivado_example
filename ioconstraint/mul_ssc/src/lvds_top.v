module lvds_top(
  input lvds_clkin_p,
  input lvds_clkin_n,
  input rst,
  input [3:0] lvds_din_p,
  input [3:0] lvds_din_n,
  output [3:0] lvds_dout_p,
  output [3:0] lvds_dout_n,
  output lvds_clkout_p,
  output lvds_clkout_n
);
 wire [27:0] lvds_dat_0;
 reg [27:0]  lvds_dat_1;
 reg [27:0]  lvds_dat_2;
 wire 		lvds_clk;
 wire		clk,clkb,clkdiv;
 reg rst_sync0,rst_sync1;
 always@(posedge clkdiv or posedge rst)
 if(rst) begin
     rst_sync0 <=1;
     rst_sync1 <=1;
 end
 else begin
    rst_sync0 <=0;
    rst_sync1 <=rst_sync0;
 end
IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_clk (
      .O(lvds_clk),  // Buffer output
      .I(lvds_clkin_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(lvds_clkin_n) // Diff_n buffer input (connect directly to top-level port)
   );

 
   always@(posedge clkdiv)begin
	lvds_dat_1 <=lvds_dat_0;
	lvds_dat_2 <=lvds_dat_1;
   end

lvds_in ulvdsin(
   .clk		(clk	),
   .clkb	(clkb	),
   .clkdiv	(clkdiv	),
   .rst		(rst_sync1	),
   .lvdsin_p	(lvds_din_p	),
   .lvdsin_n	(lvds_din_n	),
   .dat_out	(lvds_dat_0	)
    );

lvds_out ulvdsout(
	.clk		(clk		),
	.clkb		(clkb		),
	.clkdiv		(clkdiv		),
	.rst		(rst_sync1		),
	.lvdsout_p	(lvds_dout_p	),
	.lvdsout_n	(lvds_dout_n	),
	.lvdsclk_p	(lvds_clkout_p	),
	.lvdsclk_n	(lvds_clkout_n	),
	.dat_in		(lvds_dat_2		)
    );
    
 clk_lvds uclklvds
   (
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
    .clk_out2(clkb),     // output clk_out2
    .clk_out3(clkdiv),     // output clk_out3
    // Status and control signals
    .reset(rst), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(lvds_clk)      // input clk_in1
);
endmodule
