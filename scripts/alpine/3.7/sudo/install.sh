#!/usr/bin/env sh

# No Requires

for f in /etc/profile.d/*; do source $f; done

apk add --no-cache sudo
cat <<EOF > /etc/sudoers
root ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD: ALL
EOF