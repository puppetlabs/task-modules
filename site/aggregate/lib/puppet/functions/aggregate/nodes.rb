Puppet::Functions.create_function(:'aggregate::nodes') do
  dispatch :aggregate_nodes do
    param 'ResultSet', :resultset
  end

  def aggregate_nodes(resultset)
    resultset.inject({}) do |agg, result|
      result.value.each do |key, val|
        agg[key] ||= {}
        agg[key][val.to_s] ||= []
        agg[key][val.to_s] << result.target.name
      end
      agg
    end
  end
end
