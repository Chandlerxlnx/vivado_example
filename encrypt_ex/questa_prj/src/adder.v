`pragma protect begin
module adder(
   input clk,
   input rst,
   input [7:0] a_in,
   input [7:0] b_in,
   output reg[8:0] sum_o
);

`pragma protect viewport
  always@(posedge clk or posedge rst)
  if(rst) sum_o <=0;
  else sum_o <= a_in + b_in;

endmodule

`pragma protect end
