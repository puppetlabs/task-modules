Puppet::Functions.create_function(:length) do
  local_types do
    type 'HasLength = Variant[Array, Hash, String]'
  end

  dispatch :size do
    param 'HasLength', :obj
  end

  def length(obj)
    obj.length
  end
end
