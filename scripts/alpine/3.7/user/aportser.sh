#!/usr/bin/env sh

# No Requires

alpine_aports_user=aportser

for f in /etc/profile.d/*; do source $f; done

adduser ${alpine_aports_user}
passwd -d ${alpine_aports_user}

addgroup ${alpine_aports_user} abuild
addgroup ${alpine_aports_user} wheel

echo "%wheel ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
