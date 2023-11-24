/*
* no function in this design, example for IO timing constraint.
  The data is DDR
*/

module spi_io #(parameter CLKDIV =4,
		parameter BITWIDTH=8)(
	input clk,
	input rst_n,
	input pad_spi_din,
	output pad_spi_dout,
	output pad_spi_sync_o,
	output pad_spi_clk_o,
	input [BITWIDTH-1:0] tx_din,
	input 	sync_in,
	output reg [BITWIDTH-1:0] rx_dout
);


reg [1<<(CLKDIV/2)-1:0]   clk_cnt;
reg [1<<(BITWIDTH/2)-1:0] bit_cnt;

reg                       spi_din_d,spi_dout_d,spi_sync_d,spi_clk_d;
reg                       spi_clk, spi_sync,spi_dout;

wire                      clk_redg,clk_fedg;


always@(posedge clk or negedge rst_n)
	if(!rst_n) spi_din_d <=0;
	else spi_din_d <=pad_spi_din;

always@(posedge clk or negedge rst_n)
	if(!rst_n) clk_cnt <=CLKDIV/2-1;
	else if(clk_cnt>=(CLKDIV-1)) clk_cnt<=0;
	else clk_cnt <=clk_cnt+1;

assign clk_redg = clk_cnt==0;
assign clk_fedg = clk_cnt ==(CLKDIV/2-1);

always@(posedge clk or negedge rst_n)
	if(!rst_n) bit_cnt <=0;
	else if (clk_redg || clk_fedg) 
		bit_cnt <= bit_cnt ==(BITWIDTH-1)?0: bit_cnt+1;

always@(posedge clk )
	if(clk_redg || clk_fedg) spi_dout <= tx_din[bit_cnt];
always@(posedge clk)
	spi_dout_d <= spi_dout;

always@(posedge clk)
		if(clk_redg || clk_fedg) rx_dout[bit_cnt] <=spi_din_d;

//always@(posedge clk)
//	spi_din_d <= pad_spi_din;
	
assign pad_spi_dout = spi_dout_d;

always@(posedge clk)
	if(clk_redg) spi_clk <=1;
	else if(clk_fedg) spi_clk <=0;
always@(posedge clk)
	if(clk_redg)spi_sync <= sync_in;

always@(posedge clk)
	spi_sync_d <= spi_sync;
always@(posedge clk)
	spi_clk_d <= spi_clk;

assign pad_spi_dout =spi_dout_d;
assign pad_spi_sync_o = spi_sync_d;
assign pad_spi_clk_o = spi_clk_d;

endmodule

