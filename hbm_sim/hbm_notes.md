#debug on server GUUP xcoapps63
## system information:
 server: guup xcoapps63
 setting: ts 2023.2 -questa 2023.2  -vcs U-2023.03-1 
 OS:RH 7.9/ 3.10.0-1160.el7.x86_64

## Error

### 1. questa sim error
```
** Error: ../../../../proj_u50_hbm.srcs/sources_1/new/hbm_top.v(39): (vopt-2137) Instantiating 'DUT' has potential unbounded recursion.
        Region: hbm_top.DUT.design_1_i.hbm_0.inst.ONE_STACK.u_hbm_top.DUT
Optimization failed


```
#### debug
1. using local simlib (compile_simlib), the error is same.

### 2. VCS sim error
VCS failed on same setting above. (xcoapps63/RH7.9/vivado 2023.2, vcs U-2023.03-1)
error during elaborating (elaborate.log
```
Error-[V2KTDMI] Too deep module instantiation
/proj/gsd/vivado/Vivado/2023.2/data/ip/xilinx/axi_traffic_gen_v3_0/hdl/axi_traffic_gen_v3_0_rfs.v, 1290
"AXI_TRAFFIC_GEN_V3_0_15.axi_traffic_gen_v3_0_15_cmdram"
  Module 'axi_traffic_gen_v3_0_15_cmdram' may be involved in infinite
```

# Debug on xsjapps62

## setup and config
*setup : 
ts 2024.2 -questa 2024.1 -vcs U-2023.03-SP2

* server config:
```
server name: xsjapps62
OS: Redhat 9.2
kernel: 
Linux xsjapps62 5.14.0-284.11.1.el9_2.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Apr 12 10:45:03 EDT 2023 x86_64 x86_64 x86_64 GNU/Linux

```
## Sim with questa

1. run sim with simlib compiled locally(./compiled_simlib/question),error is smae as vivado 2023.2 on xcoapps63



# compile_simlib errors

## VCS 
ts 2023.2 -questa 2023.2  -vcs U-2023.03-1 
### error:
* in compile_simlib.log
```

ERROR: [Vivado 12-23673] compile_simlib failed to compile for vcs_mx with error in 24 libraries (cxl_error.log, Number of error(s) = 111)
```
* in cxl_error.log
```==============================================================================
Library 'xtlm' compilation error(s)
==============================================================================

Error-[SC-SYSCAN-OCOMP] Unsupported compiler
  The compiler 
  '/tools/gensys/xlm/23.09.001/tools/cdsgcc/gcc/9.3/bin/../bin/g++ 9.3.0' is 
  not supported for SystemC version 2.3.3.
  Tested compilers for this version are: g++-7.3.0 with binutils 2.30 and 
  g++-9.2.0 with binutils 2.33.1. Adjust PATH and LD_LIBRARY_PATH to use the 
  right compiler, or use the options -cpp and -cc to specify the compiler.


Note-[SC-SYSCAN-NO-VG-GNU] VG GNU package not set
  The VG_GNU_PACKAGE variable is not set.
  It is recommended to use the VG GNU package and use the compiler from there.


Error-[SC-SYSCAN-OCOMP] Unsupported compiler
  The compiler 
  '/tools/gensys/xlm/23.09.001/tools/cdsgcc/gcc/9.3/bin/../bin/g++ 9.3.0' is 
  not supported for SystemC version 2.3.3.
  Tested compilers for this version are: g++-7.3.0 with binutils 2.30 and 
  g++-9.2.0 with binutils 2.33.1. Adjust PATH and LD_LIBRARY_PATH to use the 
  right compiler, or use the options -cpp and -cc to specify the compiler.




```
### solution
   this error is related with xtlm, try to ignore ahead.

