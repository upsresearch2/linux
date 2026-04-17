#!/bin/bash

# ===============================================================================
# LINUX SYSTEM ADMINISTRATION: BOOT, DAEMONS, AND GUI STACK
# Save as: sysadmin_v2.sh | Execute with: ./sysadmin_v2.sh
# ===============================================================================

pause() {
    echo -e "\n\033[0;33m[Press Enter to continue to the next concept...]\033[0m"
    read
    clear
}

clear
echo "Initializing System Admin Study Session..."
sleep 1

# -------------------------------------------------------------------------------
# 1. SYSTEM IDENTIFICATION & BOOTLOADERS (GRUB2)
# -------------------------------------------------------------------------------
echo "--- 1. OS & BOOTLOADER ---"

# Display distribution name, version, and ID
cat /etc/os-release

# Verify GRUB version (Version 2.xx confirms GRUB 2)
echo -e "\nChecking GRUB version:"
grub-install --version

# View GRUB configuration (Look for GRUB_TIMEOUT here)
echo -e "\nViewing GRUB defaults (/etc/default/grub):"
cat /etc/default/grub | grep -E "TIMEOUT|DISTRIBUTOR"

# Note: To reinstall GRUB UEFI packages (requires sudo):
# sudo apt-get install --reinstall grub-efi

pause

# -------------------------------------------------------------------------------
# 2. RUNLEVELS & LEGACY INIT (SysV)
# -------------------------------------------------------------------------------
echo "--- 2. RUNLEVELS & INIT ---"

# Displays current runlevel (the type/number of active daemons)
echo "Current runlevel:"
runlevel

# View default runlevel configuration (Legacy SysV)
echo -e "\nChecking /etc/inittab (identifies default runlevel):"
cat /etc/inittab 2>/dev/null || echo "inittab not found (common on Systemd systems)"

# View Runtime Configuration Scripts for Runlevel 5 (Graphical)
echo -e "\nListing RC scripts for runlevel 5:"
ls /etc/rc.d/rc5.d 2>/dev/null || ls /etc/rc5.d 2>/dev/null | head -n 5

pause

# -------------------------------------------------------------------------------
# 3. SERVICE MANAGEMENT (SYSTEMD & CRON)
# -------------------------------------------------------------------------------
echo "--- 3. SYSTEMD & SCHEDULING ---"

# List your scheduled cron jobs
echo "User cron jobs (crontab -l):"
crontab -l 2>/dev/null || echo "No crontabs for $(whoami)"

# Systemd: Start/Stop/Restart/Status of daemons
echo -e "\nChecking cron status via systemctl:"
systemctl status cron --no-pager 2>/dev/null || systemctl status crond --no-pager

# List all units currently executing in memory
echo -e "\nDisplaying active units (systemctl):"
systemctl | head -n 10

# List ALL services (loaded or not)
echo -e "\nDisplaying all possible services (systemctl -a):"
systemctl -a --type=service | head -n 10

# Analyze system boot performance
echo -e "\nSystemd boot analysis:"
systemd-analyze

pause

# -------------------------------------------------------------------------------
# 4. UNIT FILES & GUI STACK
# -------------------------------------------------------------------------------
echo "--- 4. UNIT FILES & GUI ---"

# View contents of specific unit files
echo "Viewing graphical.target unit:"
cat /lib/systemd/system/graphical.target | head -n 5

# List other unit files in the system directory
echo -e "\nListing custom systemd units (/etc/systemd/system/):"
ls /etc/systemd/system/ | head -n 10

# Check GUI protocol: X11 or Wayland
echo -e "\nCurrent GUI Session Type:"
echo $XDG_SESSION_TYPE

# Note: GUI Stack Flow
# Apps -> Desktop Env (GNOME) -> Window Manager -> Display Server (X11/Wayland) -> Drivers

pause

# -------------------------------------------------------------------------------
# 5. TIME, EPOCH, AND LOCALE
# -------------------------------------------------------------------------------
echo "--- 5. TIME & LOCALE ---"

# Epoch: Seconds since Jan 1, 1970 (used by kernel)
echo "Current Epoch time (date +%s):"
date +%s

# Display system time and timezone info
echo -e "\nSystem time info (timedatectl):"
timedatectl

# View timezone and local time configuration
echo -e "\nTimezone files:"
cat /etc/timezone 2>/dev/null
ls -l /etc/localtime

# Display locale (language and regional settings)
echo -e "\nSystem Locale (localectl):"
localectl

# Example command to set time (Commented out to prevent system clock changes):
# sudo timedatectl set-time "2023-08-20 08:16:00"

echo -e "\n--- Script Complete ---"