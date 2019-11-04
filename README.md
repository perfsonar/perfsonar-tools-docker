## perfSONAR Tools docker container

The docker container runs all perfSONAR tools in the "Tools" bundle, as described at:
http://docs.perfsonar.net/install_options.html

This can be used to run the perfSONAR Tools on any OS that supports docker.

Download the container:
>docker pull perfsonar/tools

To run the container in the background, so others can test to you:
>docker run -d --net=host perfsonar/tools

To get an interactive shell on the container, so you can run interactive tests to others:

Get the Container ID:
>docker ps -a

Then use that ID in this command:
>docker exec -it ID bash

## Testing

Sample commands to try to another host with perfSONAR installed:
>owping hostname
>pscheduler task --assist sourceHost throughput --source sourceHost --dest destHost

Note that pscheduler requires the full 'testpoint' bundle installed to run a test to/from a host.
You will not be able to run pScheduler directly to/from this docker container.
However, 3rd party mode using the '--assist' flag, as shown above, will work with this container.

## Notes:
The perfSONAR hostname is assume to be the same is the base host. To use a different
name/IP for the perfSONAR container, see: https://docs.docker.com/articles/networking/
It also assume the base host is running NTP.

## Firewalls:
make sure the following ports are allowed by the base host:
 pScheduler: 443 ; owamp:861, 8760-9960
See: http://www.perfsonar.net/deploy/security-considerations/


