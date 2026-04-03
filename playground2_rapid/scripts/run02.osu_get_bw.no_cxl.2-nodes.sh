set -eu

OUTPUT_DIR="output.osu_get_bw.no_cxl.2-nodes.$(date +%Y%m%dT%H%M%S)"
hostfile="/home/peng599/pppp/cxlmemsim_project/osu-micro-benchmarks-7.4-ext/hostfiles/hostfile"
mkdir -p "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

:> output.no_cxl.log

binary="/home/peng599/local/install/osu-micro-benchmarks/libexec/osu-micro-benchmarks/mpi/one-sided/osu_get_bw"

# The option --mca is necessary, otherwise there are errors
#[twosisters2][[25028,1],0][btl_ofi_module.c:78:mca_btl_ofi_add_procs] error receiving modex
#[twosisters2][[25028,1],0][btl_ofi_component.c:238:mca_btl_ofi_exit] BTL OFI will now abort.
#[1774760753.226045] [twosisters:259748:0]            sock.c:323  UCX  ERROR connect(fd=39, dest_addr=130.20.132.230:52253) failed: Connection refused
#[1774760753.226062] [twosisters:259748:0]          tcp_ep.c:1152 UCX  ERROR try to increase "net.core.somaxconn", "net.core.netdev_max_backlog", "net.ipv4.tcp_max_syn_backlog" to the maximum value on the remote node or increase UCX_TCP_MAX_CONN_RETRIES (=25)

set -x
{
mpirun -x BADSSERVER=twosisters2:50505 \
  --hostfile "${hostfile}" \
  --map-by ppr:1:node \
  -np 2 \
  --mca btl tcp,self \
  --mca btl_tcp_if_include ens259f0 \
  "${binary}"
#mpirun -x BADSSERVER=twosisters2:50505 \
#  --hostfile "${hostfile}" \
#  --map-by ppr:1:node \
#  -np 2 \
#  "${binary}"
} 2>&1 | tee -a output.no_cxl.log
set +x