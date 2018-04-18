#!/usr/bin/env sh

# No Requires

export OCI_USER=jovyan
export OCI_USER_ID=1000
export OCI_USER_GROUP_ID=100
export OCI_USER_GROUP=$(getent group ${oci_u_g_id}|cut -d: -f1)

export OCI_ORG='taqtiqa.io'
export OCI_AUTHOR='TAQTIQA LLC'
export OCI_EMAIL='coders@taqtiqa.com'
export OCI_ARCH='amd64'
export OCI_OS='linux'
