Puppet::Functions.create_function(:'canary::merge') do
  dispatch :merge_results do
    param 'ExecutionResult', :merger
    param 'ExecutionResult', :mergee
  end

  def merge_results(merger, mergee)
    Puppet::Pops::Types::ExecutionResult.new(merger.result_hash.merge(mergee.result_hash))
  end
end
