#-----------------------------------------------------------
# Vivado v2022.2 (64-bit)
# SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
# IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
# Start of session at: Tue Dec 19 23:49:56 2023
# Process ID: 4401
# Current directory: .
# Command line: vivado
# Log file: ./vivado.log
# Journal file: ./vivado.jou
# Running On: localhost.localdomain, OS: Linux, CPU Frequency: 2111.998 MHz, CPU Physical cores: 4, Host memory: 8200 MB
#-----------------------------------------------------------
start_gui
create_project -force proj_hssio ./proj_hssio -part xcvu3p-ffvc1517-1-i
create_ip -name high_speed_selectio_wiz -vendor xilinx.com -library ip -version 3.6 -module_name high_speed_selectio_wiz_0
set_property -dict [list \
  CONFIG.BUS_DIR {3} \
  CONFIG.BYTE2_PIN0_SIG_TYPE {DIFF} \
  CONFIG.BYTE2_SELECT_ALL_PINS {1} \
  CONFIG.BYTE3_PIN0_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN0_DATA_STROBE {Clk Fwd} \
  CONFIG.BYTE3_PIN0_SIG_TYPE {DIFF} \
  CONFIG.BYTE3_PIN10_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN11_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN12_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN2_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN3_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN4_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN5_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN6_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN7_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN8_BUS_DIR {TX} \
  CONFIG.BYTE3_PIN9_BUS_DIR {TX} \
  CONFIG.DIFFERENTIAL_IO_STD {DIFF_HSTL_I_18} \
  CONFIG.ENABLE_BITSLIP {1} \
  CONFIG.ENABLE_BYTE3_PIN0 {true} \
  CONFIG.ENABLE_BYTE3_PIN10 {true} \
  CONFIG.ENABLE_BYTE3_PIN11 {true} \
  CONFIG.ENABLE_BYTE3_PIN2 {true} \
  CONFIG.ENABLE_BYTE3_PIN3 {true} \
  CONFIG.ENABLE_BYTE3_PIN4 {true} \
  CONFIG.ENABLE_BYTE3_PIN5 {true} \
  CONFIG.ENABLE_BYTE3_PIN6 {true} \
  CONFIG.ENABLE_BYTE3_PIN7 {true} \
  CONFIG.ENABLE_BYTE3_PIN8 {true} \
  CONFIG.ENABLE_BYTE3_PIN9 {true} \
  CONFIG.ENABLE_RIU_INTERFACE {1} \
  CONFIG.PLL0_DATA_SPEED {1600.00} \
  CONFIG.SINGLE_IO_STD {HSTL_I_18} \
] [get_ips high_speed_selectio_wiz_0]
generate_target {instantiation_template} [get_files high_speed_selectio_wiz_0.xci]
update_compile_order -fileset sources_1
set_property generate_synth_checkpoint false [get_files  high_speed_selectio_wiz_0.xci]
generate_target all [get_files  high_speed_selectio_wiz_0.xci]
export_ip_user_files -of_objects [get_files high_speed_selectio_wiz_0.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files high_speed_selectio_wiz_0.xci] -directory ./proj_hssio/proj_hssio.ip_user_files/sim_scripts -ip_user_files_dir ./proj_hssio/proj_hssio.ip_user_files -ipstatic_source_dir ./proj_hssio/proj_hssio.ip_user_files/ipstatic -lib_map_path [list {modelsim=./proj_hssio/proj_hssio.cache/compile_simlib/modelsim} {questa=./proj_hssio/proj_hssio.cache/compile_simlib/questa} {xcelium=./proj_hssio/proj_hssio.cache/compile_simlib/xcelium} {vcs=./proj_hssio/proj_hssio.cache/compile_simlib/vcs} {riviera=./proj_hssio/proj_hssio.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
open_example_project -force -dir . [get_ips  high_speed_selectio_wiz_0]

launch_runs impl_1
