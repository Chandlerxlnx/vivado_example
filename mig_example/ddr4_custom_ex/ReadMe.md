# ReadMe DDR4 example

This example is modified from standard DDR4 example. shows example,
1. how to add custom operation in standard example.
2. how to add custom DDR4 config set in MIG IP.
3. how to force signal values during vivado xsim.
4. and check the efficiency of DDR4, manually in simulation.

# step to run example
1. source vivado settings
2. create project shell cmd:
  * make all ADD_MAP=<the address map to check>
3. run simulation in vivado,cmd:
  * source scripts/run_sim.tcl

#tips
  > to get help, run command 'make help'
