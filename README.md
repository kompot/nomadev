Some experiments with [Nomad](https://nomadproject.io/) and
[Consul](https://consul.io).

To run a Vagrant-based Nomad/Consul cluster ready
to process Nomad's jobs you need some basic preparations.

On Mac OS X

1. [VirtualBox](https://www.virtualbox.org/)

2. [Vagrant](https://www.vagrantup.com/)

3. Ansible 1.9+ and install Ansible Galaxy requirements

```
brew install ansible
ansible-galaxy install -r ansible/requirements.yml
```

4. `vagrant up`

5. Head to http://localhost:8080 to see Consul's web UI with all the nodes.

