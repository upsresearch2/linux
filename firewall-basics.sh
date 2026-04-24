#!/bin/bash

# Simple Firewall (UFW) Learning Script for Ubuntu
# This script demonstrates basic firewall concepts safely.
# NOTE: You may be prompted for your password (sudo required).

# Accessible colors (high contrast)
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
RESET='\033[0m'

pause() {
  echo -e "${YELLOW}\n--- Press ENTER to continue to the next section ---${RESET}"
  read
}

run_cmd() {
  echo -e "${CYAN}\n$ $1${RESET}"
  eval "$1"
}

echo -e "${GREEN}Welcome! This script introduces firewall basics using UFW on Ubuntu.${RESET}"
echo -e "${RED}Tip: If you're connected via SSH, be careful when enabling firewalls!${RESET}"
pause

#############################################
# SECTION 1: What is a Firewall & Check UFW
#############################################
echo -e "${GREEN}SECTION 1: Checking UFW installation and status${RESET}"

run_cmd "sudo ufw status verbose"

echo -e "\nUFW is a simple firewall tool that controls incoming/outgoing traffic."

pause

#############################################
# SECTION 2: Enable Firewall
#############################################
echo -e "${GREEN}SECTION 2: Enabling the firewall${RESET}"

echo -e "${RED}If you're using SSH, ensure SSH access is allowed before enabling!${RESET}"

run_cmd "sudo ufw allow OpenSSH"
run_cmd "sudo ufw enable"

run_cmd "sudo ufw status"

pause

#############################################
# SECTION 3: Allowing Traffic
#############################################
echo -e "${GREEN}SECTION 3: Allowing specific traffic${RESET}"

echo -e "We will allow HTTP (port 80) traffic."

run_cmd "sudo ufw allow 80/tcp"

echo -e "\nYou can also allow by service name:"
run_cmd "sudo ufw allow http"

run_cmd "sudo ufw status numbered"

pause

#############################################
# SECTION 4: Denying Traffic
#############################################
echo -e "${GREEN}SECTION 4: Denying traffic${RESET}"

echo -e "We will deny traffic on port 8080."

run_cmd "sudo ufw deny 8080/tcp"

run_cmd "sudo ufw status numbered"

pause

#############################################
# SECTION 5: Deleting Rules
#############################################
echo -e "${GREEN}SECTION 5: Deleting firewall rules${RESET}"

echo -e "We will remove the HTTP rule we added earlier."

echo -e "You can delete by rule number (shown above)."
echo -e "Example: sudo ufw delete <number>"

run_cmd "sudo ufw delete allow 80/tcp 2>/dev/null"
run_cmd "sudo ufw delete allow http 2>/dev/null"

run_cmd "sudo ufw status numbered"

pause

#############################################
# SECTION 6: Default Policies
#############################################
echo -e "${GREEN}SECTION 6: Default policies${RESET}"

echo -e "Set default behavior for incoming/outgoing traffic."

run_cmd "sudo ufw default deny incoming"
run_cmd "sudo ufw default allow outgoing"

run_cmd "sudo ufw status verbose"

pause

#############################################
# SECTION 7: Logging
#############################################
echo -e "${GREEN}SECTION 7: Enabling logging${RESET}"

run_cmd "sudo ufw logging on"

echo -e "\nLogs can help troubleshoot firewall behavior."

pause

#############################################
# SECTION 8: Cleanup
#############################################
echo -e "${GREEN}SECTION 8: Cleanup${RESET}"

echo -e "Restoring a simple, safe configuration."

run_cmd "sudo ufw delete deny 8080/tcp 2>/dev/null"
run_cmd "sudo ufw delete allow OpenSSH 2>/dev/null"
run_cmd "sudo ufw delete allow 80/tcp 2>/dev/null"

echo -e "\nOptionally disable firewall (safe for local testing environments):"
run_cmd "sudo ufw disable"

echo -e "${GREEN}\nCleanup complete!${RESET}"
echo -e "${GREEN}You have learned basic firewall management with UFW.${RESET}"