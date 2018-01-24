Puppet::Functions.create_function(:'util::merge') do
  dispatch :merge_hash do
    required_repeated_param 'Hash', :hashes_to_merge
  end

  def merge_hash(*hashes)
    hashes[0].merge(*hashes[1..-1])
  end
end
