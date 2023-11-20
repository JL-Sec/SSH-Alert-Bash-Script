#!/bin/bash


file_path="/var/log/auth.log"

# Target strings that are searched for in log file.

target_string="sshd"
target_string_2="Accepted password for"
target_string_3="Accepted publickey for"
target_string_4="session closed for"
target_string_5="Failed password for"
target_string_6="more authentication failures"

# Get the initial size of the file
current_position=$(stat -c %s "$file_path")

while true; do
    # Get new data appended to the file since the last check
    new_data=$(tail -c +$current_position "$file_path")

    if [ -n "$new_data" ]; then
        # Check each line for the target string

# Check for new opened sessions (PASSWORD AUTH)
        while IFS= read -r line; do
	    if [[ $line == *"$target_string"* && $line == *"$target_string_2"* ]]; then
	notify-send "SSH ALERT --- New SSH Connection" "<b>User:</b> $(echo $line | awk '{print $9}')	<b>IP:</b> $(echo $line | awk '{print $11}')"
    
# Check for new opened sessions (KEY AUTH)
	    elif [[ $line == *"$target_string"* && $line == *"$target_string_3"* ]]; then
#	notify-send "SSH ALERT" "<b>New SSH Connection	User:</b> $(echo $line | awk '{print $9}')\n  <b>IP:</b>$(echo $line | awk '{print $11}')"
notify-send "SSH ALERT --- New SSH Connection" "<b>User:</b> $(echo $line | awk '{print $9}')	<b>IP:</b> $(echo $line | awk '{print $11}')"

# check for new closed sessions

	    elif [[ $line == *"$target_string"* && $line == *"$target_string_4"* ]]; then
	notify-send "SSH ALERT --- SSH Session Closed" "<b>User:</b>  $(echo $line | awk '{print $11}' | awk -F '[()]' '{print $1}')"

# check for failed logon attempt (password failure)

	    elif [[ $line == *"$target_string"* && $line == *"$target_string_5"* ]]; then
	notify-send -u critical "SSH ALERT --- Failed Logon Attempt" "<b>User</b>: $(echo $line | awk '{print $9}')  <b>IP:</b> $(echo $line | awk '{print $11}')"

# check for multiple failed logon attempts

	    elif [[ $line == *"$target_string"* && $line == *"$target_string_6"* ]]; then
		    notify-send "SSH ALERT --- Multiple failed logon attempts"	"<b>IP:</b> $(echo $line | awk '{print $16}' | awk -F '[=]' '{print $2}')"
	    fi

        done <<< "$new_data"

        # Update the current position in the file
        current_position=$(stat -c %s "$file_path")
    fi

    # Introduce a delay before the next check
    sleep 1
done
