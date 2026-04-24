#!/bin/bash

# Simple Port Scanning Learning Script for Ubuntu
# Teaches basics of port scanning using nmap on localhost
# NOTE: Some commands require sudo privileges

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

echo -e "${GREEN}Welcome! This script introduces port scanning basics.${RESET}"
echo -e "${RED}Only scan systems you own or have permission to test.${RESET}"
pause

#############################################
# SECTION 1: What is Port Scanning
#############################################
echo -e "${GREEN}SECTION 1: Introduction${RESET}"

echo "Port scanning is used to discover open ports and services on a system."
echo "We will safely scan your own machine (localhost)."

pause

#############################################
# SECTION 2: Install nmap
#############################################
echo -e "${GREEN}SECTION 2: Installing nmap${RESET}"

run_cmd "sudo apt update"
run_cmd "sudo apt install -y nmap"

run_cmd "nmap --version"

pause

#############################################
# SECTION 3: Basic Scan
#############################################
echo -e "${GREEN}SECTION 3: Basic scan of localhost${RESET}"

run_cmd "nmap localhost"

echo -e "\nThis shows open ports on your machine."

pause

#############################################
# SECTION 4: Scan Specific Ports
#############################################
echo -e "${GREEN}SECTION 4: Scanning specific ports${RESET}"

run_cmd "nmap -p 22,80,443 localhost"

echo -e "\nThis scans only selected ports."

pause

#############################################
# SECTION 5: Service Detection
#############################################
echo -e "${GREEN}SECTION 5: Service detection${RESET}"

run_cmd "sudo nmap -sV localhost"

echo -e "\nThis attempts to identify services running on open ports."

pause

#############################################
# SECTION 6: Faster Scan
#############################################
echo -e "${GREEN}SECTION 6: Fast scan${RESET}"

run_cmd "nmap -F localhost"

echo -e "\nScans only common ports (faster)."

pause

#############################################
# SECTION 7: Scan a Range
#############################################
echo -e "${GREEN}SECTION 7: Scan a port range${RESET}"

run_cmd "nmap -p 1-1000 localhost"

echo -e "\nScans ports 1 through 1000."

pause

#############################################
# SECTION 8: Save Output
#############################################
echo -e "${GREEN}SECTION 8: Save scan results${RESET}"

run_cmd "nmap localhost -oN scan_results.txt"

echo -e "\nResults saved to scan_results.txt"

run_cmd "cat scan_results.txt"

pause

#############################################
# SECTION 9: Cleanup
#############################################
echo -e "${GREEN}SECTION 9: Cleanup${RESET}"

echo -e "Removing generated files."

run_cmd "rm -f scan_results.txt"

echo -e "${GREEN}\nCleanup complete!${RESET}"
echo -e "${GREEN}You have learned basic port scanning techniques.${RESET}"