source ./scripts/create_proj.tcl
launch_runs impl_1 -jobs 4
wait_on_runs impl_1
open_run impl_1

report_timing_summary -delay_type min_max -report_unconstrained \
	-check_timing_verbose -max_paths 10 -input_pins \
	-routable_nets -file top_tms.rpt
report_timing -nworst 10 -max_paths 2 \
	-to [all_outputs] \
	-file top_output_tmg.rpt

# report timing in tab
report_timing_summary -delay_type min_max -report_unconstrained \
	-check_timing_verbose -max_paths 10 -input_pins \
	-routable_nets \
	-name top_tms
report_timing -nworst 40 -max_paths 1 \
	-to [all_outputs] \
	-name all_outdly

