set -eu

OUTPUT_DIR="output.osu_allgather.with_cxl.2-nodes.$(date +%Y%m%dT%H%M%S)"
hostfile="/home/peng599/pppp/cxlmemsim_project/osu-micro-benchmarks-7.4-ext/hostfiles/hostfile"
cxl_lib_file="/home/peng599/pppp/cxlmemsim_project/Splash/build/libmpi_cxl_numa_shim.so"

mkdir -p "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

:> output.with_cxl.log

binary="/home/peng599/local/install/osu-micro-benchmarks/libexec/osu-micro-benchmarks/mpi/collective/osu_allgather"

set -x
{
#export CXL_DAX_PATH="/dev/dax1.0" #32GB CXL device on target_node3
#export CXL_MEASURE_LATENCY=1
#LD_PRELOAD="${cxl_lib_file}" \
mpirun -x BADSSERVER=twosisters2:50505 \
  --hostfile "${hostfile}" \
  --map-by ppr:1:node \
  -np 2 \
  "${binary}" -d cxl
} 2>&1 | tee -a output.with_cxl.log
set +x

#  -x CXL_DAX_PATH="/dev/dax1.0" \
#  -x CXL_MEASURE_LATENCY=1 \
#  -x LD_PRELOAD="${cxl_lib_file}" \