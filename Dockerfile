FROM debian:latest AS installer
WORKDIR /app

ARG VERSION
RUN apt-get update && apt install curl -y
RUN curl -s https://install.crowdsec.net | sh
RUN apt install -y crowdsec-firewall-bouncer-nftables=${VERSION#v}

FROM scratch

COPY --from=installer /usr/sbin/crowdsec-firewall-bouncer /usr/sbin/crowdsec-firewall-bouncer
COPY --from=installer /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml

ENTRYPOINT [ "/usr/sbin/crowdsec-firewall-bouncer"]


