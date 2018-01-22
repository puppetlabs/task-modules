Puppet::Functions.create_function(:'steps::resolve') do
  dispatch :resolve do
    param 'Hash', :context
    param 'String', :val
  end

  # Dig that works for objects with []
  def better_dig(obj, keys)
    if keys.empty?
      obj
    else
      better_dig(obj[keys.first], keys[1..-1])
    end
  end

  def resolve(context, val)
    if val[0] == '$'
      parts = val[1..-1].split('.')
      result = better_dig(context, parts)
      if result == nil
        raise Puppet::ParseError.new("Can't resolve '#{val}' from context")
      end
      result
    else
      val
    end
  end
end
