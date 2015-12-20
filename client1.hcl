# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/client1"

# Enable the client
client {
  enabled = true

  # For demo assume we are talking to server1. For production,
  # this should be like "nomad.service.consul:4647" and a system
  # like Consul used for service discovery.
  servers = ["nomad-server.node.consul:4647"]
  #options {
#  "driver.whitelist" = " exec, qemu "
  #  "consul.address" = "10.0.1.10:8500"
  #}
}

# Modify our port to avoid a collision with server1
ports {
  http = 5656
}
