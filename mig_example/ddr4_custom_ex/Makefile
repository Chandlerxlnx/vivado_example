SHELL = /bin/bash
#ADD_MAP: memory address map
#      RBC: ROW_BANK_COLUMN
#      RCB: ROW_COLUMN_BANK
#      BRC: BANK_ROW_COLUMN
#      RBCI: ROW_BANK_COLUMN_INTLV
ADD_MAP:=RBC

ifeq ("RBC","$(ADD_MAP)")
      address_map=ROW_BANK_COLUMN;
else ifeq ("RCB", "$(ADD_MAP)")
      address_map=ROW_COLUMN_BANK;
else ifeq ("BRC", "$(ADD_MAP)")
      address_map=BANK_ROW_COLUMN;
else ifeq ("$(ADD_MAP)","RCBI")
      address_map=ROW_COLUMN_BANK_INTLV;
else
      $(warning ADD_MAP is not found)
endif

all:
	vivado -source scripts/crt_ddr4_0_ex.tcl -tclargs --project_name ddr4_0_customize_ex_$(ADD_MAP) --add_map $(address_map)
test:
	@echo "ADD_MAP : $(ADD_MAP)";
	@echo "address_map: ${address_map}";

clean:
	rm vivado*
cleanall: clean
	rm -rf ddr4_0_customize_ex*

help:
	@echo "This example to runing ddr4 example with different address map"
	@echo "please add args ADD_MAP=<RBC|RCB|BRC|RBCI> to specify the address map"
