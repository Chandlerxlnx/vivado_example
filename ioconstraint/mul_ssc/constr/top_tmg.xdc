create_clock -p 10 [get_ports lvds_clkin_p] -name lvds_clk

#+----------------------------------------------------------------------------------------
# example of source sync clock and conreponding output delay
#create_generated_clock -source [get_ports lvds_clkin_p] -multiply_by 7 \
#    -master_clock [get_clocks lvds_clk] -add -name lvds_hclk_o [get_ports lvds_clkout_p]
    
create_generated_clock -source [get_pins uclklvds/inst/mmcm_adv_inst/CLKOUT0] -multiply_by 1 \
    -master_clock [get_clocks clk_out1_clk_lvds] -add -name lvds_hclk_o [get_ports lvds_clkout_p]
set_output_delay 1 -clock [get_clocks lvds_hclk_o] [get_ports lvds_dout*]

set_output_delay 1 -clock [get_clocks lvds_hclk_o] [get_ports lvds_dout*]  -clock_fall -add_delay

set_output_delay -min 0.2 -clock [get_clocks lvds_hclk_o] [get_ports lvds_dout*] -add_delay

set_output_delay -min 0.2 -clock [get_clocks lvds_hclk_o] [get_ports lvds_dout*]  -clock_fall -add_delay
#-end of ssc and output delay
#------------------------------------------------------------------------------------------


set_input_delay -max 1 -clock [get_clocks lvds_clk] [all_inputs]
set_input_delay -min 0.5 -clock [get_clocks lvds_clk] [all_inputs] -add_delay

#+-----------------------------------------------------------------------------------------
#example of multicycle on output_delay

#- end of multicyle on output delay
#-------------------------------------------------------------------------------------------
