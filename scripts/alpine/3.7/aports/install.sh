#!/usr/bin/env sh

# Requires
#    setup.sh
#    apk/install.sh
#    user/aportser.sh

alpine_aports_user=aportser

apk add --no-cache --virtual .build-dependencies alpine-sdk
su - ${alpine_aports_user} -c 'cd /tmp && git clone --depth 1 git://git.alpinelinux.org/aports'
mkdir -p /var/cache/distfiles
chmod a+w /var/cache/distfiles
chgrp abuild /var/cache/distfiles
chmod g+w /var/cache/distfiles
su - ${alpine_aports_user} -c "abuild-keygen -a -i -n"
