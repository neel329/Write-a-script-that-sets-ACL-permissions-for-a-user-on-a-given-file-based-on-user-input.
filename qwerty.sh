#!/bin/bash

# Ask for the file path
echo "Enter the file path:"
read file_path

# Check if the file exists
if [ ! -f "$file_path" ]; then
  echo "File does not exist. Exiting."
  exit 1
fi

# Ask for the username
echo "Enter the username to set ACL for:"
read username

# Ask for the permission (e.g., rwx, r--, rw-)
echo "Enter the permission to set (e.g., rwx, r--, rw-):"
read permission

# Validate permission format (should be a combination of r, w, x)
if ! [[ "$permission" =~ ^[rwx-]{3}$ ]]; then
  echo "Invalid permission format. Please enter a valid combination of r, w, and x (e.g., rwx, r--, rw-)."
  exit 1
fi

# Set ACL for the user on the specified file
setfacl -m u:$username:$permission $file_path

# Verify if the ACL was set successfully
if [ $? -eq 0 ]; then
  echo "ACL permission '$permission' set for user '$username' on '$file_path'."
else
  echo "Failed to set ACL permission. Exiting."
  exit 1
fi
