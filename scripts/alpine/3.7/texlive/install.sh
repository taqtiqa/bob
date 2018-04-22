#!/usr/bin/env sh
#
# Requires
#
# - user/aportser.sh
# - aports/install.sh
# - user/aportser.sh 

for f in /etc/profile.d/*; do source $f; done

apk add --no-cache --virtual .build-dependencies unzip xz xz-libs

apk add --no-cache --virtual .build-dependencies perl \
        freetype-dev \
        libpng-dev \
        poppler-dev \
        icu-dev \
        harfbuzz-dev \
        cairo-dev \
        pixman-dev \
        zziplib-dev \
        libpaper-dev \
        graphite2-dev \
        libxmu-dev \
        fontconfig-dev \
        libxaw-dev \
        motif-dev

alpine_aports_user=aportser

##
## NOTE aports/install.sh is where the package folder 
##        tmp/aports/community/ 
##      is determined 
##

##
# Copy APKBUILD.texmf-dist into local repo
pkg_name=texmf-dist
pkg_dir=tmp/aports/community/${pkg_name}
mkdir -p ${pkg_dir}
src=/bob/aports/artifacts/community/${pkg_name}/APKBUILD.${pkg_name}
dst=/${pkg_dir}/APKBUILD
su -l ${alpine_aports_user} -c "cp ${src} ${dst}" 
su -l ${alpine_aports_user} -c "cd /${pkg_dir} && abuild checksum" 
su -l ${alpine_aports_user} -c "cd /${pkg_dir} && abuild -r" 

# Creates the following in:
# /home/${alpine_aports_user}/packages/community/x86_64/
# Size     Name
# APKINDEX.tar.gz
# texmf-dist-2017.46770-r0.apk
# texmf-dist-bibtexextra-2017.46770-r0.apk
# texmf-dist-fontsextra-2017.46770-r0.apk
# texmf-dist-formatsextra-2017.46770-r0.apk
# texmf-dist-full-2017.46770-r0.apk
# texmf-dist-games-2017.46770-r0.apk
# texmf-dist-humanities-2017.46770-r0.apk
# texmf-dist-lang-2017.46770-r0.apk
# texmf-dist-langchinese-2017.46770-r0.apk
# texmf-dist-langcyrillic-2017.46770-r0.apk
# texmf-dist-langextra-2017.46770-r0.apk
# texmf-dist-langgreek-2017.46770-r0.apk
# texmf-dist-langjapanese-2017.46770-r0.apk
# texmf-dist-langkorean-2017.46770-r0.apk
# texmf-dist-latexextra-2017.46770-r0.apk
# texmf-dist-most-2017.46770-r0.apk
# texmf-dist-music-2017.46770-r0.apk
# texmf-dist-pictures-2017.46770-r0.apk
# texmf-dist-pstricks-2017.46770-r0.apk
# texmf-dist-publishers-2017.46770-r0.apk
# texmf-dist-science-2017.46770-r0.apk

##
# Copy APKBUILD.texlive into local repo
pkg_name=texlive
pkg_dir=tmp/aports/community/${pkg_name}
mkdir -p ${pkg_dir}
src=/bob/aports/artifacts/community/${pkg_name}/APKBUILD.${pkg_name}
dst=/${pkg_dir}/APKBUILD
su -l ${alpine_aports_user} -c "cp ${src} ${dst}"
su -l ${alpine_aports_user} -c "cd /${pkg_dir} && abuild checksum"
su -l ${alpine_aports_user} -c "cd /${pkg_dir} && abuild -r"

# Install built package
pkg_name=texlive-full
pkg_ver=20170524-r6
apk add --no-cache --virtual .build-dependencies /home/${alpine_aports_user}/packages/community/x86_64/$pkg_name-$pkg_ver.apk

#
# Test build
#
su -l ${alpine_aports_user} -c "pdflatex -output-format=pdf /bob/texlive/artifacts/texlive-check.tex" 
