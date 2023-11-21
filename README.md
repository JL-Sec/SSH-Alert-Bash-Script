# SSH Alert Bash Script

This Bash script monitors the SSH log file (`/var/log/auth.log` by default) for various SSH-related events and sends desktop notifications using `notify-send` when specific conditions are met. The script is designed to provide alerts for new SSH connections, closed sessions, failed login attempts, and multiple failed login attempts.

![Alert Screenshot](./Screenshot/SSH_Alert_Screenshot.png?raw=true "SSH Alert Screenshot")

## Features

- **New SSH Connection (Password Authentication):**
  - Notifies when a new SSH connection is made using password authentication.
  - Displays the username and IP address of the connected user.

- **New SSH Connection (Key Authentication):**
  - Notifies when a new SSH connection is made using key authentication.
  - Displays the username and IP address of the connected user.

- **SSH Session Closed:**
  - Notifies when an SSH session is closed.
  - Displays the username associated with the closed session.

- **Failed Logon Attempt:**
  - Notifies when there is a failed logon attempt (password authentication).
  - Displays the username and IP address associated with the failed attempt.
  - Uses a critical notification to highlight the importance of the event.

- **Multiple Failed Logon Attempts:**
  - Notifies when there are multiple failed logon attempts.
  - Displays the IP address associated with the multiple failed attempts.

## Prerequisites

- This script assumes the SSH log file is located at `/var/log/auth.log`. If your system uses a different location, update the `file_path` variable accordingly.

## Usage

1. Ensure the script has execute permissions: `chmod +x ssh_alert.sh`
2. Run the script: `./ssh_alert.sh`

The script will continuously monitor the SSH log file and display notifications when relevant events occur. Adjust the target strings and customize notification messages based on your preferences.

**Note:** The effectiveness of desktop notifications may vary depending on the desktop environment and notification system in use. Ensure that the `notify-send` command is available and properly configured on your system.

