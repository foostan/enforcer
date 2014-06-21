require 'attender'

consul_api_endpoint = '192.168.33.101'
port = '8500'
attender = Attender::Agent.new(consul_api_endpoint, port)

nodes = attender.get('/v1/catalog/nodes', false)
nodes.each do |node|
  node_name = node['Node']
  node_ipaddr = node['Address']
  node_info = attender.get("/v1/catalog/node/#{node_name}", false)
  node_services = node_info['Services'].keys

  server node_ipaddr, user: 'vagrant', password: 'vagrant', roles: node_services
end
