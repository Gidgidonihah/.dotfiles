#!/bin/bash

# Install Apps from Mac App Store
echo "🥤   Installing MAS Apps"

enter_to_continue "Press sign in to the mac app store."
open /Applications/App\ Store.app
confirm_to_continue "Have you signed into the mac app store?"

echo "Installing from Mac App Store"
for APP in \
  '693112260'  `# Sim Daltonism (2.0.2)` \
  '1153157709' `# Speedtest (1.5)` \
  '498944723'  `# JPEGmini (2.2.1)` \
  '880001334'  `# Reeder (3.2.1)` \
  '429449079'  `# Patterns (1.1.2)` \
  '407963104'  `# Pixelmator (3.7.5)` \
  '405772121'  `# LittleIpsum (2.0.6)` \
  '1384080005' `# Tweetbot (3.1)` \
  '443987910'  `# 1Password (6.8.8)` \
  '417602904'  `# CloudApp (4.4.2)` \
  '444425546'  `# BarTunes (1.2)` \
  '1176895641' `# Spark (2.0.13)` \
  '427475982'  `# BreakTime (2.5.2)` \
  '568494494'  `# Pocket (1.8.1)` \
  '419330170'  `# Moom (3.2.11)` \
  '413965349'  `# Soulver (2.6.8)` \
  '803453959'  `# Slack (3.3.2)` \
  '489094439'  `# iTeleport (6.1.8)` \
  '411246225'  `# Caffeine (1.1.1)` \
  '411643860'  `# DaisyDisk (4.6.5)` \
  '409203825'  `# Numbers (5.2)` \
  '409183694'  `# Keynote (8.2)` \
  '635124250'  `# Delicious Library 3 (3.8.2)` \
  '1320666476' `# Wipr (1.4)` \
  '497799835'  `# Xcode (10.0)` \
; do
  mas install $APP
done

enter_to_continue "Please install 1password browser plugins and setup sync with dropbox"
open /Applications/1Password.app
confirm_to_continue "Have you installed the 1password browser plugins?"

enter_to_continue "Please log into feedbin with Reeder"
open /Applications/Reeder.app
confirm_to_continue "Have you logged into Feedbin with Reeder?"

enter_to_continue "Please log into Slack"
open /Applications/Slack.app
confirm_to_continue "Have you logged into Slack?"

enter_to_continue "Please log into your email in Spark"
open /Applications/Spark.app
confirm_to_continue "Have you logged into email in Spark?"

enter_to_continue "Please log into Pocket"
open /Applications/Pocket.app
confirm_to_continue "Have you logged into Pocket?"

enter_to_continue "Please log into Tweetbot"
open /Applications/Tweetbot.app
confirm_to_continue "Have you logged into Tweetbot?"

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
