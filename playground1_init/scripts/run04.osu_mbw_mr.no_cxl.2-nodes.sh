set -eu

OUTPUT_DIR="output.osu_mbw_mr.no_cxl.2-nodes.$(date +%Y%m%dT%H%M%S)"
hostfile="/home/peng599/pppp/cxlmemsim_project/osu-micro-benchmarks-7.4-ext/hostfiles/hostfile"
mkdir -p "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

:> output.no_cxl.log

binary="/home/peng599/local/install/osu-micro-benchmarks/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_mbw_mr"

set -x
{
#/usr/bin/time -f "%e" \
mpirun -x BADSSERVER=twosisters2:50505 \
  --hostfile "${hostfile}" \
  --map-by ppr:1:node \
  -np 2 \
  "${binary}"
} 2>&1 | tee -a output.no_cxl.log
set +x