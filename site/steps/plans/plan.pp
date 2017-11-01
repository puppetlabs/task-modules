plan steps::plan(
  String $step_file,
  Hash[String, Array[String]] $groups = {},
  Hash[String, Any] $params = {},
  ) {
  $step_data = util::loadyaml($step_file)

  $initial_context = {
    'groups' => $groups,
    'params' => $params,
    'vars' => $step_data['vars'],
    'results' => {}
  }

  $final_context = $step_data['steps'].reduce($initial_context) |$context, $step| {

    util::print("Running step: ${step['name]}")
    $params = $context.steps::resolve_params($step['params'])
    $target = $context.steps::resolve($step['target'])
    # Task is not resolvable so we can always list them
    $result = run_task($step['task'], $target, $params)
    $context.steps::add_result($step['name'], $result)
  }

  util::print("${final_context['results']")
}

