Puppet::Functions.create_function(:'aggregate::count') do
  dispatch :aggregate_count do
    param 'ExecutionResult', :result
  end

  def aggregate_count(results)
    aggregates = results.result_hash.inject({}) do |agg, result|
      result[1].each do |key, val|
        agg[key] ||= {}
        agg[key][val.to_s] ||= 0
        agg[key][val.to_s] += 1
      end
      agg
    end
    aggregates
  end
end
