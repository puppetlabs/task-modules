Puppet::Functions.create_function(:'steps::resolve_params') do
  dispatch :resolve_params do
    param 'Hash', :context
    param 'Optional[Hash]', :params
  end

  def resolve_params(context, params)
    params ||= {}
    params.each do |key, val|
      params[key] = call_function('steps::resolve', context, val)
    end
  end
end
