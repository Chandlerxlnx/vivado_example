
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2024.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   if { [string compare $scripts_vivado_version $current_vivado_version] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2042 -severity "ERROR" " This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Sourcing the script failed since it was created with a future version of Vivado."}

   } else {
     catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   }

   #return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project -force project_1 myproj -part xcu50-fsvh2104-2-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:hbm\
xilinx.com:ip:clk_wiz\
xilinx.com:ip:util_ds_buf\
xilinx.com:ip:axi_traffic_gen\
xilinx.com:ip:smartconnect\
xilinx.com:ip:proc_sys_reset\
xilinx.com:ip:jtag_axi\
xilinx.com:ip:axi_apb_bridge\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv:*]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set CLK_IN_D_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_IN_D_0 ]


  # Create ports
  set reset_0 [ create_bd_port -dir I -type rst reset_0 ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $reset_0

  # Create instance: hbm_0, and set properties
  set hbm_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hbm hbm_0 ]
  set_property -dict [list \
    CONFIG.USER_AXI_CLK_FREQ {250} \
    CONFIG.USER_EXAMPLE_TG {SYNTHESIZABLE} \
    CONFIG.USER_MC0_BURST_RW_REFRESH_HOLDOFF {true} \
    CONFIG.USER_MC0_REF_TEMP_COMP {false} \
    CONFIG.USER_MC_ENABLE_02 {FALSE} \
    CONFIG.USER_MC_ENABLE_03 {FALSE} \
    CONFIG.USER_SAXI_04 {false} \
    CONFIG.USER_SAXI_05 {false} \
    CONFIG.USER_SAXI_06 {false} \
    CONFIG.USER_SAXI_07 {false} \
    CONFIG.USER_SAXI_09 {false} \
    CONFIG.USER_SAXI_11 {false} \
    CONFIG.USER_SAXI_13 {false} \
    CONFIG.USER_SAXI_15 {false} \
  ] $hbm_0

