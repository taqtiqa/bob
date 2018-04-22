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
# ?????? texmf-dist-2017.46770-r0.apk
#   3.9M texmf-dist-bibtexextra-2017.46770-r0.apk
# 499.8M texmf-dist-fontsextra-2017.46770-r0.apk
#   2.2M texmf-dist-formatsextra-2017.46770-r0.apk
#   1.1K texmf-dist-full-2017.46770-r0.apk
# 557.6K texmf-dist-games-2017.46770-r0.apk
# 449.2K texmf-dist-humanities-2017.46770-r0.apk
#   1.2K texmf-dist-lang-2017.46770-r0.apk
#  76.3M texmf-dist-langchinese-2017.46770-r0.apk
#   4.0M texmf-dist-langcyrillic-2017.46770-r0.apk
#  27.6M texmf-dist-langextra-2017.46770-r0.apk
#  69.1M texmf-dist-langgreek-2017.46770-r0.apk
# 128.3M texmf-dist-langjapanese-2017.46770-r0.apk
#  73.7M texmf-dist-langkorean-2017.46770-r0.apk
#  14.2M texmf-dist-latexextra-2017.46770-r0.apk
#   1.2K texmf-dist-most-2017.46770-r0.apk
#  16.7M texmf-dist-music-2017.46770-r0.apk
#   4.2M texmf-dist-pictures-2017.46770-r0.apk
#  27.1M texmf-dist-pstricks-2017.46770-r0.apk
#  13.5M texmf-dist-publishers-2017.46770-r0.apk


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

# Creates the following in:
# /home/${alpine_aports_user}/packages/community/x86_64/
# Size     Name
# APKINDEX.tar.gz
#   6.8M texlive-20170524-r6.apk
# 553.3K texlive-dev-20170524-r6.apk
# 498.6K texlive-doc-20170524-r6.apk
# 227.6K texlive-dvi-20170524-r6.apk
#   1.2K texlive-full-20170524-r6.apk
#   4.9M texlive-luatex-20170524-r6.apk
# 273.3K texlive-xetex-20170524-r6.apk
# 289.3K xdvik-20170524-r6.apk

# Install built package
cp -f /etc/apk/repositories /etc/apk/repositories.bak
echo /home/${alpine_aports_user}/packages/testing/ >>/etc/apk/repositories
echo /home/${alpine_aports_user}/packages/community/ >>/etc/apk/repositories
echo /home/${alpine_aports_user}/packages/main/ >>/etc/apk/repositories
pkg_name=texlive-full
pkg_ver=20170524-r6
apk add --no-cache --virtual .build-dependencies /home/${alpine_aports_user}/packages/community/x86_64/$pkg_name-$pkg_ver.apk
cp -f /etc/apk/repositories.bak /etc/apk/repositories
rm -f /etc/apk/repositories.bak

#
# Test build
#
su -l ${alpine_aports_user} -c "pdflatex -output-format=pdf -output-directory=/tmp /bob/texlive/artifacts/tmp/texlive-test.tex" 
