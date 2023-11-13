create_clock -p 5 [get_ports clk] 

create_generated_clock -source [get_ports clk] -divide_by 2 \
    -master_clock [get_clocks clk] -add -name spi_clk [get_ports pad_spi_clk_o]

set_output_delay 2 -clock [get_clocks spi_clk] [get_ports pad_spi_dout]
set_output_delay 2 -clock [get_clocks spi_clk] [get_ports pad_spi_sync_o]

set_output_delay 2 -clock [get_clocks spi_clk] [get_ports pad_spi_dout]  -clock_fall -add_delay
set_output_delay 2 -clock [get_clocks spi_clk] [get_ports pad_spi_sync_o] -clock_fall -add_delay

set_input_delay 3 -clock [get_clocks clk] [all_inputs]