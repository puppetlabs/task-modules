# A plan that simply prints what we can find out about a node with the
# minifact task
#
# The input $nodes must be a comma-separated list of the nodes on which we
# want to run minifact
plan minifact::info(String $nodes) {
  $all = $nodes.split(",")
  $minifacts = run_task('minifact', $all)
  $minifacts.each |$nd, $out| {
    util::print("${nd}: ${out[os][name]} ${out[os][release][full]} (${out[os][family]})")
  }
  # Make it so that bolt does not print a result when we are done
  undef
}
