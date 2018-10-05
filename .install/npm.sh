#!/bin/bash

# NPM Global Installs
echo "🥤   Installing global npm packages"

PKGS='
caniuse-cli
eslint-cli
http-server
import-js
markdown-toc
npms-cli
'
# For bigcommerce themes, add
#  @bigcommerce/stencil-cli

for PKG in $PKGS; do
    npm install -g $PKG
done
