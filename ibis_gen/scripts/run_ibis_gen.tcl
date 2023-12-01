create_project prj_ibis_gen ./proj_ibis_gen -part xa7s15csga225-1Q -force
set_property design_mode PinPlanning [current_fileset]
open_io_design -name ibis_io_1
#read_xdc -no_add ./pinplan/top_ibis_gen.xdc -quiet_diff_pairs
read_xdc ./pinplan/top_ibis_gen.xdc -quiet_diff_pairs
#read_xdc ./pinplan/top_ibis_gen.xdc

save_constraints -force
#set_property DIFF_TERM 1 [get_ports clk_in_p]
#set_property DIFF_TERM 0 [get_ports port_in1_p]
file mkdir ./output
write_csv ./output/top_ibis_io.csv -force
report_drc -name drc_1 -ruledecks {default}
write_ibis ./output/my_gen.ibs -truncate 40 -force 
