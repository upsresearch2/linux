#!/bin/bash

# ===============================================================================
# NETWORK SERVICES & SERVER ADMINISTRATION
# Save as: network_v2.sh | Execute with: ./network_v2.sh
# ===============================================================================

pause() {
    echo -e "\n\033[0;32m[Press Enter to continue...]\033[0m"
    read
    clear
}

clear
echo "Starting Advanced Network Services Study..."
sleep 1

# -------------------------------------------------------------------------------
# 1. DHCP & BIND DNS CONFIGURATION
# -------------------------------------------------------------------------------
echo "--- 1. DHCP & DNS CONFIGURATION ---"

# DHCP Configuration
echo "Exercise: Viewing DHCP configuration (IPv4)"
echo "Path: /etc/dhcp/dhcpd.conf"
cat /etc/dhcp/dhcpd.conf 2>/dev/null || echo "Note: DHCP server (isc-dhcp-server) not installed."

# BIND DNS Configuration
echo -e "\nExercise: Viewing BIND DNS configuration"
echo "Path: /etc/bind/named.conf"
cat /etc/bind/named.conf 2>/dev/null || echo "Note: BIND9 DNS server not installed."

pause

# -------------------------------------------------------------------------------
# 2. DNS RECORD TYPES (Querying linux.org)
# -------------------------------------------------------------------------------
echo "--- 2. DNS RECORD TYPES ---"

# A Record: Maps domain to IPv4 address
echo "A Record (IPv4 Address):"
dig +short linux.org A

# MX Record: Mail Exchanger (where email is sent)
echo -e "\nMX Record (Mail Servers):"
dig +short linux.org MX

# NS Record: Nameservers authoritative for the zone
echo -e "\nNS Record (DNS Servers):"
dig +short linux.org NS

# TXT Record: Text records (often used for security/SPF)
echo -e "\nTXT Record (Security/Verification):"
dig +short linux.org TXT

pause

# -------------------------------------------------------------------------------
# 3. APACHE WEB SERVER
# -------------------------------------------------------------------------------
echo "--- 3. APACHE2 MANAGEMENT ---"

if ! command -v apache2 &> /dev/null; then
    echo "Apache2 is NOT installed."
    echo "Run these commands to install and start it:"
    echo "  sudo apt update"
    echo "  sudo apt install apache2"
    echo "  sudo systemctl start apache2.service"
else
    echo "Apache2 found. Attempting to start service..."
    echo "Command: sudo systemctl start apache2.service"
    sudo systemctl start apache2.service 2>/dev/null || echo "Note: Use sudo to start services."
    systemctl is-active apache2.service
fi

pause

# -------------------------------------------------------------------------------
# 4. SAMBA & POSTGRESQL
# -------------------------------------------------------------------------------
echo "--- 4. DATABASE & FILE SHARING ---"

# nmblookup: Used to lookup NetBIOS names (Samba)
echo "Exercise: nmblookup (NetBIOS Name Resolution)"
echo "Command: nmblookup localhost"
nmblookup localhost 2>/dev/null || echo "Note: 'samba-common-bin' not installed."

# PostgreSQL: Showing database status and version
echo -e "\nExercise: PostgreSQL Status"
psql --version 2>/dev/null || echo "Postgres client (psql) not installed."
systemctl status postgresql --no-pager 2>/dev/null || echo "Postgres service not running."

echo -e "\n--- Study Complete! ---"