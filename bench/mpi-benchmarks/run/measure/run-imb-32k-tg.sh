#!/bin/bash
#------ pjsub option --------#
#PJM -N "MB-32K-TG" # jobname
#PJM -S
#PJM --spath "results/IMB-32K/%n.%j.stat"
#PJM -o "results/IMB-32K/%n.%j.out"
#PJM -e "results/IMB-32K/%n.%j.err"
#
#PJM -L "node=8192"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#PJM -L "elapse=2:00:00"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

. ./script-tg.sh

#MPIOPT is used in script-am.sh
#
MPIOPT="-of results/IMB-32K/%n.%j.out -oferr results/IMB-32K/%n.%j.err"
BENCH_PROG=../../IMB-MPI1

###
#	2021/02/15 00:27:51 (1671), JOBID: 5134466
###

export MPIR_CVAR_DEVICE_COLLECTIVES=none	#
export MPIR_CVAR_GATHERV_INTER_SSEND_MIN_PROCS=608256 #
export MPIR_CVAR_BARRIER_INTRA_ALGORITHM=dissemination

OKBENCH="Allreduce Reduce Alltoall Bcast Barrier Allgather Allgatherv Gather Scatter Scatterv Gatherv"
OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"
OKBENCH3="Gatherv Scatterv"
NP=16384
LENFILE=len/len-gather-8192.txt
MEM=7

run_bench "$OKBENCH1" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH2" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH3" $NP $MEM $LENFILE

exit
