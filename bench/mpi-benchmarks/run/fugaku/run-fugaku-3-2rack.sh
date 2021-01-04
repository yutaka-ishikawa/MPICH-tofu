#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-3-2rack" # jobname
#PJM -S
#PJM --spath "results/IMB-3rack/%n.%j.stat"
#PJM -o "results/IMB-3rack/%n.%j.out"
#PJM -e "results/IMB-3rack/%n.%j.err"
#
#	PJM -L "node=32"
#	PJM -L "node=64"
#	PJM -L "node=128"
#	PJM -L "node=384"
#PJM -L "node=1152"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=16"
#	PJM -L "elapse=00:0:40"
#PJM -L "elapse=00:55:00"
#	PJM -L "elapse=00:10:00"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-3rack/%n.%j.out -oferr results/IMB-3rack/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
##export UTF_DEBUG=0x4200 # DLEVEL_ERR|DLEVEL_STATISTICS  
export UTF_DEBUG=0x200 # DLEVEL_ERR
export UTF_INJECT_COUNT=1
export UTF_ASEND_COUNT=1	# turn on 20210102
##export UTF_DEBUG=0x10200	# showing initializing step and DLELEL_ERR

#BENCH="Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"
#BENCH="Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"

OKBENCH="Allreduce Reduce Allgather Allgatherv Gather Scatter Alltoall Bcast Barrier" #

NP=4608
mpich_exec $MPIOPT ../../IMB-MPI1 -mem 1 -npmin $NP -msglen len5.txt $OKBENCH #
exit