set_property -dict [list \
  CONFIG.USER_AXI_CLK_FREQ {400} \
  CONFIG.USER_EXAMPLE_TG {NON_SYNTHESIZABLE} \
  CONFIG.USER_HBM_TCK_0 {800} \
] [get_bd_cells hbm_0]

  # Create instance: clk_wiz, and set properties
  set clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz ]
  set_property -dict [list \
    CONFIG.CLKOUT1_JITTER {111.970} \
    CONFIG.CLKOUT1_PHASE_ERROR {84.520} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {100.0} \
    CONFIG.CLKOUT2_JITTER {94.797} \
    CONFIG.CLKOUT2_PHASE_ERROR {84.520} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {250.000} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {12.500} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {12.500} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {5} \
    CONFIG.NUM_OUT_CLKS {2} \
  ] $clk_wiz


  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf util_ds_buf_0 ]

  # Create instance: axi_traffic_gen_1, and set properties
  set axi_traffic_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen axi_traffic_gen_1 ]
  set_property -dict [list \
    CONFIG.ATG_OPTIONS {High Level Traffic} \
    CONFIG.C_ATG_MODE_L2 {Advanced} \
    CONFIG.C_ATG_REPEAT_TYPE {One_Shot} \
    CONFIG.C_ATG_STATIC_HLTP_INCR {true} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH {33} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH_HLT {33} \
    CONFIG.C_M_AXI_ARUSER_WIDTH {0} \
    CONFIG.C_M_AXI_AWUSER_WIDTH {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {256} \
    CONFIG.C_M_AXI_THREAD_ID_WIDTH {6} \
    CONFIG.DATA_TRANS_GAP {Random} \
    CONFIG.MASTER_AXI_WIDTH {256} \
    CONFIG.MASTER_HIGH_ADDRESS_EXT {0x00000000} \
    CONFIG.TRAFFIC_PROFILE {Data} \
  ] $axi_traffic_gen_1


  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_0 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_0


  # Create instance: smartconnect_1, and set properties
  set smartconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_1 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_1


  # Create instance: axi_traffic_gen_0, and set properties
  set axi_traffic_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen axi_traffic_gen_0 ]
  set_property -dict [list \
    CONFIG.ATG_CLK_FREQ_MHZ {250} \
    CONFIG.ATG_OPTIONS {High Level Traffic} \
    CONFIG.C_ATG_MODE_L2 {Advanced} \
    CONFIG.C_ATG_REPEAT_TYPE {One_Shot} \
    CONFIG.C_ATG_STATIC_HLTP_INCR {true} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH {33} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH_HLT {33} \
    CONFIG.C_M_AXI_ARUSER_WIDTH {0} \
    CONFIG.C_M_AXI_AWUSER_WIDTH {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {256} \
    CONFIG.C_M_AXI_THREAD_ID_WIDTH {6} \
    CONFIG.DATA_SIZE_AVG {4} \
    CONFIG.DATA_TRANS_GAP {Random} \
    CONFIG.MASTER_AXI_WIDTH {256} \
    CONFIG.MASTER_HIGH_ADDRESS_EXT {0x00000000} \
    CONFIG.TRAFFIC_PROFILE {Data} \
  ] $axi_traffic_gen_0


  # Create instance: axi_traffic_gen_2, and set properties
  set axi_traffic_gen_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen axi_traffic_gen_2 ]
  set_property -dict [list \
    CONFIG.ATG_CLK_FREQ_MHZ {250} \
    CONFIG.ATG_OPTIONS {High Level Traffic} \
    CONFIG.C_ATG_MODE_L2 {Advanced} \
    CONFIG.C_ATG_REPEAT_TYPE {One_Shot} \
    CONFIG.C_ATG_STATIC_HLTP_INCR {true} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH {33} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH_HLT {33} \
    CONFIG.C_M_AXI_ARUSER_WIDTH {0} \
    CONFIG.C_M_AXI_AWUSER_WIDTH {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {256} \
    CONFIG.C_M_AXI_THREAD_ID_WIDTH {6} \
    CONFIG.DATA_SIZE_AVG {4} \
    CONFIG.DATA_TRANS_GAP {Random} \
    CONFIG.MASTER_AXI_WIDTH {256} \
    CONFIG.MASTER_HIGH_ADDRESS_EXT {0x00000000} \
    CONFIG.TRAFFIC_PROFILE {Data} \
  ] $axi_traffic_gen_2


  # Create instance: axi_traffic_gen_3, and set properties
  set axi_traffic_gen_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen axi_traffic_gen_3 ]
  set_property -dict [list \
    CONFIG.ATG_CLK_FREQ_MHZ {250} \
    CONFIG.ATG_OPTIONS {High Level Traffic} \
    CONFIG.C_ATG_MODE_L2 {Advanced} \
    CONFIG.C_ATG_REPEAT_TYPE {One_Shot} \
    CONFIG.C_ATG_STATIC_HLTP_INCR {true} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH {33} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH_HLT {33} \
    CONFIG.C_M_AXI_ARUSER_WIDTH {0} \
    CONFIG.C_M_AXI_AWUSER_WIDTH {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {256} \
    CONFIG.C_M_AXI_THREAD_ID_WIDTH {6} \
    CONFIG.DATA_SIZE_AVG {4} \
    CONFIG.DATA_TRANS_GAP {Random} \
    CONFIG.MASTER_AXI_WIDTH {256} \
    CONFIG.MASTER_HIGH_ADDRESS_EXT {0x00000000} \
    CONFIG.TRAFFIC_PROFILE {Data} \
  ] $axi_traffic_gen_3


  # Create instance: axi_traffic_gen_4, and set properties
  set axi_traffic_gen_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen axi_traffic_gen_4 ]
  set_property -dict [list \
    CONFIG.ATG_CLK_FREQ_MHZ {250} \
    CONFIG.ATG_OPTIONS {High Level Traffic} \
    CONFIG.C_ATG_MODE_L2 {Advanced} \
    CONFIG.C_ATG_REPEAT_TYPE {One_Shot} \
    CONFIG.C_ATG_STATIC_HLTP_INCR {true} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH {33} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH_HLT {33} \
    CONFIG.C_M_AXI_ARUSER_WIDTH {0} \
    CONFIG.C_M_AXI_AWUSER_WIDTH {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {256} \
    CONFIG.C_M_AXI_THREAD_ID_WIDTH {6} \
    CONFIG.DATA_SIZE_AVG {4} \
    CONFIG.DATA_TRANS_GAP {Random} \
    CONFIG.MASTER_AXI_WIDTH {256} \
    CONFIG.MASTER_HIGH_ADDRESS_EXT {0x00000000} \
    CONFIG.TRAFFIC_PROFILE {Data} \
  ] $axi_traffic_gen_4


  # Create instance: axi_traffic_gen_5, and set properties
  set axi_traffic_gen_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen axi_traffic_gen_5 ]
  set_property -dict [list \
    CONFIG.ATG_CLK_FREQ_MHZ {250} \
    CONFIG.ATG_OPTIONS {High Level Traffic} \
    CONFIG.C_ATG_MODE_L2 {Advanced} \
    CONFIG.C_ATG_REPEAT_TYPE {One_Shot} \
    CONFIG.C_ATG_STATIC_HLTP_INCR {true} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH {33} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH_HLT {33} \
    CONFIG.C_M_AXI_ARUSER_WIDTH {0} \
    CONFIG.C_M_AXI_AWUSER_WIDTH {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {256} \
    CONFIG.C_M_AXI_THREAD_ID_WIDTH {6} \
    CONFIG.DATA_SIZE_AVG {4} \
    CONFIG.DATA_TRANS_GAP {Random} \
    CONFIG.MASTER_AXI_WIDTH {256} \
    CONFIG.MASTER_HIGH_ADDRESS_EXT {0x00000000} \
    CONFIG.TRAFFIC_PROFILE {Data} \
  ] $axi_traffic_gen_5


  # Create instance: axi_traffic_gen_6, and set properties
  set axi_traffic_gen_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen axi_traffic_gen_6 ]
  set_property -dict [list \
    CONFIG.ATG_CLK_FREQ_MHZ {250} \
    CONFIG.ATG_OPTIONS {High Level Traffic} \
    CONFIG.C_ATG_MODE_L2 {Advanced} \
    CONFIG.C_ATG_REPEAT_TYPE {One_Shot} \
    CONFIG.C_ATG_STATIC_HLTP_INCR {true} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH {33} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH_HLT {33} \
    CONFIG.C_M_AXI_ARUSER_WIDTH {0} \
    CONFIG.C_M_AXI_AWUSER_WIDTH {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {256} \
    CONFIG.C_M_AXI_THREAD_ID_WIDTH {6} \
    CONFIG.DATA_SIZE_AVG {4} \
    CONFIG.DATA_TRANS_GAP {Random} \
    CONFIG.MASTER_AXI_WIDTH {256} \
    CONFIG.MASTER_HIGH_ADDRESS_EXT {0x00000000} \
    CONFIG.TRAFFIC_PROFILE {Data} \
  ] $axi_traffic_gen_6


  # Create instance: axi_traffic_gen_7, and set properties
  set axi_traffic_gen_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen axi_traffic_gen_7 ]
  set_property -dict [list \
    CONFIG.ATG_CLK_FREQ_MHZ {250} \
    CONFIG.ATG_OPTIONS {High Level Traffic} \
    CONFIG.C_ATG_MODE_L2 {Advanced} \
    CONFIG.C_ATG_REPEAT_TYPE {One_Shot} \
    CONFIG.C_ATG_STATIC_HLTP_INCR {true} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH {33} \
    CONFIG.C_EXTENDED_ADDRESS_WIDTH_HLT {33} \
    CONFIG.C_M_AXI_ARUSER_WIDTH {0} \
    CONFIG.C_M_AXI_AWUSER_WIDTH {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {256} \
    CONFIG.C_M_AXI_THREAD_ID_WIDTH {6} \
    CONFIG.DATA_SIZE_AVG {4} \
    CONFIG.DATA_TRANS_GAP {Random} \
    CONFIG.MASTER_AXI_WIDTH {256} \
    CONFIG.MASTER_HIGH_ADDRESS_EXT {0x00000000} \
    CONFIG.TRAFFIC_PROFILE {Data} \
  ] $axi_traffic_gen_7


  # Create instance: smartconnect_2, and set properties
  set smartconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_2 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_2


  # Create instance: smartconnect_3, and set properties
  set smartconnect_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_3 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_3


  # Create instance: smartconnect_4, and set properties
  set smartconnect_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_4 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_4


  # Create instance: smartconnect_5, and set properties
  set smartconnect_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_5 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_5


  # Create instance: smartconnect_6, and set properties
  set smartconnect_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_6 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_6


  # Create instance: smartconnect_7, and set properties
  set smartconnect_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_7 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_7


  # Create instance: rst_clk_wiz_250M, and set properties
  set rst_clk_wiz_250M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_clk_wiz_250M ]

  # Create instance: jtag_axi_0, and set properties
  set jtag_axi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi jtag_axi_0 ]
  set_property CONFIG.PROTOCOL {2} $jtag_axi_0


  # Create instance: axi_apb_bridge_0, and set properties
  set axi_apb_bridge_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_apb_bridge axi_apb_bridge_0 ]
  set_property CONFIG.C_APB_NUM_SLAVES {1} $axi_apb_bridge_0


  # Create instance: rst_clk_wiz_100M, and set properties
  set rst_clk_wiz_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_clk_wiz_100M ]

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports CLK_IN_D_0] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net axi_apb_bridge_0_APB_M [get_bd_intf_pins axi_apb_bridge_0/APB_M] [get_bd_intf_pins hbm_0/SAPB_0]
  connect_bd_intf_net -intf_net axi_traffic_gen_0_M_AXI [get_bd_intf_pins smartconnect_0/S00_AXI] [get_bd_intf_pins axi_traffic_gen_0/M_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_1_M_AXI [get_bd_intf_pins smartconnect_1/S00_AXI] [get_bd_intf_pins axi_traffic_gen_1/M_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_2_M_AXI [get_bd_intf_pins smartconnect_2/S00_AXI] [get_bd_intf_pins axi_traffic_gen_2/M_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_3_M_AXI [get_bd_intf_pins smartconnect_3/S00_AXI] [get_bd_intf_pins axi_traffic_gen_3/M_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_4_M_AXI [get_bd_intf_pins smartconnect_4/S00_AXI] [get_bd_intf_pins axi_traffic_gen_4/M_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_5_M_AXI [get_bd_intf_pins smartconnect_5/S00_AXI] [get_bd_intf_pins axi_traffic_gen_5/M_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_6_M_AXI [get_bd_intf_pins smartconnect_6/S00_AXI] [get_bd_intf_pins axi_traffic_gen_6/M_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_7_M_AXI [get_bd_intf_pins smartconnect_7/S00_AXI] [get_bd_intf_pins axi_traffic_gen_7/M_AXI]
  connect_bd_intf_net -intf_net jtag_axi_0_M_AXI [get_bd_intf_pins jtag_axi_0/M_AXI] [get_bd_intf_pins axi_apb_bridge_0/AXI4_LITE]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins smartconnect_0/M00_AXI] [get_bd_intf_pins hbm_0/SAXI_00]
  connect_bd_intf_net -intf_net smartconnect_1_M00_AXI [get_bd_intf_pins smartconnect_1/M00_AXI] [get_bd_intf_pins hbm_0/SAXI_01]
  connect_bd_intf_net -intf_net smartconnect_2_M00_AXI [get_bd_intf_pins hbm_0/SAXI_02] [get_bd_intf_pins smartconnect_2/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_3_M00_AXI [get_bd_intf_pins hbm_0/SAXI_03] [get_bd_intf_pins smartconnect_3/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_4_M00_AXI [get_bd_intf_pins hbm_0/SAXI_08] [get_bd_intf_pins smartconnect_4/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_5_M00_AXI [get_bd_intf_pins hbm_0/SAXI_10] [get_bd_intf_pins smartconnect_5/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_6_M00_AXI [get_bd_intf_pins hbm_0/SAXI_12] [get_bd_intf_pins smartconnect_6/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_7_M00_AXI [get_bd_intf_pins hbm_0/SAXI_14] [get_bd_intf_pins smartconnect_7/M00_AXI]

  # Create port connections
  connect_bd_net -net Net1  [get_bd_pins rst_clk_wiz_100M/peripheral_aresetn] \
  [get_bd_pins axi_apb_bridge_0/s_axi_aresetn] \
  [get_bd_pins jtag_axi_0/aresetn] \
  [get_bd_pins hbm_0/APB_0_PRESET_N]
  connect_bd_net -net clk_wiz_clk_out1  [get_bd_pins clk_wiz/clk_out2] \
  [get_bd_pins axi_traffic_gen_0/s_axi_aclk] \
  [get_bd_pins smartconnect_0/aclk] \
  [get_bd_pins rst_clk_wiz_250M/slowest_sync_clk] \
  [get_bd_pins axi_traffic_gen_1/s_axi_aclk] \
  [get_bd_pins smartconnect_1/aclk] \
  [get_bd_pins axi_traffic_gen_2/s_axi_aclk] \
  [get_bd_pins smartconnect_2/aclk] \
  [get_bd_pins axi_traffic_gen_3/s_axi_aclk] \
  [get_bd_pins smartconnect_3/aclk] \
  [get_bd_pins axi_traffic_gen_4/s_axi_aclk] \
  [get_bd_pins smartconnect_4/aclk] \
  [get_bd_pins axi_traffic_gen_5/s_axi_aclk] \
  [get_bd_pins smartconnect_5/aclk] \
  [get_bd_pins axi_traffic_gen_6/s_axi_aclk] \
  [get_bd_pins smartconnect_6/aclk] \
  [get_bd_pins axi_traffic_gen_7/s_axi_aclk] \
  [get_bd_pins smartconnect_7/aclk] \
  [get_bd_pins hbm_0/AXI_00_ACLK] \
  [get_bd_pins hbm_0/AXI_01_ACLK] \
  [get_bd_pins hbm_0/AXI_02_ACLK] \
  [get_bd_pins hbm_0/AXI_03_ACLK] \
  [get_bd_pins hbm_0/AXI_08_ACLK] \
  [get_bd_pins hbm_0/AXI_10_ACLK] \
  [get_bd_pins hbm_0/AXI_12_ACLK] \
  [get_bd_pins hbm_0/AXI_14_ACLK]
  connect_bd_net -net clk_wiz_clk_out2  [get_bd_pins clk_wiz/clk_out1] \
  [get_bd_pins hbm_0/HBM_REF_CLK_0] \
  [get_bd_pins hbm_0/APB_0_PCLK] \
  [get_bd_pins axi_apb_bridge_0/s_axi_aclk] \
  [get_bd_pins jtag_axi_0/aclk] \
  [get_bd_pins rst_clk_wiz_100M/slowest_sync_clk]
  connect_bd_net -net clk_wiz_locked  [get_bd_pins clk_wiz/locked] \
  [get_bd_pins rst_clk_wiz_250M/dcm_locked] \
  [get_bd_pins rst_clk_wiz_100M/dcm_locked]
  connect_bd_net -net hbm_0_apb_complete_0  [get_bd_pins hbm_0/apb_complete_0] \
  [get_bd_pins rst_clk_wiz_250M/aux_reset_in]
  connect_bd_net -net reset_0_1  [get_bd_ports reset_0] \
  [get_bd_pins clk_wiz/reset] \
  [get_bd_pins rst_clk_wiz_250M/ext_reset_in] \
  [get_bd_pins rst_clk_wiz_100M/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_100M_peripheral_aresetn  [get_bd_pins rst_clk_wiz_250M/peripheral_aresetn] \
  [get_bd_pins axi_traffic_gen_0/s_axi_aresetn] \
  [get_bd_pins axi_traffic_gen_1/s_axi_aresetn] \
  [get_bd_pins axi_traffic_gen_2/s_axi_aresetn] \
  [get_bd_pins axi_traffic_gen_3/s_axi_aresetn] \
  [get_bd_pins axi_traffic_gen_4/s_axi_aresetn] \
  [get_bd_pins axi_traffic_gen_5/s_axi_aresetn] \
  [get_bd_pins axi_traffic_gen_6/s_axi_aresetn] \
  [get_bd_pins axi_traffic_gen_7/s_axi_aresetn] \
  [get_bd_pins hbm_0/AXI_00_ARESET_N] \
  [get_bd_pins hbm_0/AXI_01_ARESET_N] \
  [get_bd_pins hbm_0/AXI_02_ARESET_N] \
  [get_bd_pins hbm_0/AXI_03_ARESET_N] \
  [get_bd_pins hbm_0/AXI_08_ARESET_N] \
  [get_bd_pins hbm_0/AXI_10_ARESET_N] \
  [get_bd_pins hbm_0/AXI_12_ARESET_N] \
  [get_bd_pins hbm_0/AXI_14_ARESET_N]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT  [get_bd_pins util_ds_buf_0/IBUF_OUT] \
  [get_bd_pins clk_wiz/clk_in1]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM03] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_1/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM15] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM03] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_0/Data] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM15] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM03] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_2/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM15] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM03] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_3/Data] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM15] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM03] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_4/Data] [get_bd_addr_segs hbm_0/SAXI_08/HBM_MEM15] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM03] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_5/Data] [get_bd_addr_segs hbm_0/SAXI_10/HBM_MEM15] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM03] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_6/Data] [get_bd_addr_segs hbm_0/SAXI_12/HBM_MEM15] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM03] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_traffic_gen_7/Data] [get_bd_addr_segs hbm_0/SAXI_14/HBM_MEM15] -force
  assign_bd_address -offset 0x00000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hbm_0/SAPB_0/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


