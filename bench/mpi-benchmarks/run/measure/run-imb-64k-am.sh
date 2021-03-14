#!/bin/bash
#------ pjsub option --------#
#PJM -N "M-IMB-64K-AM" # jobname
#PJM -S
#PJM --spath "results/IMB-64K/%n.%j.stat"
#PJM -o "results/IMB-64K/%n.%j.out"
#PJM -e "results/IMB-64K/%n.%j.err"
#
#PJM -L "node=16384"
#		42.666 Rack
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#PJM -L "elapse=00:50:40"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

. ./script-am.sh

#MPIOPT is used in script-am.sh
#
MPIOPT="-of results/IMB-64K/%n.%j.out -oferr results/IMB-64K/%n.%j.err"
BENCH_PROG=../../IMB-MPI1

OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"
OKBENCH3="Gatherv Scatterv"
NP=65536
LENFILE=len/len-gather-65536.txt
MEM=7

run_bench "$OKBENCH1" $NP $MEM
echo
run_bench "$OKBENCH2" $NP $MEM
echo
echo "*****************************"
echo "*\tSkipping $OKBENCH3"
echo "*****************************"
echo
#run_bench "$OKBENCH3" $NP $MEM $LENFILE

exit
