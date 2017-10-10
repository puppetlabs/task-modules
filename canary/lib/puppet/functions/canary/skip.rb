Puppet::Functions.create_function(:'canary::skip') do
  dispatch :skip_result do
    param 'Array[String]', :nodes
  end

  def skip_result(nodes)
    result_hash = nodes.reduce({}) do |result, node|
      result[node] = { '_error' => {
        'msg' => "Skipped #{node} because of a previous failure",
        'kind' => 'canary/skipped-node',
        'details' => {} } }
    end
    Puppet::Pops::Types::ExecutionResult.new(result_hash)
  end
end
