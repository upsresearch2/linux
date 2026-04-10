#!/bin/bash

clear
echo "=== Ubuntu Shell Practice Lab ==="
echo

# Helper pause function
pause() {
  echo
  read -p "👉 Press Enter to continue..."
  echo
}

echo "📁 Step 1: Navigation"
pwd
pause

ls
pause

echo "👉 Try yourself: run 'ls -l' and 'ls -a' in another terminal"
pause

echo "📂 Step 2: Creating directories"
mkdir practice_dir
ls
pause

cd practice_dir
pwd
pause

echo "📄 Step 3: Creating files"
touch file1.txt file2.txt file3.txt
ls
pause

echo "✏️ Step 4: Writing to a file"
echo "Hello World" > file1.txt
cat file1.txt
pause

echo "➕ Append text"
echo "Learning Bash" >> file1.txt
cat file1.txt
pause

echo "📋 Step 5: Copying and moving"
cp file1.txt copy.txt
ls
pause

mv copy.txt moved.txt
ls
pause

echo "🗑️ Step 6: Deleting files"
rm file2.txt
ls
pause

echo "🔍 Step 7: Searching"
echo "apple" > fruits.txt
echo "banana" >> fruits.txt
echo "cherry" >> fruits.txt

grep "banana" fruits.txt
pause

echo "🔁 Step 8: Loops"
for item in apple banana cherry; do
  echo "I like $item"
done
pause

echo "🧮 Step 9: Variables"
name="Alex"
echo "Hello $name"
pause

echo "❓ Step 10: Conditionals"
number=5
if [ $number -gt 3 ]; then
  echo "Number is greater than 3"
fi
pause

echo "📦 Step 11: Permissions"
ls -l
pause

echo "👉 Try yourself: chmod +x file1.txt"
pause

echo "🌍 Step 12: Environment"
echo $HOME
echo $PATH
pause

echo "🧹 Cleanup (optional)"
echo "This will remove practice_dir"
read -p "Type 'yes' to delete it: " confirm

if [ "$confirm" = "yes" ]; then
  cd ..
  rm -r practice_dir
  echo "Deleted."
else
  echo "Kept for practice 👍"
fi

echo
echo "🎉 Done! You just practiced core Linux shell skills."