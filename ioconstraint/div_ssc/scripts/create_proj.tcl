create_project -force prj_ioconstr ./prj_iocontr -part xa7a50tcsg325-1Q
add_files -norecurse ./src/spi_io.v
add_files -fileset constrs_1 ./constr/top_io.xdc
add_files -fileset constrs_1 ./constr/top_tmg.xdc
