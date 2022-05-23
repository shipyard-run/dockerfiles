container "server.consul" {
  image {
    name = "consul:1.12.0"
  }

  command = ["consul", "agent", "-config-file=/config/consul.hcl"]

  volume {
    source      = "./files/consul_server.hcl"
    destination = "/config/consul.hcl"
  }

  port {
    local  = 8500
    remote = 8500
    host   = 8500
  }

  network {
    name = "network.dc1"
  }
}