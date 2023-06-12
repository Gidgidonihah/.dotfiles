#!/bin/bash

# NPM Global Installs
echo "🥤   Installing global npm packages"

# Not prompted, because required for YCM Completion
npm install -g typescript

NPM_PKGS=(
    "@bigcommerce/stencil-cli"
    "caniuse-cli"
    "eslint-cli"
    "gistup"
    "http-server"
    "import-js"
    "localtunnel"
    "markdown-toc"
    "npms-cli"
    # "write-good" It seems to be more annoying than anything. Especially in docs.
)

multi_select_from_list "${NPM_PKGS[@]}"

echo "🥤   Installing: ${selected_packages[@]}"
npm install -g ${selected_packages[@]}
