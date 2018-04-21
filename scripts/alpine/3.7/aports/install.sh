#!/usr/bin/env sh

# Requires
#    setup.sh
#    user/aportser.sh
#    apk/install.sh

alpine_aports_user=aportser

apk add --virtual .build-dependencies alpine-sdk
su - ${alpine_aports_user} -c 'cd /tmp && git clone --depth 1 git://git.alpinelinux.org/aports'
mkdir -p /var/cache/distfiles
chmod a+w /var/cache/distfiles
chgrp abuild /var/cache/distfiles
chmod g+w /var/cache/distfiles
su --login ${alpine_aports_user} --command "abuild-keygen -a -i -n"
