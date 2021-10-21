#!/bin/sh

# Display a message using Dialog (must be installed first manually or via policy)
dialog --title "Hear ye, hear ye" \
--icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/Notifications.icns" \
--message "Did you know that Dialog is suuuuper easy to use?" \
--timer 10 \
--button1text "Yes" \
--button2text "Not Yet"

# Get the return code from Dialog and create a "notification process" if the user clicks "Yes"
case $? in
	0) # User clicked "Yes"
		echo "User clicked Yes"
		# Copy the sleep binary to /tmp (with a new name)
		cp /bin/sleep /tmp/admin_notify_user_clicked_yes
		# Launch the newly created "sleep" binary
		/tmp/admin_notify_user_clicked_yes 300 &
		;;
	2) # User clicked "Not Yet"
		echo "User clicked Not Yet"
		;;
	4) # Timer timed out
		echo "User didn't make a choice"
		;;
	*)  # Unknown return code
		echo "Return code from Dialog was $?, don't know what to do"
		;;
esac