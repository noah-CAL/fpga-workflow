default:
	@echo "USAGE: make [write_bitstream, program, check_connectivity, clean, clean_all]"

################
#    Vivado    #
################
VIVADO_LOG  = vivado.log
VIVADO_JOU  = vivado.jou
VIVADO_OPTS = -mode batch -log $(VIVADO_LOG) -journal $(VIVADO_JOU)

###################
# Program Outputs #
###################
BITSTREAM   = output/design.bit
CHECKPOINTS = output/post_route.dcp \
							output/post_place.dcp

###################
# Program Sources #
###################
CNSTRS      = sources/basys3_main.xdc
SRCS        = sources/ztop.v

check_connectivity:
	vivado $(VIVADO_OPTS) -source scripts/check_connectivity.tcl

write_bitstream:
	vivado $(VIVADO_OPTS) -source scripts/write_bitstream.tcl

program:
	vivado $(VIVADO_OPTS) -source scripts/program.tcl

$(CONSTRS) $(SRCS) $(CHECKPOINTS) $(BITSTREAM): write_bitstream

clean:
	rm *.log *.jou

clean_all: clean
	rm -r output/

.PHONY: default check_connectivity write_bitstream program clean clean_all
