#!/usr/bin/env sh

# Requires:
#
# - setup.sh
# - glibc/install.sh
# - openjdk7jre/install.sh

# TODO: Nomad-Spark 
# https://github.com/hashicorp/nomad-spark
# https://github.com/hashicorp/nomad/blob/master/terraform/examples/spark/docker/spark/Dockerfile
# https://github.com/djenriquez/nomad/blob/master/Dockerfile
# 
# Apache Spark is integrated with mesos. Which is heavy:
# The Mesos only Docker containers are approx 465MB.  
# The Nomad+Consul only containers are approx 33MB. 
# A factor of ten difference.  This could allow allow the ACI/OCI images to be distributed 
# as Github release artifacts, which have a 2GB size limit.

#
# Load required env variables: build is in OCI/ACI shell session
#

echo "export SPARK_HOME=/opt/spark" >> /etc/profile.d/spark.sh
echo "export PATH=${PATH}:${SPARK_HOME}/bin" >> /etc/profile.d/spark.sh

for f in /etc/profile.d/*; do source $f; done

wget -qO- https://spark-nomad.s3.amazonaws.com/spark-2.1.1-bin-nomad.tgz | tar -xzC /opt
# mv /tmp/spark* /opt/spark

apk update
apk add --virtual .build-dependencies --no-cache alpine-sdk wget

