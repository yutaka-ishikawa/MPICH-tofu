# The following tests will exit with errors
#	errors/spawn/unpub, errors/spawn/lookup_name

.PHONY: all

all:
	@echo "make summary, make list, or make batch"
summary:
	unset MARKDOWN;	sh SUMMARY.sh
summary-md:
	export MARKDOWN=1; sh SUMMARY.sh
list:
	sh CREATE_LIST.sh
numazu-batch:
	sh CREATE_BATCH.sh dvsys-spack2 rscunit_ft02
fugaku-batch:
	sh CREATE_BATCH.sh dvsys-sin rscunit_ft01
