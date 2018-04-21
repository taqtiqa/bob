#!/usr/bin/env sh
#
# Requires
#
# - setup.sh
# - sudo/install.sh
# - user/install.sh ${OCI_USER}
# - aports/install.sh

for f in /etc/profile.d/*; do source $f; done

apk add --virtual .build-dependencies unzip xz xz-libs

alpine_aports_user=${OCI_USER:-bob}

##
## NOTE aports/install.sh is where the package folder 
##        tmp/aports/community/ 
##      is determined 
##

##
# Copy APKBUILD.texmf-dist into local repo
pkg_name=texmf-dist
pkg_dir=tmp/aports/community/${pkg_name}
mkdir --parents ${pkg_dir}
src=/bob/aports/artifacts/${pkg_name}/APKBUILD.${pkg_name}
dst=/${pkg_dir}/APKBUILD
su --login --command "cp ${src} ${dst}" ${alpine_aports_user}
su --login --command "cd /${pkg_dir} && abuild checksum" ${alpine_aports_user} 
su - ${alpine_aports_user} --command "cd /${pkg_dir} && abuild -r" 

##
# Copy APKBUILD.texlive into local repo
pkg_name=texlive
pkg_dir=tmp/aports/community/${pkg_name}
mkdir --parents ${pkg_dir}
src=/bob/aports/artifacts/${pkg_name}/APKBUILD.${pkg_name}
dst=/${pkg_dir}/APKBUILD
su --login --command "cp ${src} ${dst}" ${alpine_aports_user}
su --login --command "cd /${pkg_dir} && abuild checksum" ${alpine_aports_user}
su --login --command "PATH=/usr/lib:$PATH && cd /${pkg_dir} && abuild -r" ${alpine_aports_user}

# Install built package
pkg_name=texlive-full
pkg_ver=20170524-r5
apk add /tmp/packages/community/x86_64/${pkg_name}-${pkg_ver}.apk

#
# Test build
#
su --login --command "pdflatex -output-format=pdf /bob/texlive/artifacts/texlive-check.tex" ${alpine_aports_user}
