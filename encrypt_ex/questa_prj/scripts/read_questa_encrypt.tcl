# //  Questa Sim-64
# //  Version 2023.2 linux_x86_64 Apr 11 2023
# //
# //


#do ./scripts/questa_encrypt.tcl
# Errors: 0, Warnings: 0
vlib work
vlog -reportprogress 300 -work work ./encrypted_src/adder.vp
