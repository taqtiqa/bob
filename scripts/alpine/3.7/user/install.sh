#!/usr/bin/env sh

# No Requires

for f in /etc/profile.d/*; do source $f; done

OCI_USER=${OCI_USER:-bob}
user_name=${1:-$OCI_USER}

apk add --no-cache bash shadow

sed --in-place 's/CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/g' /etc/default/useradd

deluser --remove-home ${user_name}
useradd --create-home --shell /bin/bash --no-user-group --groups wheel,${OCI_USER_GROUP} \
        --gid ${OCI_USER_GROUP_ID} --non-unique --uid ${OCI_USER_ID} ${OCI_USER}

chown ${OCI_USER}:${OCI_USER_GROUP} /home/${OCI_USER}
chmod --recursive --verbose 6755 /home/${OCI_USER}
chmod --recursive --verbose u=rwx,go=rwx,a+s /home/${OCI_USER}

passwd --delete ${user_name}
passwd ${user_name}<<EOF
${user_name}${user_name}
${user_name}${user_name}
EOF

cp /etc/profile /home/${user_name}/.profile
chmod +x /home/${user_name}/.profile