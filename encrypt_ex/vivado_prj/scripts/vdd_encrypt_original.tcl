#-----------------------------------------------------------
# Vivado v2023.2 (64-bit)
#-----------------------------------------------------------
set vivado_verilog_key [glob $env(XILINX_VIVADO)/data/pubkey/*active.v]
encrypt -key $vivado_verilog_key -ext .vp -lang verilog ./src/adder.v
encrypt  -ext .vp -lang verilog ./src/adder_mult_key.v
exit
# check the encrypted file
#xvlog ./src/adder.vp
#xvlog ./src/adder_mult_key.vp

#check the encypted files by questa

#xvlog ../questa_prj/encrypted_src/adder.vp
#xvlog ../questa_prj/encrypted_src/adder_mult_key.vp
