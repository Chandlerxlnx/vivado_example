`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2024 08:17:15 PM
// Design Name: 
// Module Name: hbm_top
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
`timescale 1ns/1ns

module hbm_tb(

    );
    
    reg clk;
    reg rst;

initial begin
    clk =0;
    rst =0;
    #1000 rst =1;
end

always #5 clk =!clk;

///-------------------------------------------------------------------------------
//DUT
design_1_wrapper DUT
   (.CLK_IN_D_0_clk_n   (!clk),
    .CLK_IN_D_0_clk_p   (clk),
    .reset_0            (rst));
    /*
    design_1_wrapper inst_bd
   (.CLK_IN_D_0_clk_n    (~clk),
    .CLK_IN_D_0_clk_p    (clk),
    .reset_0             (rst)
    );
    */
endmodule
