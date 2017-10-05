Puppet::Functions.create_function(:'util::exit') do
  dispatch :exit do
    optional_param 'Integer', :exitcode
  end

  def exit(exitcode = 0)
    Kernel.exit(exitcode)
  end
end
