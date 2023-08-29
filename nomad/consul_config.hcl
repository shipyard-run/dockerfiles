data_dir  = "/tmp/"
log_level = "DEBUG"

server = false

bind_addr      = "0.0.0.0"
client_addr    = "0.0.0.0"
advertise_addr = "{{GetInterfaceIP \"eth0\"}}"

ports {
  grpc = 8502
  dns = 53
}

connect {
  enabled = true
}