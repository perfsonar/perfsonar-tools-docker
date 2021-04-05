# perfSONAR tools

FROM centos:centos7

RUN yum -y install \
    # epel-release repo
    epel-release \
    # perfSONAR repo
    http://software.internet2.edu/rpms/el7/x86_64/latest/packages/perfSONAR-repo-0.10-1.noarch.rpm && \
    # reload the cache for the new repos
    yum clean expire-cache && \
    # install tools bundle and update required tools for docker image
    yum -y install \
    perfsonar-tools \
    supervisor \
    net-tools \
    sysstat \
    tcpdump && \
    # clean up
    yum clean all && \
    rm -rf /var/cache/yum/*

COPY supervisord.conf /etc/supervisord.conf

# The following ports are used:
# owamp:861, 8760-9960/udp
# twamp: 862, 18760-19960/udp
# traceroute: 33434-33634/udp
# simplestream: 5890-5900
# nuttcp: 5000, 5101
# iperf2: 5001
# iperf3: 5201
# ntp: 123/udp
EXPOSE 123/udp 861 862 5000 5001 5101 5201 5890-5900 8760-9960/udp 18760-19960 33434-33634/udp

# add pid directory
VOLUME /var/run

CMD /usr/bin/supervisord -c /etc/supervisord.conf
