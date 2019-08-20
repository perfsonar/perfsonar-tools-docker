# perfSONAR tools

FROM centos:centos7
MAINTAINER perfSONAR <perfsonar-user@perfsonar.net>

RUN yum -y install epel-release
RUN yum -y update; yum clean all
RUN rpm -hUv http://software.internet2.edu/rpms/el7/x86_64/latest/packages/perfSONAR-repo-0.9-1.noarch.rpm 
RUN yum -y install perfsonar-tools
RUN yum -y install supervisor net-tools sysstat tcpdump # grab a few other favorite tools

RUN mkdir -p /var/log/supervisor 
ADD supervisord.conf /etc/supervisord.conf

# The following ports are used:
# owamp:861, 8760-9960
# ranges not supported, so need to use docker run -P to expose all ports

# add pid directory
VOLUME /var/run

CMD /usr/bin/supervisord -c /etc/supervisord.conf

