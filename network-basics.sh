#!/bin/bash
# ==========================================
# Network Basics Practice Script (Ubuntu)
# ==========================================
# This script demonstrates common networking
# commands with explanations and examples.
# Run with: bash network_basics.sh
# Some commands may require sudo privileges.
# ==========================================

echo "===== NETWORK BASICS SCRIPT START ====="

# ------------------------------------------
# 1. ifconfig (deprecated but still useful)
# ------------------------------------------
# Shows network interfaces and IP addresses
echo -e "\n[ifconfig] Display network interfaces:"
ifconfig 2>/dev/null || echo "ifconfig not installed. Try: sudo apt install net-tools"

# ------------------------------------------
# 2. dhclient
# ------------------------------------------
# Requests a new IP address from DHCP server
echo -e "\n[dhclient] (Example only - not executed automatically)"
echo "# sudo dhclient -v"
# Uncomment to run:
# sudo dhclient -v

# ------------------------------------------
# 3. ip addr
# ------------------------------------------
# Modern replacement for ifconfig
echo -e "\n[ip addr] Show IP addresses:"
ip addr

# ------------------------------------------
# 4. netplan
# ------------------------------------------
# Ubuntu network configuration system
echo -e "\n[netplan] Show config files:"
ls /etc/netplan

echo "# Example: sudo netplan apply"
# sudo netplan apply

# ------------------------------------------
# 5. nmcli
# ------------------------------------------
# NetworkManager CLI tool
echo -e "\n[nmcli] Show device status:"
nmcli device status

echo "# Example: nmcli connection show"

# ------------------------------------------
# 6. ping (Packet Internet Groper)
# ------------------------------------------
# Tests connectivity to another host
echo -e "\n[ping] Test connectivity to google.com:"
ping -c 4 google.com

# ------------------------------------------
# 7. whois
# ------------------------------------------
# Lookup domain registration info
echo -e "\n[whois] Lookup example.com:"
whois example.com 2>/dev/null || echo "whois not installed. Try: sudo apt install whois"

# ------------------------------------------
# 8. hostname
# ------------------------------------------
# Shows or sets system hostname
echo -e "\n[hostname] Display system hostname:"
hostname

# ------------------------------------------
# 9. View /etc/hosts
# ------------------------------------------
echo -e "\n[/etc/hosts] Local DNS mappings:"
cat /etc/hosts

# ------------------------------------------
# 10. route
# ------------------------------------------
# Displays routing table
echo -e "\n[route] Routing table:"
route -n 2>/dev/null || echo "route not installed. Try: sudo apt install net-tools"

# ------------------------------------------
# 11. traceroute
# ------------------------------------------
# Shows path packets take to a host
echo -e "\n[traceroute] Trace route to google.com:"
traceroute google.com 2>/dev/null || echo "traceroute not installed. Try: sudo apt install traceroute"

# ------------------------------------------
# 12. View /etc/services
# ------------------------------------------
echo -e "\n[/etc/services] Known ports/services:"
head -n 20 /etc/services

# ------------------------------------------
# 13. inetd / xinetd
# ------------------------------------------
# Older service managers (rarely used now)
echo -e "\n[inetd/xinetd] Check if installed:"
which inetd || echo "inetd not installed"
which xinetd || echo "xinetd not installed"

# ------------------------------------------
# 14. telnet
# ------------------------------------------
# Test connectivity to a port
echo -e "\n[telnet] Example (not executed):"
echo "# telnet google.com 80"

# ------------------------------------------
# 15. ssh
# ------------------------------------------
# Secure remote login
echo -e "\n[ssh] Example (not executed):"
echo "# ssh user@hostname"

# ------------------------------------------
# 16. View SSH server config
# ------------------------------------------
echo -e "\n[/etc/ssh/sshd_config] SSH server config (first 20 lines):"
head -n 20 /etc/ssh/sshd_config 2>/dev/null || echo "SSH server may not be installed"

# ------------------------------------------
# 17. Install VNC Server
# ------------------------------------------
echo -e "\n[VNC Server Installation Example]:"
echo "# sudo apt update"
echo "# sudo apt install tigervnc-standalone-server tigervnc-common"

# ------------------------------------------
# 18. Run VNC Server
# ------------------------------------------
echo -e "\n[Run VNC Server Example]:"
echo "# vncserver"
echo "# vncserver -kill :1"

# ------------------------------------------
echo -e "\n===== SCRIPT COMPLETE ====="