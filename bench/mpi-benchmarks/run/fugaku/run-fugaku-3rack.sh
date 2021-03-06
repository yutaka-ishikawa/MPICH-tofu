#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-3rack" # jobname
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
#PJM -L "elapse=00:30:00"
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
#export UTF_INJECT_COUNT=1
#export UTF_ASEND_COUNT=1	# turn on 2021/01/02
#export UTF_DEBUG=0x10200	# showing initializing step and DLELEL_ERR

#BENCH="Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"
#BENCH="Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"
##OKBENCH="Allreduce Reduce Allgather Allgatherv Gather Scatter Alltoall Bcast Barrier"

OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"

NP=4096
LENFILE=len-gather-4096.txt
MEM=7
echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $OKBENCH1"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $OKBENCH1 #
echo
echo
echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE $OKBENCH2"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE $OKBENCH2 #
exit

###########################################################################################
##OKBENCH="Alltoall" # OK, step3-4= 1sec, elapse=1:50
#
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 18432 $OKBENCH # Memory Exceeds
#

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 18432 -msglen len2.txt Alltoall # 1:15
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 3072 -msglen len2.txt Alltoall # 1:03
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 1536 -msglen len2.txt Alltoall # 54 sec
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 384 -msglen len2.txt Alltoall # 25 sec
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 32 -msglen len2.txt Alltoall
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 32 -msglen len2.txt Gatherv

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce -msglen len.txt

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 #GB
