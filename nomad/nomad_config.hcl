data_dir = "/etc/nomad.d/data"

server {
  enabled = true
  bootstrap_expect = 1
}

client {
    enabled = true
    options = {
      "fingerprint.denylist" = "env_digitalocean,env_aws,env_gce,env_azure"
    }
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}