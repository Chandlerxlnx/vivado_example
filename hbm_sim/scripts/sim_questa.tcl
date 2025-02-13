open_project ./proj_u50_hbm/proj_u50_hbm.xpr
set_property target_simulator QUESTA [current_project]
set_property -name {questa.compile.vlog.more_options} -value {+notimingchecks} -objects [get_filesets sim_1]
set_property compxlib.questa_compiled_library_dir [file normalize {./compile_simlib/questa}] [current_project]
set_property -name {questa.simulate.vsim.more_options} -value {-onfinish final +notimingchecks} -objects [get_filesets sim_1]
set_property -name {questa.compile.vlog.more_options} -value {+notimingchecks} -objects [get_filesets sim_1]
launch_simulation

