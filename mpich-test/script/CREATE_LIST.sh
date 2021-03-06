#!/bin/bash

sh ./generate_run.sh -l attr
sh ./generate_run.sh -l coll
sh ./generate_run.sh -l comm
sh ./generate_run.sh -l datatype
sh ./generate_run.sh -l errhan
sh ./generate_run.sh -l group
sh ./generate_run.sh -l info
sh ./generate_run.sh -l init
sh ./generate_run.sh -l mpi_t
sh ./generate_run.sh -l pt2pt
sh ./generate_run.sh -l rma
sh ./generate_run.sh -l topo
sh ./generate_run.sh -l perf
##sh ./generate_run.sh -l io
sh ./generate_run.sh -l errors
sh ./generate_run.sh -l impls

exit
sh ./generate_run.sh -s attr:resource=dvsys-sin
sh ./generate_run.sh -s coll:resource=dvsys-sin
sh ./generate_run.sh -s comm:resource=dvsys-sin
sh ./generate_run.sh -s datatype:resource=dvsys-sin
sh ./generate_run.sh -s errhan:resource=dvsys-sin
sh ./generate_run.sh -s group:resource=dvsys-sin
sh ./generate_run.sh -s info:resource=dvsys-sin
sh ./generate_run.sh -s init:resource=dvsys-sin
sh ./generate_run.sh -s mpi_t:resource=dvsys-sin
sh ./generate_run.sh -s pt2pt:resource=dvsys-sin
sh ./generate_run.sh -s rma:resource=dvsys-sin
sh ./generate_run.sh -s topo:resource=dvsys-sin
sh ./generate_run.sh -s perf:resource=dvsys-sin
##sh ./generate_run.sh -s io:resource=dvsys-sin
sh ./generate_run.sh -s errors:resource=dvsys-sin
sh ./generate_run.sh -s impls:resource=dvsys-sin
