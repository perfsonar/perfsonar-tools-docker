# perfSONAR tools

FROM centos:centos7
MAINTAINER perfSONAR <perfsonar-user@perfsonar.net>

RUN yum -y install \
    # epel-release repo
    epel-release \
    # perfSONAR repo
    http://software.internet2.edu/rpms/el7/x86_64/main/RPMS/perfSONAR-repo-0.8-1.noarch.rpm && \
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

#
# Expose the proper ports for the perfSONAR tools
#
# owamp
EXPOSE 861
EXPOSE 8760-9960/udp
# pscheduler
EXPOSE 443
# iperf3
EXPOSE 5201
# iperf2
EXPOSE 5001
# nuttcp
EXPOSE 5000
EXPOSE 5101
# traceroute
EXPOSE 33434-33634/udp
# simplestream
EXPOSE 5890-5900
# ntp
EXPOSE 123/udp

# add pid directory
VOLUME /var/run

CMD /usr/bin/supervisord -c /etc/supervisord.conf
