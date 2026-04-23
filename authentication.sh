#!/bin/bash

# ===============================================================================
# UBUNTU SYSTEM SECURITY & AUTHENTICATION STUDY SCRIPT
# Focusing on PAM (Pluggable Authentication Modules) and Sudo Privileges.
# ===============================================================================

pause() {
    echo -e "\n\033[0;31m[Press Enter to continue to the next security topic...]\033[0m"
    read
    clear
}

clear
echo "Starting System Security Study Session..."
sleep 1

# -------------------------------------------------------------------------------
# 1. PAM (PLUGGABLE AUTHENTICATION MODULES) OVERVIEW
# -------------------------------------------------------------------------------
echo "--- 1. PAM CONFIGURATION DIRECTORY ---"

# PAM is a framework that allows admins to choose how applications authenticate users
# without rewriting the applications themselves.
echo "Command: ls /etc/pam.d/"
ls /etc/pam.d/
echo -e "\nNote: Each file here represents a service (ssh, login, sudo) that uses PAM."

pause

# -------------------------------------------------------------------------------
# 2. THE FOUR MAIN PAM MODULE TYPES
# -------------------------------------------------------------------------------
echo "--- 2. THE FOUR STACKABLE MODULE TYPES ---"

# 2.1 AUTH (Authentication): Verifies who the user is (usually password prompt).
echo "Exercise: Viewing 'common-auth' (The identity check phase)"
echo "Command: cat /etc/pam.d/common-auth"
cat /etc/pam.d/common-auth | grep -v '^#' | head -n 10

# 2.2 ACCOUNT: Checks if the user is allowed to log in (e.g., account expired? time of day?)
echo -e "\nExercise: Viewing 'common-account' (The authorization phase)"
echo "Command: cat /etc/pam.d/common-account"
cat /etc/pam.d/common-account | grep -v '^#'

# 2.3 PASSWORD: Handles password changes and complexity rules.
echo -e "\nExercise: Viewing 'common-password' (The update phase)"
echo "Command: cat /etc/pam.d/common-password"
cat /etc/pam.d/common-password | grep -v '^#'

# 2.4 SESSION: Sets up the environment (mounting folders, logging, limits).
echo -e "\nExercise: Viewing 'common-session' (The environment setup phase)"
echo "Command: cat /etc/pam.d/common-session"
cat /etc/pam.d/common-session | grep -v '^#'

pause

# -------------------------------------------------------------------------------
# 3. PASSWORD POLICY & SUDOERS
# -------------------------------------------------------------------------------
echo "--- 3. POLICIES & PRIVILEGES ---"

# Re-checking Password Policy for specific complexity modules (like pam_pwquality)
echo "Exercise: Checking password complexity configuration"
cat /etc/pam.d/common-password | grep "pam_unix.so"

# Checking the sudoers file: Defines who can run commands as root.
# We use tail -5 to see the default group permissions (usually %sudo).
echo -e "\nExercise: Viewing the end of the sudoers file"
echo "Command: sudo tail -5 /etc/sudoers"
sudo tail -5 /etc/sudoers 2>/dev/null || echo "[Note: sudo access required to view /etc/sudoers]"

echo -e "\n--- Security Study Complete ---"