
export SYNOPSYS_SIM= $(dirname $(which dve))/..
export ARCH=amd64
all: create_prj sim_questa

create_prj:
	vivado -mode tcl -source scripts/crt_proj_u50_hbm.tcl
clean:
	rm -rf vivado*.log vivado*.jou compile_simlib.log*

cleanall: clean
	rm -rf proj_u50_hbm

setup2023.2:
	ts 2023.2 -questa 2023.2 -modelsim 2023.2 -vcs U-2023.03-1 -ncsim 15.20.030 -xcelium 23.09.001

sim_questa:
	vivado -mode tcl -source scripts/sim_questa.tcl

sim_vcs:
	vivado -mode tcl -source scripts/sim_vcs.tcl

sim:
	vivado -mode tcl -source scripts/run_sim.tcl
#ts 2024.2 -questa 2023.3 -modelsim 2023.3 -vcs U-2023.03-1 -ncsim 15.20.030 -xcelium 23.09.001
lib:
	vivado -mode tcl -source scripts/compile_lib.tcl
