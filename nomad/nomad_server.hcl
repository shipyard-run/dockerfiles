data_dir = "/etc/nomad.d/data"

server {
  enabled = true
  bootstrap_expect = 1
}

client {
    enabled = true
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}