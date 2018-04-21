#!/usr/bin/env sh

# No Requires

alpine_aports_user=aportser

for f in /etc/profile.d/*; do source $f; done

adduser ${alpine_aports_user}
addgroup ${alpine_aports_user} abuild

echo "${alpine_aports_user}    ALL=(ALL) ALL" >>/etc/sudoers
