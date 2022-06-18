network "dc1" {
  subnet = "10.0.0.0/16"
}

nomad_cluster "dev" {
  client_nodes = "3"
  version      = "1.3.1-1.dev"

  network {
    name = "network.dc1"
  }

  image {
    name = "consul:1.12.0"
  }

  consul_config = "./files/consul_agent.hcl"

  volume {
    source      = "/tmp"
    destination = "/files"
  }
}

nomad_ingress "web" {
  cluster = "nomad_cluster.dev"
  job     = "web"
  group   = "web"
  task    = "web"

  network {
    name = "network.dc1"
  }

  port {
    local  = 9090
    remote = "http"
    host   = 19090
  }
}

output "NOMAD_ADDR" {
  value = cluster_api("nomad_cluster.dev")
}
