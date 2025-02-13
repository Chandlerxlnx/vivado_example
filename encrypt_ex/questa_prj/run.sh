# transcript
echo "====create single key file encrypted by questa"
vencrypt ./src/adder.v -toolblock SIEMENS-VERIF-SIM-RSA-2 -o ./encrypted_src/adder_v2.vp

echo "====create single default key file encrypted by questa"
vencrypt ./src/adder.v  -o ./encrypted_src/adder.vp

echo "====create embedded multi key file encrypted by questa"
vencrypt ./src/adder_wh_key.v  -o ./encrypted_src/adder_wh_key.vp

echo "====create single embedded questa key file encrypted by questa"
vencrypt ./src/adder_wh_questakey.v  -o ./encrypted_src/adder_wh_questakey.vp

echo "====create single embedded vvd key file encrypted by questa"
vencrypt ./src/adder_wh_vvdkey.v  -o ./encrypted_src/adder_wh_vvdkey.vp

echo "====create multi key file encrypted by questa"
vencrypt ./src/adder_mult_key.v -o ./encrypted_src/adder_mult_key.vp
#echo "====create multi key file 2 encrypted by questa"
#vencrypt ./src/adder_mult_key_2.v -o ./encrypted_src/adder_mult_key_2.vp

# check the code encrypted by questa,
#single key file,should suceed.
echo "====read single key v2 file encrypted by questa"
vlog ./encrypted_src/adder_v2.vp

echo "====read single key file encrypted by questa"
vlog ./encrypted_src/adder.vp

echo "====read single key file encrypted by questa"
vlog ./encrypted_src/adder.vp

echo "====read embedded single vvd key file encrypted by questa"
vlog ./encrypted_src/adder_wh_vvdkey.vp

echo "====read embedded single questa key file encrypted by questa"
vlog ./encrypted_src/adder_wh_questakey.vp

# multi-key file
echo "====read multi key file encrypted by questa"
vlog ./encrypted_src/adder_mult_key.vp

#echo "====read multi key file 2 encrypted by questa"
#vlog ./encrypted_src/adder_mult_key_2.vp

#
# check the code encrypted by vivado,
echo "====read single key file encrypted by vivado"
vlog ../vivado_prj/src/adder.vp

#multi-key file
echo "====read multi key file encrypted by Vivado"
vlog ../vivado_prj/src/adder_mult_key.vp

