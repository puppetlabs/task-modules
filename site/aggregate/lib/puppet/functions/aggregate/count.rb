Puppet::Functions.create_function(:'aggregate::count') do
  dispatch :aggregate_count do
    param 'ResultSet', :resultset
  end

  def aggregate_count(resultset)
    resultset.inject({}) do |agg, result|
      result.value.each do |key, val|
        agg[key] ||= {}
        agg[key][val.to_s] ||= 0
        agg[key][val.to_s] += 1
      end
      agg
    end
  end
end
