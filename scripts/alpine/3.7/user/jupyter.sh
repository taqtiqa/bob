#!/usr/bin/env sh

# No Requires

apk add --no-cache bash

for f in /etc/profile.d/*; do source $f; done

adduser -D -s /bin/bash -u ${OCI_USER_ID} ${OCI_USER} ${OCI_USER_GROUP} 
