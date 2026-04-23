#!/bin/bash

# ===============================================================================
# OPENSSL ENCRYPTION & SECURITY STUDY SCRIPT
# This script demonstrates symmetric/asymmetric encryption and hashing.
# ===============================================================================

pause() {
    echo -e "\n\033[0;32m[Press Enter to continue...]\033[0m"
    read
    clear
}

clear
echo "Starting OpenSSL Encryption Study Session..."
sleep 1

# -------------------------------------------------------------------------------
# 1. INSTALLATION CHECK
# -------------------------------------------------------------------------------
echo "--- 1. ENVIRONMENT SETUP ---"

# Check if openssl command exists in the system path
if ! command -v openssl &> /dev/null; then
    echo "OpenSSL could not be found."
    echo "To install it, please run the following commands:"
    echo "  sudo apt update"
    echo "  sudo apt install openssl"
    exit 1
else
    echo "Command: openssl version"
    openssl version
    echo "OpenSSL is installed. Proceeding..."
fi

pause

# -------------------------------------------------------------------------------
# 2. SYMMETRIC ENCRYPTION (Shared Key)
# -------------------------------------------------------------------------------
echo "--- 2. SYMMETRIC ENCRYPTION ---"

# Create dummy data
echo "echo 'secret data' > file.txt"
echo "secret data" > file.txt

# AES-256-CBC (High Security)
# -pbkdf2 is added to satisfy modern OpenSSL security requirements
echo -e "\nCommand: openssl enc -aes-256-cbc -salt -in file.txt -out file.enc"
openssl enc -aes-256-cbc -salt -in file.txt -out file.enc -k pass123 -pbkdf2
echo "Result: Encrypted file 'file.enc' created."

# Decryption
echo -e "\nCommand: openssl enc -d -aes-256-cbc -in file.enc -out file_decrypted.txt"
openssl enc -d -aes-256-cbc -in file.enc -out file_decrypted.txt -k pass123 -pbkdf2
echo "Decrypted Content:"
cat file_decrypted.txt

# Demonstrating different bit-lengths and algorithms
echo -e "\nCommand: openssl enc -aes-128-cbc -in file.txt -out file128.enc"
openssl enc -aes-128-cbc -in file.txt -out file128.enc -k pass -pbkdf2

echo "Command: openssl enc -aes-192-cbc -in file.txt -out file192.enc"
openssl enc -aes-192-cbc -in file.txt -out file192.enc -k pass -pbkdf2

echo "Command: openssl enc -des3 -in file.txt -out file_des.enc"
openssl enc -des3 -in file.txt -out file_des.enc -k pass -pbkdf2

# List all supported ciphers
echo -e "\nCommand: openssl enc -ciphers"
openssl enc -ciphers | head -n 5 # Showing only top 5 for brevity

pause

# -------------------------------------------------------------------------------
# 3. DATA INTEGRITY (Hashing)
# -------------------------------------------------------------------------------
echo "--- 3. HASHING (DIGESTS) ---"

# SHA256 is the current standard for security
echo "Command: openssl dgst -sha256 file.txt"
openssl dgst -sha256 file.txt

# MD5 is used for legacy checksums (not security)
echo -e "\nCommand: openssl dgst -md5 file.txt"
openssl dgst -md5 file.txt

pause

# -------------------------------------------------------------------------------
# 4. ASYMMETRIC ENCRYPTION (Public/Private Keys)
# -------------------------------------------------------------------------------
echo "--- 4. RSA KEY GENERATION ---"

# Generate a private key
echo "Command: openssl genpkey -algorithm RSA -out private.pem"
openssl genpkey -algorithm RSA -out private.pem

# Extract the public key from the private key
echo -e "\nCommand: openssl rsa -pubout -in private.pem -out public.pem"
openssl rsa -pubout -in private.pem -out public.pem

echo -e "\nPublic key extracted to public.pem. You can share this with others."

# -------------------------------------------------------------------------------
# 5. CLEANUP
# -------------------------------------------------------------------------------
echo -e "\nCleaning up exercise files..."
rm file.txt file.enc file_decrypted.txt file128.enc file192.enc file_des.enc private.pem public.pem
echo "Done."