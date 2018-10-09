#!/bin/bash

# Install Apps from Mac App Store
echo "🥤   Installing MAS Apps"

open /Applications/App\ Store.app
enter_to_continue "Press sign in to the mac app store."
confirm_to_continue "Have you signed into the mac app store?"

echo "Installing from Mac App Store"
for APP in \
  '443987910'  `# 1Password (6.8.8)` \
  '693112260'  `# Sim Daltonism (2.0.2)` \
  '1153157709' `# Speedtest (1.5)` \
  '498944723'  `# JPEGmini (2.2.1)` \
  '880001334'  `# Reeder (3.2.1)` \
  '429449079'  `# Patterns (1.1.2)` \
  '407963104'  `# Pixelmator (3.7.5)` \
  '405772121'  `# LittleIpsum (2.0.6)` \
  '1384080005' `# Tweetbot (3.1)` \
  '417602904'  `# CloudApp (4.4.2)` \
  '444425546'  `# BarTunes (1.2)` \
  '1176895641' `# Spark (2.0.13)` \
  '427475982'  `# BreakTime (2.5.2)` \
  '568494494'  `# Pocket (1.8.1)` \
  '419330170'  `# Moom (3.2.11)` \
  '413965349'  `# Soulver (2.6.8)` \
  '803453959'  `# Slack (3.3.2)` \
  '489094439'  `# iTeleport (6.1.8)` \
  '1437130425' `# Jolt of Caffeine (1.0)` \
  '411643860'  `# DaisyDisk (4.6.5)` \
  '409203825'  `# Numbers (5.2)` \
  '409183694'  `# Keynote (8.2)` \
  '635124250'  `# Delicious Library 3 (3.8.2)` \
  '1320666476' `# Wipr (1.4)` \
  '497799835'  `# Xcode (10.0)` \
; do
  mas install $APP
done

open /Applications/1Password.app
enter_to_continue "Please install 1password browser plugins and setup sync with dropbox"
confirm_to_continue "Have you installed the 1password browser plugins?"

open /Applications/Reeder.app
enter_to_continue "Please log into feedbin with Reeder"
confirm_to_continue "Have you logged into Feedbin with Reeder?"

open /Applications/Spark.app
enter_to_continue "Please log into your email in Spark (rata, doba, jason-gidgidonihah, jason.g, gid-gmail, icloud, cruxconnect"
confirm_to_continue "Have you logged into email in Spark?"

open /Applications/Pocket.app
enter_to_continue "Please log into Pocket"
confirm_to_continue "Have you logged into Pocket?"

open /Applications/Tweetbot.app
enter_to_continue "Please log into Tweetbot"
confirm_to_continue "Have you logged into Tweetbot?"


# Request assistive access for terminal (silly way of doing so, but it works)
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

# Enable Wipr Safari Extensions
osascript -e '
tell application "Safari" to activate

tell application "System Events"
    click menu bar item "Safari" of menu bar 1 of application process "Safari"
    click menu item 4 of menu 1 of menu bar item "Safari" of menu bar 1 of application process "Safari"
    click UI element "Extensions" of toolbar 1 of window 1 of application process "Safari"

    repeat with i from 1 to 3
        set theGroup to "Wipr Part 2" -- & i
        click checkbox 1 of group i of list 1 of UI element 1 of scroll area 1 of group 1 of group 1 of window "Extensions" of application process "Safari"
    end repeat
end tell
'
confirm_to_continue "Have you set up wipr's blocking in Safari?"
