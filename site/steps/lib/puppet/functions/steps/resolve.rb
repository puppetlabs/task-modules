Puppet::Functions.create_function(:'steps::resolve') do
  dispatch :resolve do
    param 'Hash', :context
    param 'String', :val
  end

  def resolve(context, val)
    if val[0] == '$'
      parts = val[1..-1].split('.')
      puts "parts are #{parts} context is #{context}"
      result = context.dig(*parts)
      if result == nil
        raise Puppet::ParseError.new("Can't resolve '#{val}' from context")
      end
      val = result
    end
    val
  end
end
