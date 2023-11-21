create_clock -p 5 [get_ports clk] 

#+----------------------------------------------------------------------------------------
# example of source sync clock and conreponding output delay
create_generated_clock -source [get_ports clk] -divide_by 2 \
    -master_clock [get_clocks clk] -add -name spi_clk [get_ports pad_spi_clk_o]

set_output_delay 2 -clock [get_clocks spi_clk] [get_ports pad_spi_dout]
set_output_delay 2 -clock [get_clocks spi_clk] [get_ports pad_spi_sync_o]

set_output_delay 2 -clock [get_clocks spi_clk] [get_ports pad_spi_dout]  -clock_fall -add_delay
set_output_delay 2 -clock [get_clocks spi_clk] [get_ports pad_spi_sync_o] -clock_fall -add_delay

set_output_delay -min 1 -clock [get_clocks spi_clk] [get_ports pad_spi_dout] -add_delay
set_output_delay -min 1 -clock [get_clocks spi_clk] [get_ports pad_spi_sync_o] -add_delay

set_output_delay -min 1 -clock [get_clocks spi_clk] [get_ports pad_spi_dout]  -clock_fall -add_delay
set_output_delay -min 1 -clock [get_clocks spi_clk] [get_ports pad_spi_sync_o] -clock_fall -add_delay
#-end of ssc and output delay
#------------------------------------------------------------------------------------------


set_input_delay -max 3 -clock [get_clocks clk] [all_inputs]
set_input_delay -min 1 -clock [get_clocks clk] [all_inputs]

#+-----------------------------------------------------------------------------------------
#example of multicycle on output_delay
set_output_delay -clock [get_clocks clk] 2.5 [get_ports rx_dout*]
set_multicycle_path 3 -to [get_ports rx_dout*]
set_multicycle_path -hold 2 -to [get_ports rx_dout*]

#- end of multicyle on output delay
#-------------------------------------------------------------------------------------------
