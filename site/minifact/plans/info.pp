# A plan that simply prints what we can find out about a node with the
# minifact task
#
# The input $nodes must be a comma-separated list of the nodes on which we
# want to run minifact
plan minifact::info(String $nodes) {
  $all = $nodes.split(",")
  $minifacts = run_task('minifact', $all)
  $minifacts.map |$r| {
    "${r.target.name}: ${r[os][name]} ${r[os][release][full]} (${r[os][family]})"
  }
}
