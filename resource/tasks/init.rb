#!/opt/puppetlabs/puppet/bin/ruby

require 'puppet'
require 'json'

def get(type, name)
  output_instances = []
  opts = { name: name } unless name.nil?
  type = Puppet::Type.type(type.to_sym)
  instances = type.instances
  if name.nil?
    instances.each do |instance|
      output_instances.push(instance.to_resource.to_hash)
    end
  else
    res = instances.find { |i| i[:name] == name }
    output_instances.push(res.to_resource.to_hash) if res
  end

  result = output_instances.to_json
  { _output: result }
end

params = JSON.parse(STDIN.read)
type = params['type']
name = params['name']

begin
  result = get(type, name)
  puts result.to_json
  exit 0
rescue Puppet::Error => e
  puts({ status: 'failure', error: e.message }.to_json)
  exit 1
end
