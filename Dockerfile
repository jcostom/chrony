FROM ubuntu:jammy-20230425

ARG TZ=America/New_York

RUN \
    apt update && DEBIAN_FRONTEND=noninteractive apt install -yq chrony \
    && apt clean

RUN mkdir /app
COPY ./startup.sh /app
RUN chmod 755 /app/startup.sh

EXPOSE 123/udp

HEALTHCHECK --interval=3m --start-period=1m --retries=3 CMD chronyc tracking || exit 1

ENTRYPOINT [ "/bin/bash", "/app/startup.sh" ]

