FROM debian:latest
WORKDIR /app

ARG VERSION
RUN apt-get update && apt install curl -y
RUN curl -s https://install.crowdsec.net | sh
RUN apt install -y crowdsec-firewall-bouncer-iptables=${VERSION#v}


ENTRYPOINT [ "/usr/sbin/crowdsec-firewall-bouncer"]
