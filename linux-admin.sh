#!/bin/bash

# ===============================================================================
# LINUX SYSTEM ADMINISTRATION MASTER STUDY SCRIPT
# Covers: CUPS Printing, Journald Logging, and User/Group Management
# ===============================================================================

pause() {
    echo -e "\n\033[0;32m[Press Enter to continue to the next section...]\033[0m"
    read
    clear
}

clear
echo "Starting Unified System Administration Study Session..."
sleep 1

# -------------------------------------------------------------------------------
# 1. ADVANCED PRINTING (CUPS & LPD)
# -------------------------------------------------------------------------------
echo "--- 1. PRINTING INFRASTRUCTURE ---"

# lpstat -p: Shows the status (idle/enabled) of all printers
echo "Exercise: Viewing printer status (-p)"
lpstat -p 2>/dev/null || echo "No printers found."

# lpinfo -v: Lists available printer devices (USB, Network, etc.)
echo -e "\nExercise: Listing printer hardware devices"
lpinfo -v 2>/dev/null || echo "lpinfo: Access denied or not installed."

# head /etc/cups/cupsd.conf: View the start of the CUPS configuration
echo -e "\nExercise: Reading CUPS config header"
head -n 10 /etc/cups/cupsd.conf 2>/dev/null || echo "Cannot read cupsd.conf (try sudo)."

# Pipe example with error handling: Send to printer and check exit status ($?)
echo -e "\nExercise: cat file | lp with Error Handling"
echo "Admin Practice Document" > practice_print.txt
cat practice_print.txt | lp > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Success: Job sent to printer."
else
    echo "Error: Print job failed (check default printer)."
fi

pause

# -------------------------------------------------------------------------------
# 2. LOGGING ADMINISTRATION (JOURNALCTL)
# -------------------------------------------------------------------------------
echo "--- 2. SYSTEM LOGGING (JOURNALD) ---"

# journalctl -f | head: Follows logs but only shows the first few lines of the stream
# Note: Since -f is a continuous stream, head will close the pipe after N lines.
echo "Exercise: Following logs but capturing only the start (head)"
journalctl -f | head -n 5

# journalctl -b | tail: Shows the end of the logs from the current boot
echo -e "\nExercise: End of current boot logs"
journalctl -b --no-pager | tail -n 5

# journalctl -p err | tail: Filters for errors only, then shows the latest
echo -e "\nExercise: Latest system errors"
journalctl -p err --no-pager | tail -n 5

pause

# -------------------------------------------------------------------------------
# 3. USER MANAGEMENT (ADD, DELETE, MODIFY)
# -------------------------------------------------------------------------------
echo "--- 3. USER ADMINISTRATION ---"

# adduser: Interactive high-level tool to add users
echo "Exercise: Adding a user (Interactive)"
echo "Command: sudo adduser jon"

# usermod: Modify existing user account (e.g., adding to a secondary group)
echo -e "\nExercise: Modifying a user (usermod)"
echo "Command: sudo usermod -aG sudo jon   # Adds 'jon' to the sudo group (-a=append)"
echo "Command: sudo usermod -L jon        # Locks the account"

# deluser: Remove user accounts
echo -e "\nExercise: Deleting users"
echo "Command: sudo deluser jon               # Removes user but keeps home files"
echo "Command: sudo deluser --remove-home jon # Removes user AND their home directory"

# chage: Modify password expiration
echo -e "\nExercise: Password aging"
echo "Command: sudo chage -M 90 jon           # Set max password age to 90 days"

pause

# -------------------------------------------------------------------------------
# 4. GROUP MANAGEMENT & IDENTITY
# -------------------------------------------------------------------------------
echo "--- 4. GROUPS & IDENTITY ---"

# id: See current user identifiers
echo "Your Identity (id):"
id

# groupmod: Modify group attributes
echo -e "\nExercise: Modifying groups (groupmod)"
echo "Command: sudo groupmod -n newname oldname # Renames a group"
echo "Command: sudo groupmod -g 2000 mygroup    # Changes Group ID (GID)"

# Checking group membership files
echo -e "\nViewing /etc/group (last 5 lines):"
tail -n 5 /etc/group

# Cleanup
rm practice_print.txt
echo -e "\n--- Master Study Session Complete ---"