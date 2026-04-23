#!/bin/bash

echo "==============================="
echo " TAR DEMO: CREATE, VIEW, UNTAR "
echo "==============================="
echo ""

# Step 1: Create a sample folder
echo "[Step 1] Creating folder: myfolder"
mkdir myfolder

# Step 2: Create example files
echo "[Step 2] Creating sample files inside myfolder"
echo "Hello World" > myfolder/file1.txt
echo "Linux is fun" > myfolder/file2.txt

# Step 3: Show contents of the folder
echo "[Step 3] Listing contents of myfolder"
ls myfolder/
echo ""

# Step 4: Create a compressed archive
echo "[Step 4] Creating archive: archive.tar.gz"
tar -czvf archive.tar.gz myfolder/
echo ""

# Step 5: Confirm archive exists
echo "[Step 5] Listing current directory"
ls
echo ""

# Step 6: View contents of archive (no extraction)
echo "[Step 6] Viewing contents of archive.tar.gz"
tar -tzvf archive.tar.gz
echo ""

# Step 7: Remove original folder (to prove extraction works)
echo "[Step 7] Removing original folder: myfolder"
rm -r myfolder
echo ""

# Step 8: Extract the archive
echo "[Step 8] Extracting archive.tar.gz"
tar -xzvf archive.tar.gz
echo ""

# Step 9: Verify extraction
echo "[Step 9] Listing contents after extraction"
ls myfolder/
echo ""

echo "✅ Demo complete!"