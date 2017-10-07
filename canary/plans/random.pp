plan canary::random(
  String $task,
  String $nodes,
  Hash[String, Data] $params = {},
  Integer $canary_size = 1
) {
  [$canaries, $rest] = canary::random_split($nodes.split(','), $canary_size)

  $canr = run_task($task, $canaries, $params)
  if(!$canr.ok) {
    util::exit("Deploy to canaries failed: ${canr.error_nodes.names}")
  } else {
    util::print("Successfully deployed to canaries: ${canr.names}")
  }

  $restr = run_task($task, $rest, $params)
  if(!$restr.ok) {
    util::print("Failed when deploying rest of nodes: ${restr.error_nodes.names}")
    restr::error_nodes
  } else {
    util::print("Successfully deployed the rest of the nodes")
    undef
  }
}
