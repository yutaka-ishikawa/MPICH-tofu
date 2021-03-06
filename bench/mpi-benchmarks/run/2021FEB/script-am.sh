#export UTF_DEBUG=0x82200 # DLEVEL_ERR | DLEVEL_WARN | DLEVEL_LOG
#export UTF_DEBUG=0x200 # DLEVEL_ERR
#export UTF_ASEND_COUNT=1	# turn on 2021/01/02
export UTF_TRANSMODE=0		# Chained mode
export UTF_ARMA_COUNT=2		# must be defined in mpich.env 2021/02/01
export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1

#
# run_bench(<bench-list>, <procs>, <memsize>, [<len-file>])
#
run_bench() {
    #echo $1, $2, $3, $4
    if [ X$4 = X ]; then
	_LENOPT=""
    else
	_LENOPT="-msglen $4"
    fi

    if [ X$DRY_RUN = X1 ]; then
	echo "MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG = " $MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG
	echo "MPICH_TOFU_SHOW_PARAMS = " $MPICH_TOFU_SHOW_PARAMS
	echo "UTF_INFO = " $UTF_INFO
	echo "mpich_exec -n $2 $MPIOPT ../../IMB-MPI1 -npmin $2 -mem $3 $_LENOPT $1"
	unset MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG
	unset MPICH_TOFU_SHOW_PARAMS
	unset UTF_INFO
	return
    fi
    echo "mpich_exec -n $2 $MPIOPT ../../IMB-MPI1 -npmin $2 -mem $3 $_LENOPT $1"
    mpich_exec -n $2 $MPIOPT ../../IMB-MPI1 -npmin $2 -mem $3 $_LENOPT $1
    unset MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG
    unset MPICH_TOFU_SHOW_PARAMS
    unset UTF_INFO
}
