Puppet::Functions.create_function(:'util::loadyaml') do
  dispatch :loadyaml do
    param 'String', :path
    optional_param 'Hash', :defaults
  end

  def loadyaml(path, defaults = nil)
    defaults ||= {}
    if File.exists?(path)
      result = YAML::load_file(path)
    else
      raise Puppet::ParseError("Can't load '#{path}' File does not exist!")
    end
    defaults.merge(result)
  end
end
