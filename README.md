# Consul Demo

- download consul: https://www.consul.io/downloads.html

run consul in docker:
```
sudo make serve
```

## updating dns address
- insert ip of docker consult to `/etc/resolv.conf` before `nameserver 127.0.0.53`. example:

from:
```
# [...redacted...]
# See man:systemd-resolved.service(8) for details about the supported modes of
# operation for /etc/resolv.conf.

nameserver 127.0.0.53
```

to:
```
# [...redacted...]
# See man:systemd-resolved.service(8) for details about the supported modes of
# operation for /etc/resolv.conf.

nameserver 172.17.0.2
nameserver 127.0.0.53
```

check if dns is resolving: `dig web1.service.consul`