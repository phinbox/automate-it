#!/bin/sh

# This function uses "Pushover" (pushover.net) to send a notification. Replace APP_TOKEN and USER_TOKEN with your own values.
pushover() {
	APP_TOKEN='loremipsumdolorsitamet'
	USER_TOKEN='consecteturadipsicingelit'
	TITLE="$1"
	MESSAGE="$2"
	curl 'https://api.pushover.net/1/messages.json' -X POST -d "token=$APP_TOKEN&user=$USER_TOKEN&message=$MESSAGE&title=$TITLE"
}

# Get the current logged in user
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )


# Display a notification to the user using JamfHelper
/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
	-windowType utility \
	-title "Tick...tock...tick...tock..." \
	-heading "Here you see a macOS clock." \
	-description \
"One, two, install homebrew,
Three, four, script some more,
Five, Six, not just Linux,
Seven, Eight, isn't automation great!" \
	-icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/Clock.icns" \
	-iconSize 256 \
	-button1 "OK" \
	-defaultButton 1 \
	-countdown \
	-timeout 10 \
	-alignCountdown right

# All done, send notification using Pushover
pushover "Jamf Pro: AutomaClock" "User $loggedInUser has just clocked out."