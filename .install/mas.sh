#!/bin/bash

# Install Apps from Mac App Store
echo "🥤   Installing MAS Apps"

open /System/Applications/App\ Store.app
enter_to_continue "Press sign in to the mac app store."
confirm_to_continue "Have you signed into the mac app store?"

echo "Installing from Mac App Store"
EXPIRED_APPS=(
  '498944723 - JPEGmini (2.2.1)'
  '413965349 - Soulver (2.6.8)'
  '415739978 - The Secret of Monkey Island: SE'
  '880001334 - Reeder (3.2.1)'
  '407963104 - Pixelmator Classic (3.9.8)'
  '568494494 - Pocket (1.8.1)'
  '425955336 - Skitch - Snap. Mark up. Share. (2.9)'
  '1384080005 - Tweetbot (3.1)'
  '1054607607 - Helium (2.0)'
  '1475897096 - Jira Cloud (139.0.0)'
)

echo """
The following apps are no longer available on the mac app store.
If you have previously purchased them and would like to install them, you must do so manually.
"""
for APP in "${EXPIRED_APPS[@]}"; do
    echo $APP
done
confirm "Would you like to open the purchase history on the Mac App Store?" && open /System/Applications/App\ Store.app

echo "Installing from Mac App Store"
APPS=(
    '1457744893' # EmojiFinder
    '1333542190' # 1Password (7.8.7)
    '444425546'  # BarTunes (1.2)
    '427475982'  # BreakTime (2.5.2)
    '417602904'  # CloudApp (4.4.2)
    '411643860'  # DaisyDisk (4.6.5)
    '1438243180' # Dark Reader (1.4.4)
    '635124250'  # Delicious Library 3 (3.8.2)
    '1437130425' # Jolt of Caffeine (1.0)
    '409183694'  # Keynote (8.2)
    '405772121'  # LittleIpsum (2.0.6)
    '1510445899' # Meeter (1.1.3)
    '1542778639' # Meetinone (1.7.0)
    '419330170'  # Moom (3.2.11)
    '409203825'  # Numbers (5.2)
    '1540160809' # OneTab (1.48)
    '429449079'  # Patterns (1.1.2)
    '1289583905' # Pixelmator Pro (2.1.4)
    '693112260'  # Sim Daltonism (2.0.2)
    '803453959'  # Slack (3.3.2)
    '1176895641' # Spark (2.0.13)
    '1153157709' # Speedtest (1.5)
    '1320666476' # Wipr (1.4)
    '497799835'  # Xcode (10.0)
)

multi_select_app_from_list "${APPS[@]}"

echo "🥤   Installing: ${selected_packages[@]}"
for APP in "${selected_packages[@]}"; do
  mas install $APP
done


if [[ " ${selected_packages[*]} " =~ " 1333542190 " ]]; then
    open /Applications/1Password.app
    enter_to_continue "Please install 1password browser plugins and setup sync with dropbox"
    confirm_to_continue "Have you installed the 1password browser plugins?"
fi

if [[ " ${selected_packages[*]} " =~ " 1176895641 " ]]; then
    open /Applications/Spark.app
    enter_to_continue "Please log into your email in Spark (rata, doba, jason-gidgidonihah, jason.g, gid-gmail, icloud, cruxconnect"
    confirm_to_continue "Have you logged into email in Spark?"
fi

if [[ " ${selected_packages[*]} " =~ " 568494494 " ]]; then
    open /Applications/Pocket.app
    enter_to_continue "Please log into Pocket"
    confirm_to_continue "Have you logged into Pocket?"
fi

if [[ " ${selected_packages[*]} " =~ " 1384080005 " ]]; then
    open /Applications/Tweetbot.app
    enter_to_continue "Please log into Tweetbot"
    confirm_to_continue "Have you logged into Tweetbot?"
fi

confirm_to_continue "Has terminal been granted assistive access?"
# Request assistive access for terminal (silly way of doing so, but it works)
# Required for applescripts to run
osascript <<END
tell application "Terminal"
    activate
    tell application "System Events"
        tell process "Terminal"
            click menu item "Merge All Windows" of menu "Window" of menu bar 1
        end tell
    end tell
end tell
END
confirm_to_continue "Has terminal been granted assistive access?"

openSafariExtensionsWindow() {
    osascript -e '
    tell application "Safari" to activate

    tell application "System Events"
        click menu bar item "Safari" of menu bar 1 of application process "Safari"
        click menu item 4 of menu 1 of menu bar item "Safari" of menu bar 1 of application process "Safari"
        click UI element "Extensions" of toolbar 1 of window 1 of application process "Safari"
    end tell
    '
}

if [[ " ${selected_packages[*]} " =~ " 1320666476 " ]]; then
    # Enable Wipr Safari Extensions
    openSafariExtensionsWindow
    confirm_to_continue "Have you enabled wipr's blocking (all 3 extensions) in Safari?"
fi

if [[ " ${selected_packages[*]} " =~ " 1438243180 " ]]; then
    # Enable Dark Reader extension
    openSafariExtensionsWindow
    confirm_to_continue "Have you enabled the Dark Reader extension in Safari?"
fi

if [[ " ${selected_packages[*]} " =~ " 1540160809 " ]]; then
    # Enable Dark Reader extension
    openSafariExtensionsWindow
    confirm_to_continue "Have you enabled the OneTab extension in Safari?"
fi
