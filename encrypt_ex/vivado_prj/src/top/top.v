module top(
    input clk,
   input rst,
   input [7:0] a_in,
   input [7:0] b_in,
   output [8:0] sum_o
);

adder inst_add(
   .clk  (clk),
   .rst  (rst),
   .a_in (a_in),
   .b_in (b_in),
   .sum_o(sum_o)
);
endmodule

