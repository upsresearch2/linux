#!/bin/bash

# ===============================================================================
# NETWORK & SYSTEM PERFORMANCE TROUBLESHOOTING
# This script covers networking, CPU, Memory, and Disk I/O monitoring.
# ===============================================================================

pause() {
    echo -e "\n\033[0;33m[Press Enter to continue to the next diagnostic tool...]\033[0m"
    read
    clear
}

# -------------------------------------------------------------------------------
# 1. PRE-FLIGHT CHECK (INSTALLATION)
# -------------------------------------------------------------------------------
clear
echo "Checking for required troubleshooting tools..."

REQUIRED_TOOLS=("tcpdump" "sysstat" "ioping" "iotop" "vmstat")
MISSING_TOOLS=()

for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        MISSING_TOOLS+=("$tool")
    fi
done

if [ ${#MISSING_TOOLS[@]} -ne 0 ]; then
    echo "The following tools are missing: ${MISSING_TOOLS[*]}"
    echo "To install them, run:"
    echo "  sudo apt update && sudo apt install tcpdump sysstat ioping iotop"
    exit 1
fi

echo "All tools found. starting diagnostics..."
sleep 1
clear

# -------------------------------------------------------------------------------
# 2. NETWORK CONNECTIVITY & PACKET ANALYSIS
# -------------------------------------------------------------------------------
echo "--- 1. NETWORK DIAGNOSTICS ---"

# ping: Checks connectivity to a host via ICMP Echo Requests
echo "Command: ping -c 4 google.com"
ping -c 4 google.com

# tcpdump: Captures and analyzes network traffic (Requires sudo)
# -c 5: Capture only 5 packets; -i any: Listen on all interfaces
echo -e "\nCommand: sudo tcpdump -c 5 -i any"
sudo tcpdump -c 5 -i any 2>/dev/null || echo "[Note: sudo required for tcpdump]"

pause

# -------------------------------------------------------------------------------
# 3. CPU & SYSTEM LOAD (uptime, top, mpstat, pidstat)
# -------------------------------------------------------------------------------
echo "--- 2. CPU & SYSTEM LOAD ---"

# uptime: Shows how long system is running and Load Average (1, 5, 15 mins)
echo "Command: uptime"
uptime

# top: Real-time dynamic view of system processes
echo -e "\nCommand: top (Batch mode, 1 iteration)"
top -b -n 1 | head -n 15

# mpstat: Displays CPU usage statistics (part of sysstat)
# -P ALL: Shows stats for every individual CPU core
echo -e "\nCommand: mpstat -P ALL 1 1"
mpstat -P ALL 1 1

# pidstat: Reports statistics for Linux tasks (processes)
# Shows CPU usage per process
echo -e "\nCommand: pidstat 1 1"
pidstat 1 1

pause

# -------------------------------------------------------------------------------
# 4. MEMORY & VIRTUAL MEMORY (free, vmstat)
# -------------------------------------------------------------------------------
echo "--- 3. MEMORY ANALYSIS ---"

# free: Displays amount of free and used memory in the system
# -m: Display in Megabytes; -h: Human-readable
echo "Command: free -h"
free -h

# vmstat: Reports virtual memory statistics (processes, memory, paging, block I/O)
# '1 3' means report every 1 second, 3 times total
echo -e "\nCommand: vmstat 1 3"
vmstat 1 3

pause

# -------------------------------------------------------------------------------
# 5. DISK I/O & LATENCY (iostat, iotop, ioping)
# -------------------------------------------------------------------------------
echo "--- 4. DISK I/O PERFORMANCE ---"

# iostat: Reports CPU and I/O statistics for devices and partitions
# -x: Extended statistics
echo "Command: iostat -x 1 1"
iostat -x 1 1

# iotop: Similar to top, but for Disk I/O (Requires sudo)
echo -e "\nCommand: sudo iotop -b -n 1"
sudo iotop -b -n 1 2>/dev/null || echo "[Note: sudo required for iotop]"

# ioping: Real-time disk latency (like ping, but for the hard drive)
echo -e "\nCommand: ioping -c 5 ."
ioping -c 5 .

pause

# -------------------------------------------------------------------------------
# 6. HISTORICAL DATA (sar)
# -------------------------------------------------------------------------------
echo "--- 5. HISTORICAL SYSTEM ACTIVITY ---"

# sar: Collects and reports system activity information
# sar -u: Displays CPU usage for the current day (if sysstat service is active)
echo "Command: sar -u"
sar -u 2>/dev/null || echo "sar: No historical data found (Check if sysstat service is running)."

echo -e "\nTroubleshooting script finished."