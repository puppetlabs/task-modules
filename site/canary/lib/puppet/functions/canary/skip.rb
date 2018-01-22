Puppet::Functions.create_function(:'canary::skip') do
  dispatch :skip_result do
    param 'Array[Variant[Target,String]]', :nodes
  end

  def skip_result(nodes)
    results = nodes.map do |node|
      node = Bolt::Target.new(node) unless node.is_a? Bolt::Target
      Bolt::Result.new(node, value: { '_error' => {
        'msg' => "Skipped #{node.name} because of a previous failure",
        'kind' => 'canary/skipped-node',
        'details' => {} } })
    end
    Bolt::ResultSet.new(results)
  end
end
