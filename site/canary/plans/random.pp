plan canary::random(
  String $task,
  String $nodes,
  Hash[String, Data] $params = {},
  Integer $canary_size = 1
) {
  [$canaries, $rest] = canary::random_split($nodes.split(','), $canary_size)

  $catch_params = $params.util::merge({ '_catch_errors' => true})
  $canr = run_task($task, $canaries, $catch_params)
  if($canr.ok) {
    $restr = run_task($task, $rest, $catch_params)
  } else {
    $restr = canary::skip($rest)
  }

  canary::merge($canr, $restr)
}
