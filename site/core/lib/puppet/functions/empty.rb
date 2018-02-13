Puppet::Functions.create_function(:empty) do
  local_types do
    type 'HasEmpty = Variant[Array, Hash, String]'
  end

  dispatch :empty do
    param 'HasEmpty', :obj
  end

  def empty(obj)
    obj.empty?
  end
end
