open_project ./proj_u50_hbm/proj_u50_hbm.xpr
set_property target_simulator VCS [current_project]
set_property compxlib.vcs_compiled_library_dir [file normalize ./compile_simlib/vcs] [current_project]
#set_property -name {vcs.simulate.vcs.more_options} -value {+notimingchecks} -objects [get_filesets sim_1]
set_property -name {vcs.simulate.vcs.more_options} -value {+notimingcheck} -objects [get_filesets sim_1]
launch_simulation

