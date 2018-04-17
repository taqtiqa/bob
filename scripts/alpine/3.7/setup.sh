#!/usr/bin/env sh

# Requires
# 
# ./bob/bob.sh
#

export oci_u=jovyan
export oci_u_id=1000
export oci_u_g_id=100
export oci_u_g=$(getent group ${oci_u_g_id}|cut -d: -f1)

export OCI_ORG='taqtiqa.io'
export OCI_AUTHOR='TAQTIQA LLC'
export OCI_EMAIL='coders@taqtiqa.com'
export OCI_ARCH='amd64'
export OCI_OS='linux'

# # cat /etc/os-release
# NAME="Alpine Linux"
# ID=alpine
# VERSION_ID=3.7.0
# PRETTY_NAME="Alpine Linux v3.7"
# HOME_URL="http://alpinelinux.org"
# BUG_REPORT_URL="http://bugs.alpinelinux.org"
source /etc/os-release

DISTRIB_ID=${ID}
DISTRIB_RELEASE=${VERSION_ID} 
# 3.7.0 -> 3.7     
DISTRIB_CODENAME=${VERSION_ID%.*}  
DISTRIB_DESCRIPTION=${PRETTY_NAME} 

echo "export DISTRIB_ID=${ID}" >> /etc/profile.d/bob.sh
echo "export DISTRIB_RELEASE=${VERSION_ID}" >> /etc/profile.d/bob.sh
echo "export DISTRIB_CODENAME=${VERSION_ID%.*}" >> /etc/profile.d/bob.sh
echo "export DISTRIB_DESCRIPTION=${PRETTY_NAME}" >> /etc/profile.d/bob.sh
echo "export OCI_USER=${oci_u}" >> /etc/profile.d/bob.sh
echo "export OCI_USER_ID=${oci_u_id}" >> /etc/profile.d/bob.sh
echo "export OCI_USER_GROUP_ID=${oci_u_g_id}" >> /etc/profile.d/bob.sh
echo "export OCI_USER_GROUP=${oci_u_g}" >> /etc/profile.d/bob.sh

#
# Load required env variables is case we are building 
# in the same shell session
#
for f in /etc/profile.d/*; do source $f; done

source ./bob/bob.sh


setup-hostname alpine
