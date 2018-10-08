# Install one-off and manual things

# Install Apps from Mac App Store
echo "🥤   Executing misc steps"

# Instal virtualenvwrapper
pip install virtualenvwrapper

# Install delivery status widget
enter_to_continue "Install (and log into) the Delivery Status widget"
open https://junecloud.com/software/dashboard/delivery-status.html
confirm_to_continue "Have you installed and logged into the Delivery Status widget?"

# Install github tokens
request_github_token() {
  TYPE=$1
  SCOPE=${2:-'none'}

  echo "Please generate a github token for $TYPE (required scopes: $SCOPE)"
  confirm 'Open github link?' && open https://github.com/settings/tokens

  MSG="Please enter your github token for $TYPE"
  TOKEN=$(get_input 'Enter your access token')

  if [ $TYPE = "gren" ]; then
    TOKEN_NAME='GREN_GITHUB_TOKEN'
  else
    TOKEN_NAME="$(echo $TYPE | awk '{print toupper($0)}')_GITHUB_API_TOKEN"
  fi

  echo "$TOKEN_NAME=$TOKEN" >> ~/.profile.d/private.github-tokens.sh
}
confirm "Would you like to set up a homebrew github token?" && request_github_token 'Homebrew'
confirm "Would you like to set up a gren (github-tools/github-release-notes) github token?" && request_github_token 'gren' 'repo'

# Setup drone tokens
setup_drone() {
  SERVER=$(get_input 'Enter your drone server url')
  TOKEN=$(get_input 'Enter your drone access token')

  echo "DRONE_SERVER=${SERVER}" > ~/.profile.d/private.thanos-drone-token.sh
  echo "DRONE_TOKEN=${TOKEN}" >> ~/.profile.d/private.thanos-drone-token.sh
}
confirm "Would you like to set up drone?" && setup_drone

# Install powerline fonts
curl https://raw.githubusercontent.com/powerline/fonts/master/NotoMono/Noto%20Mono%20for%20Powerline.ttf -o ~/Library/Fonts/Noto\ Mono\ for\ Powerline.ttf

confirm_to_continue "Have you setup time machine backups?"
