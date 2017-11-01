Puppet::Functions.create_function(:'util::print') do
  dispatch :print do
    param 'String', :message
  end

  def print(message)
    puts message
  end
end
