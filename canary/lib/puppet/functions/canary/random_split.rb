Puppet::Functions.create_function(:'canary::random_split') do
  dispatch :rand do
    param 'Array', :arr
    param 'Integer', :size
  end

  def rand(arr, size)
    canaries = arr.sample(size)
    rest = arr.select { |r| !canaries.include?(r) }
    [canaries, rest]
  end
end
