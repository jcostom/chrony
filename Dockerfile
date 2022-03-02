FROM debian:bullseye

ENV TZ=America/New_York

RUN \
    apt update && apt install -yq chrony \
    && apt clean

RUN mkdir /app
COPY ./startup.sh /app
RUN chmod 755 /app/startup.sh

EXPOSE 123/udp

HEALTHCHECK --interval=5m --start-period=1m --retries=3 CMD chronyc tracking || exit 1

ENTRYPOINT [ "/bin/bash", "/app/startup.sh" ]