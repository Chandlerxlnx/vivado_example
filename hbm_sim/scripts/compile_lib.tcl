#compile_simlib -simulator questa -simulator_exec_path {/tools/gensys/questa/2023.2/linux_x86_64} -family virtexuplus -language all -library all -dir {./compile_simlib/questa} -force
compile_simlib -simulator questa  -family virtexuplus -language all -library all -dir {./compile_simlib/questa} -force
#hbm simulation is not supported by modelsim
#compile_simlib -simulator modelsim  -family virtexuplus -language all -library all -dir {./compile_simlib/modelsim} -force
compile_simlib -simulator vcs  -family virtexuplus -language all -library all -dir {./compile_simlib/vcs} -force
#
#hbm is not supported by xcelium
#compile_simlib -simulator xcelium  -family virtexuplus -language all -library all -dir {./compile_simlib/xcelium} -force
