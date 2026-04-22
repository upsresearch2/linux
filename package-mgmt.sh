#!/bin/bash

# ===============================================================================
# LINUX ARCHIVING, COMPRESSION, AND PACKAGE MANAGEMENT
# ===============================================================================

pause() {
    echo -e "\n\033[0;34m[Press Enter to continue...]\033[0m"
    read
    clear
}

# PREPARATION: Create a practice directory and some files
mkdir -p archive_practice
echo "This is a large text file for testing compression." > archive_practice/file1.txt
echo "Repeating text... " | head -c 1000 >> archive_practice/file1.txt
cp archive_practice/file1.txt archive_practice/file2.txt

clear
echo "Starting Compression and Package Management Study Session..."
sleep 1

# -------------------------------------------------------------------------------
# 1. CLASSIC COMPRESSION (compress, gzip, bzip2, xz)
# -------------------------------------------------------------------------------
echo "--- 1. COMPRESSION UTILITIES ---"

# gzip: The most common Linux compression tool (.gz)
echo "Exercise: gzip (standard compression)"
gzip archive_practice/file1.txt
ls -l archive_practice/file1.txt.gz

# gunzip: Decompresses gzip files
gunzip archive_practice/file1.txt.gz

# bzip2: Slower than gzip but creates smaller files (.bz2)
echo -e "\nExercise: bzip2 and bzcat"
bzip2 archive_practice/file2.txt
bzcat archive_practice/file2.txt.bz2 | head -n 2  # bzcat: View file without decompressing
bunzip2 archive_practice/file2.txt.bz2

# xz: The modern standard for high-ratio compression (.xz)
echo -e "\nExercise: xz compression"
xz archive_practice/file1.txt
unxz archive_practice/file1.txt.xz   # Or use xz -d

# Legacy tools (compress/uncompress/zcat)
echo -e "\nNote: 'compress' (.Z) is legacy. Use 'zcat' to view .Z or .gz files."

pause

# -------------------------------------------------------------------------------
# 2. ARCHIVING (tar, zip, cpio)
# -------------------------------------------------------------------------------
echo "--- 2. ARCHIVING (GROUPING FILES) ---"

# tar: Tape Archive. The standard way to "bundle" directories.
# -c: create, -v: verbose, -f: filename, -z: compress with gzip
echo "Exercise: Creating a compressed tarball (.tar.gz)"
tar -cvzf my_archive.tar.gz archive_practice/
tar -tf my_archive.tar.gz  # -t: list contents

# zip/unzip: Windows-compatible archiving
echo -e "\nExercise: zip and unzip"
zip -r my_files.zip archive_practice/
unzip -l my_files.zip  # -l: list contents

# cpio: Copy In/Out. Often used for system backups and initramfs
echo -e "\nExercise: cpio (using find to pipe files)"
find archive_practice | cpio -ov > practice.cpio

pause

# -------------------------------------------------------------------------------
# 3. BACKUP & RECOVERY (dd, dump, restore)
# -------------------------------------------------------------------------------
echo "--- 3. BACKUP & RECOVERY ---"

# dd: Bit-for-bit disk duplicator
echo "Exercise: dd (Simulated disk clone)"
echo "Command: dd if=/dev/sda of=/dev/sdb bs=64K conv=noerror,sync"
# if=input file, of=output file

# dump/restore: Backup entire filesystems
echo -e "\nNote: 'dump' examines files on an ext2/3/4 filesystem and determines"
echo "which files need to be backed up to a 'restore' archive."

pause

# -------------------------------------------------------------------------------
# 4. COMPILING FROM SOURCE (make, configure)
# -------------------------------------------------------------------------------
echo "--- 4. COMPILING FROM SOURCE ---"

echo "The 'Classic' Installation Workflow:"
echo "1. ./configure  # Checks your system for dependencies and creates a Makefile."
echo "2. make         # Compiles the source code into binary using the Makefile."
echo "3. sudo make install # Copies the compiled binaries to system folders (/usr/local/bin)."

# ldd: List Dynamic Dependencies (shows which libraries a program needs)
echo -e "\nExercise: Checking dependencies of /bin/ls"
ldd /bin/ls

pause

# -------------------------------------------------------------------------------
# 5. PACKAGE MANAGEMENT (apt, dpkg, snap, dnf)
# -------------------------------------------------------------------------------
echo "--- 5. PACKAGE MANAGEMENT (Ubuntu/Debian Focus) ---"

# apt: The high-level CLI tool
echo "Common APT Commands:"
echo "- sudo apt update           # Refresh the local package index"
echo "- sudo apt-get install git   # Install a package"
echo "- sudo apt remove git        # Remove a package"
echo "- sudo add-apt-repository    # Add Third-party software sources (PPA)"

# dpkg: The low-level tool for .deb files
echo -e "\nExercise: Using dpkg to list installed files for a package"
dpkg -L coreutils | head -n 5

# snap: Universal Linux packages
echo -e "\nExercise: snap install"
echo "Command: sudo snap install vlc"

# aptitude: A Ncurses-based high-level interface for apt
# dnf/yum: The package managers for RHEL/CentOS/Fedora (equivalent to apt)
echo -e "\nNote: On Ubuntu, you use 'apt'. On Fedora/RHEL, you use 'dnf'."

# CLEANUP
rm -rf archive_practice my_archive.tar.gz my_files.zip practice.cpio
echo -e "\nStudy session complete!"