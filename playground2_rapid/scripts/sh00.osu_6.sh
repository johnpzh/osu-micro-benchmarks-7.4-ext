set -eu

SCRIPTS=(
  "scripts/run00.osu_allgather.no_cxl.2-nodes.sh"
  "scripts/run00.osu_allgather.with_cxl.2-nodes.sh"
  "scripts/run01.osu_allreduce.no_cxl.2-nodes.sh"
  "scripts/run01.osu_allreduce.with_cxl.2-nodes.sh"
  "scripts/run02.osu_get_bw.no_cxl.2-nodes.sh"
  "scripts/run02.osu_get_bw.with_cxl.2-nodes.sh"
  "scripts/run03.osu_get_latency.no_cxl.2-nodes.sh"
  "scripts/run03.osu_get_latency.with_cxl.2-nodes.sh"
  "scripts/run04.osu_mbw_mr.no_cxl.2-nodes.sh"
  "scripts/run04.osu_mbw_mr.with_cxl.2-nodes.sh"
  "scripts/run05.osu_multi_lat.no_cxl.2-nodes.sh"
  "scripts/run05.osu_multi_lat.with_cxl.2-nodes.sh"
)

for script in "${SCRIPTS[@]}"; do
  set -x
  bash "${script}"
  set +x
done