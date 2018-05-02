#!/usr/bin/env sh
#
# Requires
#
# - user/aportser.sh
# - aports/install.sh
# - texlive/build.sh

alpine_aports_user=aportser

# Install built (texlive/build.sh) packages
cp -f /etc/apk/repositories /etc/apk/repositories.bak
echo /home/${alpine_aports_user}/packages/testing/ >>/etc/apk/repositories
echo /home/${alpine_aports_user}/packages/community/ >>/etc/apk/repositories
echo /home/${alpine_aports_user}/packages/main/ >>/etc/apk/repositories

# Adds approx 560 MB in 38 packages
apk add --no-cache texlive-dvi texlive-xetex

cp -f /etc/apk/repositories.bak /etc/apk/repositories
rm -f /etc/apk/repositories.bak

# texlive/build.sh Creates the following in:
# /home/${alpine_aports_user}/packages/community/x86_64/
# Size     Name
# ?????? APKINDEX.tar.gz
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

# texlive/build.sh Creates the following in:
# /home/${alpine_aports_user}/packages/community/x86_64/
# Size     Name
# ?????? APKINDEX.tar.gz
#   6.8M texlive-20170524-r6.apk
# 553.3K texlive-dev-20170524-r6.apk
# 498.6K texlive-doc-20170524-r6.apk
# 227.6K texlive-dvi-20170524-r6.apk
#   1.2K texlive-full-20170524-r6.apk
#   4.9M texlive-luatex-20170524-r6.apk
# 273.3K texlive-xetex-20170524-r6.apk
# 289.3K xdvik-20170524-r6.apk

# #    Jupyter Upstream \ Alpine Build
# #    texlive-fonts-extra \ texmf-dist-most-2017.46770-r0.apk
# #    texlive-fonts-recommended \ texmf-dist-most-2017.46770-r0.apk
# #    texlive-generic-recommended \ texmf-dist-most-2017.46770-r0.apk
# #    texlive-latex-base \ texmf-dist-most-2017.46770-r0.apk
# #    texlive-latex-extra \ texmf-dist-most-2017.46770-r0.apk
# #    texlive-xetex \ texlive-xetex-20170524-r6.apk
