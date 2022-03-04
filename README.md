# chrony

## Chrony-based NTP server container for networks

This project draws (heavily) on its inspiration from the excellent work of Chris Turra on the [cturra/ntp](https://github.com/cturra/docker-ntp) container. He's really done excellent work there. I just happen to prefer a Debian-based image, so I took some let's call it fairly liberal inspiration from his work and built this.

While based in many ways off Chris's container, there are some notable differences, and I did make a handful of changes in the startup script, including changing out for some variables instead of hard-coding some path names and user/group values, plus I prefer to use Google's NTP servers, while he likes Cloudflare's. To each his own, variety is the spice of life, etc.

The container doesn't have, nor does it need (nor want) to have the SYS_TIME capability. This is by design. If you'd like to modify the container to give it access to your system clock, that's on you, along with the risks the come along for the ride. I warned you. :)

Feed the container an environment variable of NTP_SERVERS with a comma delimited string of your preferred set of NTP servers, or accept the default set of time[1-4].google.com. Make sure to forward 123/udp into the container, otherwise, what's the point?

Set your LOG_LEVEL as 0 (informational), 1 (warning), 2 (non-fatal error), or 3 (fatal error)

Launch the container something like this...

```bash
docker run -d \
  --name=chrony \
  --restart=unless-stopped \
  -e LOG_LEVEL=0 \
  -e NTP_SERVERS="time1.google.com,time3.google.com,time3.google.com,time4.google.com" \
  -p 123:123/udp \
  jcostom/chrony:latest
```

Here's an example docker-compose file:

```yaml
---
version: '3'

services:
  chrony:
    image: jcostom/chrony:latest
    container_name: chrony
    restart: unless-stopped
    ports:
      - 123:123/udp
    environment:
      - LOG_LEVEL=0
      - NTP_SERVERS="time1.google.com,time3.google.com,time3.google.com,time4.google.com"
    network_mode: bridge
```
