plan canary::random(
  String $task,
  String $nodes,
  Hash[String, Data] $params = {},
  Integer $canary_size = 1
) {
  [$canaries, $rest] = canary::random_split($nodes.split(','), $canary_size)

  $canr = run_task($task, $canaries, $params)
  if($canr.ok) {
    util::print("Successfully deployed to canaries: ${canr.names}")
    $restr = run_task($task, $rest, $params)
  } else {
    util::print("Deploy to canaries failed: ${canr.error_nodes.names}")
    $restr = canary::skip($rest)
  }

  canary::merge($canr, $restr)
}
