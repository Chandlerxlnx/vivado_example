set_property direction OUT [get_ports {port_o1_N}]
set_property direction IN [get_ports {port_1_N}]
set_property direction IN [get_ports {clk_in_p}]
set_property direction IN [get_ports {clk_in_N}]
set_property direction OUT [get_ports {port_o1}]
set_property direction IN [get_ports {port_in1_p}]
make_diff_pair_ports clk_in_p clk_in_N
make_diff_pair_ports port_o1 port_o1_N
make_diff_pair_ports port_in1_p port_1_N
set_property IOSTANDARD LVDS_25 [get_ports port_in1_p]
set_property IOSTANDARD LVDS_25 [get_ports clk_in_p]
set_property PACKAGE_PIN J2 [get_ports clk_in_p]
set_property PACKAGE_PIN H2 [get_ports clk_in_N]
set_property PACKAGE_PIN K1 [get_ports port_in1_p]
set_property PACKAGE_PIN J1 [get_ports port_1_N]
set_property IOSTANDARD LVDS_25 [get_ports port_o1]
set_property PACKAGE_PIN M1 [get_ports port_o1]
set_property PACKAGE_PIN L1 [get_ports port_o1_N]

# example of enable DIFF_TERM
set_property DIFF_TERM TRUE [get_ports clk_in_p]
set_property DIFF_TERM FALSE [get_ports port_in1_p]

#revert back to original instance
current_instance -quiet
