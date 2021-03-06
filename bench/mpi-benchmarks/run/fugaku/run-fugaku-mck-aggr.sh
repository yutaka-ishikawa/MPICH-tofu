#!/bin/bash
#------ pjsub option --------#
#PJM -N "IMB-MCK-AGRTAGGED" # jobname
#PJM -S
#PJM --spath "results/IMB-mck-aggr/%n.%j.stat"
#PJM -o "results/IMB-mck-aggr/%n.%j.out"
#PJM -e "results/IMB-mck-aggr/%n.%j.err"
#
#PJM -L "node=16"
#	PJM -L "node=64"
#	PJM -L "node=128"
#	PJM -L "node=384"
#	PJM -L "node=128"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#	PJM -L "elapse=00:3:40"
#	PJM -L "elapse=00:50:40"
#PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck6-4,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck6-3,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-mck-aggr/%n.%j.out -oferr results/IMB-mck-aggr/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
##export UTF_DEBUG=0x4200 # DLEVEL_ERR|DLEVEL_STATISTICS  
export UTF_DEBUG=0x200 # DLEVEL_ERR
#export UTF_ASEND_COUNT=1	# turn on 2021/01/02
#export UTF_TRANSMODE=0		# Chained mode
export UTF_TRANSMODE=1		# Aggressive mode
export UTF_ARMA_COUNT=2		# must be defined in mpich.env 2021/02/01
export MPIR_CVAR_CH4_OFI_ENABLE_TAGGED=1

NP=64
MEM=7

echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM
exit
