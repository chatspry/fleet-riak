# Fleet Riak
Image for Riak ready to be used with Fleet on CoreOS

## Configurable through etcd
You can set the configuration variables in etcd just like you normally would in `riak.conf`.

```bash
$ etcdctl set /riak/listener.http.internal "127.0.0.1:10011"
```

```bash
$ etcdctl set /riak/storage_backend "memory"
```
