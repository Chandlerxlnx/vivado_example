set_property direction OUT [get_ports {lvds_o1_N}]
set_property direction IN [get_ports {lvds_in1_N}]
set_property direction IN [get_ports {clk_in_P}]
set_property direction IN [get_ports {clk_in_N}]
set_property direction OUT [get_ports {lvds_o1_P}]
set_property direction IN [get_ports {lvds_in1_P}]
#make_diff_pair_ports clk_in_P clk_in_N
#make_diff_pair_ports lvds_o1_P lvds_o1_N
#make_diff_pair_ports lvds_in1_P port_1_N
set_property IOSTANDARD LVDS_25 [get_ports lvds_in1*]
set_property IOSTANDARD LVDS_25 [get_ports clk_in_*]
set_property PACKAGE_PIN J2 [get_ports clk_in_P]
set_property PACKAGE_PIN H2 [get_ports clk_in_N]
set_property PACKAGE_PIN K1 [get_ports lvds_in1_P]
set_property PACKAGE_PIN J1 [get_ports lvds_in1_N]
set_property IOSTANDARD LVDS_25 [get_ports lvds_*]
set_property PACKAGE_PIN M1 [get_ports lvds_o1_P]
set_property PACKAGE_PIN L1 [get_ports lvds_o1_N]

# example of enable DIFF_TERM
set_property DIFF_TERM TRUE [get_ports clk_in_P]
set_property DIFF_TERM FALSE [get_ports lvds_in1_P]

#revert back to original instance
current_instance -quiet
