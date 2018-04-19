#!/usr/bin/env sh

# Requires
#    setup.sh
#    sudo/install.sh
#    user/install.sh ${OCI_USER}
#    apk/install.sh

alpine_aports_user=${OCI_USER:-bob}

apk add --virtual .build-dependencies alpine-sdk
su - ${alpine_aports_user} -c 'cd /tmp && git clone --depth 1 git://git.alpinelinux.org/aports'
addgroup ${alpine_aports_user} abuild
mkdir -p /var/cache/distfiles
chmod a+w /var/cache/distfiles
chgrp abuild /var/cache/distfiles
chmod g+w /var/cache/distfiles
su - ${alpine_aports_user} -c "abuild-keygen -a -i -n"

##
# Copy APKBUILD.texlive  into upstream
pkg_name=texlive
src=/home/${alpine_aports_user}/aports/artifacts/home/${alpine_aports_user}/aports/community/${pkg_name}/APKBUILD.${pkg_name}
dst=/tmp/aports/community/${pkg_name}/APKBUILD
su - ${alpine_aports_user} -c "cp ${src} ${dst}"

##
# Copy APKBUILD.texmf-dist into upstream
pkg_name=texmf-dist
src=/home/${alpine_aports_user}/aports/artifacts/home/${alpine_aports_user}/aports/community/${pkg_name}/APKBUILD.${pkg_name}
dst=/tmp/aports/community/${pkg_name}/APKBUILD
su - ${alpine_aports_user} -c "cp ${src} ${dst}"
