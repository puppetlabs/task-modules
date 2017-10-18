Puppet::Functions.create_function(:'steps::add_result') do
  dispatch :update do
    param 'Hash', :context
    param 'String', :step_name
    param 'Hash', :result
  end

  def update(context, step_name, result)
    context['results'][step_name] = result
    context
  end
end
