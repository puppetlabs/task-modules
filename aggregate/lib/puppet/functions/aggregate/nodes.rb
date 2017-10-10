Puppet::Functions.create_function(:'aggregate::nodes') do
  dispatch :aggregate_nodes do
    param 'ExecutionResult', :result
  end

  def aggregate_nodes(results)
    aggregates = results.result_hash.inject({}) do |agg, result|
      result[1].each do |key, val|
        agg[key] ||= {}
        agg[key][val.to_s] ||= []
        agg[key][val.to_s] << result[0]
      end
      agg
    end
    aggregates
  end
end
