#!/bin/bash
#------ pjsub option --------#
#PJM -N "IMB-MCK-TAGGED" # jobname
#PJM -S
#PJM --spath "results/IMB-mck/%n.%j.stat"
#PJM -o "results/IMB-mck/%n.%j.out"
#PJM -e "results/IMB-mck/%n.%j.err"
#
#	PJM -L "node=4"
#	PJM -L "node=8"
#	PJM -L "node=16"
#	PJM -L "node=32"
#	PJM -L "node=64"
#	PJM -L "node=128"
#	PJM -L "node=256"
#	PJM -L "node=512"
#PJM -L "node=1024"
#	PJM -L "node=2048"
#	PJM -L "node=384"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#	PJM -L "elapse=00:50:40"
#	PJM -L "elapse=00:18:40"
#	PJM -L "elapse=00:4:30"
#	PJM -L "elapse=00:6:30"
#	PJM -L "elapse=00:04:30"
#	PJM -L "elapse=00:03:30"
#PJM -L "elapse=00:02:00"
#	PJM -L "elapse=00:01:10"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck6-4,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck6-3,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-mck/%n.%j.out -oferr results/IMB-mck/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x101		# STAT, MSG
export UTF_STATFD=2		# stderr for STATISTICS
export UTF_STATRANK=0		# rank 0 for STATISTICS
export UTF_ARMA_COUNT=2		# must be defined in mpich.env 2021/02/01
export UTF_TRANSMODE=0		# Chained mode
#	export UTF_TRANSMODE=1		# Aggressive mode
#UTF_ASEND_COUNT=4

#NP=8	# 00:11
#NP=16	# 00:22
#NP=32	# OK 00:33
#NP=64	# ERR OK 00:50
#NP=128	# ERR OK 01:28
#NP=256	# ERR OK 03:22
#NP=512	# OK 03:49
#NP=1024 # OK 04:19
#NP=2048 # OK in AM 03:41
NP=4096 #
#NP=8192 # OK 04:19
MEM=7
#BENCH="Gatherv"
BENCH="Allreduce"
PROG=../../IMB-MPI1-20210206

#export UTF_DEBUG=0x82200 # DLEVEL_ERR | DLEVEL_WARN | DLEVEL_LOG
#export UTF_DEBUG=0x102200 # DLEVEL_ERR | DLEVEL_WARN | DLEVEL_LOG2

#export UTF_DEBUG=0x100000 # DLEVEL_LOG2
#export UTF_DEBUG=0x000100 # DLEVEL_ADHOC
export UTF_DBGTIMER_INTERVAL=110
#export UTF_DBGTIMER_INTERVAL=140
#export UTF_DBGTIMER_INTERVAL=250
export UTF_DBGTIMER_ACTION=1

export MPIR_CVAR_CH4_OFI_ENABLE_TAGGED=1
export MPIR_CVAR_DEVICE_COLLECTIVES=none	# only works for Gatherv ?
export MPIR_CVAR_GATHERV_INTRA_ALGORITHM=linear # This is already included in mpich.env
export MPIR_CVAR_GATHERV_INTER_SSEND_MIN_PROCS=608256 #
export MPIR_CVAR_BARRIER_INTRA_ALGORITHM=dissemination

echo "MPIR_CVAR_BARRIER_INTRA_ALGORITHM = " $MPIR_CVAR_BARRIER_INTRA_ALGORITHM

echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $BENCH"
mpich_exec -n $NP $MPIOPT $PROG -npmin $NP -mem $MEM $BENCH

#echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -$BENCH"
#mpich_exec -n $NP $MPIOPT $PROG -npmin $NP -mem $MEM $BENCH
exit
