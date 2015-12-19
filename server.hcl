bind_addr = "0.0.0.0"
# Increase log verbosity
log_level = "DEBUG"

advertise {
  # We need to specify our host's IP because we can't
  # advertise 0.0.0.0 to other nodes in our cluster.
  rpc = "10.0.1.11:4647"
}

# Setup data dir
data_dir = "/tmp/server1"

# Enable the server
server {
  enabled = true

  # Self-elect, should be 3 or 5 for production
  bootstrap_expect = 1

  options {
    #  "driver.whitelist" = " exec, qemu "
    "consul.address" = "10.0.1.10:8500"
  }
}
