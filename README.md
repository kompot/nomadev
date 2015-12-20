Some experiments with setting up [Nomad](https://nomadproject.io/) and
[Consul](https://consul.io) using Ansible in Vagrant.

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

5. Head to [localhost:8080](http://localhost:8080) to see Consul's web UI with all the nodes.

Now it's time to throw some tasks into the cluster. Download [Nomad](https://nomadproject.io/downloads.html)
to have `nomad` command available in terminal and run the following

```
nomad node-status
# output should be like this
ID                                    DC   Name     Class   Drain  Status
90c877a8-b52c-1867-7b8e-8f83543ea782  dc1  client2  <none>  false  ready
ac53e70d-8a3b-bd96-8b35-111629e2bb0e  dc1  client1  <none>  false  ready
```

to make sure Nomad server is visible from your host.

Now you can run nomad jobs and have nomad schedule them

```
nomad run example.nomad
```

This should allocate 1 nginx and 1 redis docker container.
Type `nomad status` to check job's status and `nomad status example` to
take a closer look at the `example` nomad task. Consul (at [localhost:8080](http://localhost:8080))
should monitor each container health (try to kill the container on `client1` or `client2` with `docker kill [containerId]`)
and show its availability status.

Feel free to adjust `count` parameter in `example.job`, run `nomad run example.nomad` and watch nomad do the resize.
