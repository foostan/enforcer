# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

num_server_instances = 1
num_client_instances = 1

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  (1..num_server_instances).each do |i|
    node_name = "server-%02d" % i
    bootstrap = i == 1 ? "-bootstrap" : ""
    join = i != 1 ? "-join=192.168.33.101" : ""

    config.vm.define vm_name = node_name do |server|
      ip = "192.168.33.#{i+100}"
      server.vm.network :private_network, ip: ip
      server.vm.provision "shell" do |s|
        s.args   = [node_name, bootstrap, join, ip]
        s.inline = <<-EOF
          #sudo apt-get -y update

          # install services
          sudo apt-get -y install apache2 ntp

          # install consul
          if [ ! -e /usr/bin/consul ]; then
            cp /vagrant/.consul/bin/consul /usr/bin
          fi

          # start consul
          consul leave
          nohup consul agent -node=$1 -server $2 $3 -advertise=$4 -client=$4 -config-dir=/vagrant/.consul/server/config -ui-dir=/vagrant/.consul/ui > /tmp/nohup-$(date +"%Y%m%d%H%M%S").out 2>&1 < /dev/null &
        EOF
      end
    end
  end

  (1..num_client_instances).each do |i|
    node_name = "client-%02d" % i

    config.vm.define vm_name = node_name do |client|
      ip = "192.168.33.#{i+200}"
      client.vm.network :private_network, ip: ip
      client.vm.provision "shell" do |s|
        s.args   = [node_name, ip]
        s.inline = <<-EOF
          #sudo apt-get -y update

          # install services
          sudo apt-get -y install apache2 ntp

          # install consul
          if [ ! -e /usr/bin/consul ]; then
            cp /vagrant/.consul/bin/consul /usr/bin
          fi

          # start consul
          consul leave
          nohup consul agent -node=$1 -join=192.168.33.101 -advertise=$2 -client=$2 -config-dir=/vagrant/.consul/client/config -ui-dir=/vagrant/.consul/ui > /tmp/nohup-$(date +"%Y%m%d%H%M%S").out 2>&1 < /dev/null &
        EOF
      end
    end
  end

end
