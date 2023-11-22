launch_simulation
#source example_top.tcl

if { [llen [get_wave_configs sim_tb_top_behav.wcfg]] == 0 } { 
	open_wave_config ${origin_dir}/sim_tb_top_behav.wcfg
}
run 10 us
add_force {/sim_tb_top/u_example_top/custom_mode_start} -radix hex {1 0ns}
run 100 us
add_force {/sim_tb_top/u_example_top/custom_mode_start} -radix hex {0 0ns} -cancel_after 100
add_force {/sim_tb_top/u_example_top/custom_mode_stop} -radix hex {1 0ns} -cancel_after 100
run 100 us
