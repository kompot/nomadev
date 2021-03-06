Some experiments with setting up [Nomad](https://nomadproject.io/) and
[Consul](https://consul.io) using Ansible in [Vagrant](https://www.vagrantup.com/) (1.8+ required
as it uses `ansible_local` provisioning).

Create 4 machines with

```vagrant up```

and head to [localhost:8080](http://localhost:8080)
to see Consul's web UI with all the nodes.

It's time to throw some tasks into the cluster. Download [Nomad](https://nomadproject.io/downloads.html)
to have `nomad` command available in terminal and run the following

```
nomad node-status
```

output should be like this

```
ID                                    DC   Name     Class   Drain  Status
90c877a8-b52c-1867-7b8e-8f83543ea782  dc1  client2  <none>  false  ready
ac53e70d-8a3b-bd96-8b35-111629e2bb0e  dc1  client1  <none>  false  ready
```

This means Nomad server is visible from your host.

Now you can run nomad jobs and have nomad schedule them

```
nomad run example.nomad
```

This should allocate 1 nginx and 1 redis docker container.
Type `nomad status` to check job's status and `nomad status example` to
take a closer look at the `example` nomad task. Consul (at [localhost:8080](http://localhost:8080))
should show its availability status and monitor each container's health (try
to kill the container on `client1` or `client2` with `docker kill [containerId]`).

Feel free to adjust `count` parameter in `example.job`, run `nomad run example.nomad`
and watch nomad do the resize.
