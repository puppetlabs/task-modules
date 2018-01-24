Puppet::Functions.create_function(:'steps::add_result') do
  dispatch :update do
    param 'Hash', :context
    param 'String', :step_name
    param 'ResultSet', :result
    param 'Optional[Enum[first, name]]', :process
  end

  def update(context, step_name, resultset, process)
    # This extracts the result value
    result = case process || 'name'
             when 'first'
               resultset.first.value
             when 'name'
               resultset.inject({}) do |acc, result|
                 acc[result.target.name] = result.value
                 acc
               end
             end
    context['results'][step_name] = result
    context
  end
end
