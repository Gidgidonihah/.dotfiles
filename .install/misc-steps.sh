# Install one-off and manual things

# Install Apps from Mac App Store
echo "🥤   Executing misc steps"

# Instal virtualenvwrapper
pip install virtualenvwrapper

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

  echo "export $TOKEN_NAME=$TOKEN" >> ~/.profile.d/private.github-tokens.sh
}
confirm "Would you like to set up a homebrew github token?" && request_github_token 'Homebrew'
confirm "Would you like to set up a gren (github-tools/github-release-notes) github token?" && request_github_token 'gren' 'repo'

# Install fonts
curl https://raw.githubusercontent.com/powerline/fonts/master/NotoMono/Noto%20Mono%20for%20Powerline.ttf -o ~/Library/Fonts/Noto\ Mono\ for\ Powerline.ttf
curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Regular.ttf
curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Bold.ttf
curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Italic.ttf
curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Bold\ Italic.ttf
cp ${HOME}/Library/Mobile\ Documents/com~apple~CloudDocs/Fonts/* ${HOME}/Library/Fonts/

confirm_to_continue "Have you setup time machine backups?"
