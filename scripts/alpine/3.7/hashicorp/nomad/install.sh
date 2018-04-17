#!/usr/bin/env sh

# Requires:
#
# - setup.sh

#
# Modelled on https://github.com/djenriquez/nomad
# Modelled on https://github.com/hashicorp/docker-consul/blob/master/0.X/Dockerfile
#

#
# Load required env variables: build is in OCI/ACI shell session
#

consul_ver=1.0.7

echo "export HASHICORP_RELEASES=https://releases.hashicorp.com" >> /etc/profile.d/hashicorp.sh
echo "export CONSUL_VERSION=${consul_ver}" >> /etc/profile.d/consul.sh

for f in /etc/profile.d/*; do source $f; done

