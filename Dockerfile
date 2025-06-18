# perfSONAR tools

FROM ubuntu:22.04

ENV container=docker
ENV LC_ALL=C
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y curl gnupg net-tools sysstat iproute2 dnsutils tcpdump software-properties-common supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -o /etc/apt/sources.list.d/perfsonar-release.list https://downloads.perfsonar.net/debian/perfsonar-release.list \
    && curl -s -o /etc/apt/trusted.gpg.d/perfsonar-release.gpg.asc https://downloads.perfsonar.net/debian/perfsonar-release.gpg.key \
    && add-apt-repository universe

RUN apt-get update \
    && apt-get install -y perfsonar-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/log/supervisor 
COPY supervisord.conf /etc/supervisord.conf

# The following ports are used:
# owamp: 861/tcp, 8760-9960/udp
# twamp: 862/tcp, 18760-19960/udp
# traceroute: 33434-33634/udp
# simplestream: 5890-5900/tcp
# nuttcp: 5000/tcp, 5101/tcp
# iperf2: 5001/tcp
# iperf3: 5201/tcp
# ntp: 123/udp
EXPOSE 123/udp 861/tcp 862/tcp 5000/tcp 5001/tcp 5101/tcp 5201/tcp 5890-5900/tcp 8760-9960/udp 18760-19960/udp 33434-33634/udp

# add pid directory and logging directory
VOLUME [ "/var/run", "/var/log" ]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
