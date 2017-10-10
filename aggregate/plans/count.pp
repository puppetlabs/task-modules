plan aggregate::count(
  String $nodes,
  String $task,
  Hash[String, Data] $params = {} ){

  $node_array = $nodes.split(',')
  $res = run_task($task, $node_array, $params)
  aggregate::count($res)
}
