# transcript
vencrypt ./src/adder.v -toolblock SIEMENS-VERIF-SIM-RSA-2 -o ./encrypted_src/adder.vp
vencrypt ./src/adder_mult_key.v -o ./encrypted_src/adder_mult_key.vp

# check the code encrypted by questa,
#single key file,should suceed.
vlog ./encrypted_src/adder.vp

# multi-key file
vlog ./encrypted_src/adder_mult_key.vp

#
# check the code encrypted by vivado,
vlog ../vivado_prj/src/adder.vp

#multi-key file
vlog ../vivado_prj/src/adder_mult_key.vp

