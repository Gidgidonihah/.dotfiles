#!/bin/bash

# Brew Install packages
echo "🥤   Installing homebrew packages"

BREW_TAPS='drone/drone'
for TAP in $BREW_TAPS; do
    brew tap $TAP
done

# adns           fribidi                 guile             libbluray         libvpx        nvm              python@3.8          thefuck
# aom            fswatch                 hadolint          libev             libx11        oniguruma        python@3.9          theora
# autoconf       fzf                     harfbuzz          libevent          libxau        opencore-amr     rav1e               tidy-html5
# autoenv        gd                      helm              libffi            libxcb        openjdk          rbenv               tldr
# awscli         gdbm                    hey               libgcrypt         libxdmcp      openjpeg         readline            tree
# bash           gdk-pixbuf              hr                libgpg-error      libxext       openssl@1.1      ripgrep             unbound
# bdw-gc         gettext                 httpie            libidn2           libxrender    opus             rtmpdump            vim
# berkeley-db    gh                      icu4c             libksba           libyaml       p11-kit          rubberband          watch
# brotli         giflib                  jasper            libogg            libzip        pango            ruby                watchman
# c-ares         git                     jemalloc          libpng            little-cms2   parallel         ruby-build          webp
# cairo          git-secrets             jmeter            libpq             lua           pcre             ruby-install        wget
# cloc           gitleaks                joplin            libpthread-stubs  lynx          pcre2            ruby@2.5            wireguard-go
# cmake          glib                    jpeg              librsvg           lzo           perl             ruby@2.7            wireguard-tools
# colordiff      gmp                     jq                libsamplerate     m4            pgcli            sdl2                x264
# ctags          gnu-getopt              jsonlint          libsndfile        mas           pinentry         snappy              x265
# dav1d          gnupg                   kind              libsodium         minikube      pinentry-mac     sops                xorgproto
# dos2unix       gnutls                  kompose           libsoxr           mpdecimal     pixman           speex               xvid
# drone          go                      krb5              libtasn1          mycli         pkg-config       sqlite              xz
# entr           gobject-introspection   kubectx           libtiff           ncurses       postgresql       srt                 yamllint
# ffmpeg         graphite2               kubernetes-cli    libtool           netpbm        pre-commit       svgo                yarn
# flac           graphviz                kubernetes-helm   libunistring      nettle        pv               tcl-tk              zeromq
# fontconfig     grip                    lame              libusb            nghttp2       pyenv            telnet              zimg
# fpp            gron                    leptonica         libuv             node          python-tabulate  terminal-notifier
# freetype       gsl                     libass            libvidstab        nodeenv       python-yq        terraform
# frei0r         gts                     libassuan         libvorbis         npth          python@2         tesseract

BREW_PKGS='
awscli
cmake
ctags
colordiff
drone
entr
fpp
fzf
fswatch
git
git-secrets
gnupg
go
hadolint
hey
hr
httpie
joplin
jq
lynx
mas
mycli
node
nvm
pinentry-mac
python
python-yq
svgo
terminal-notifier
tldr
thefuck
tidy-html5
tree
vim
watchman
wget
yarn
zoom
'
for PKG in $BREW_PKGS; do
    echo "🥤   Installing $PKG"
    brew install $PKG
done

# Make typescript available for YCM Completion
npm install -g typescript
