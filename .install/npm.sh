#!/bin/bash

# NPM Global Installs
echo "🥤   Installing global npm packages"

# Not prompted, because required for YCM Completion
npm install -g typescript

NPM_PKGS=(
    "@bigcommerce/stencil-cli"
    "caniuse-cli"
    "eslint-cli"
    "http-server"
    "import-js"
    "markdown-toc"
    "npms-cli"
)

multi_select_from_list "${NPM_PKGS[@]}"

echo "🥤   Installing: ${selected_packages[@]}"
npm install -g ${selected_packages[@]}
