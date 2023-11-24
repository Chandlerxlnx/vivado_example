create_project -force prj_ioconstr ./prj_ioconstr -part xa7a50tcsg325-1Q
add_files ./src -fileset sources_1
import_ip ./src/ip/clk_lvds/clk_lvds.xci
add_files -fileset constrs_1 ./constr/top_io.xdc
add_files -fileset constrs_1 ./constr/top_tmg.xdc
update_compile_order
