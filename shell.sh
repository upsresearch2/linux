#!/bin/bash

# ===============================================================================
# THE INTERACTIVE BASH CLASSROOM
# This script executes commands and explains the syntax in real-time.
# ===============================================================================

# FUNCTION: pause
# Purpose: Clear the screen and wait for user input so you can read the output.
pause() {
    echo -e "\n\033[0;32m[Press Enter to continue to the next exercise...]\033[0m"
    read
    clear
}

clear
echo "Starting Linux Shell Command Study Session..."
sleep 1

# -------------------------------------------------------------------------------
# 1. REDIRECTION, STREAMS & LOGICAL OPERATORS
# -------------------------------------------------------------------------------
echo "--- SECTION 1: REDIRECTION & LOGIC ---"

# 1.1 Redirecting Standard Output (stdout) and Standard Error (stderr)
# '>' sends normal output to a file. '2>' sends error messages to a file.
ls /root > output.txt 2> error.txt
echo "Command: ls /root > output.txt 2> error.txt"
echo "Check error.txt (Expect 'Permission denied' if not root):"
cat error.txt # cat views the file content

# 1.2 Logical AND (&&) - Only runs the second command if the first succeeds.
# 1.3 Logical OR (||)  - Only runs the second command if the first fails.
echo -e "\nExercise: Logical Operators"
mkdir -p study_dir && echo "Success: Directory 'study_dir' created."
ls non_existent_file || echo "Failure: The file doesn't exist (This triggered the || logic)."

# 1.4 Escape Sequences
# '-e' enables interpretation of backslash escapes like \n (newline) and \t (tab).
echo -e "\nExercise: Escape Sequences"
echo -e "Line 1\n\tIndented Line 2 (using \\n and \\t)"
echo "Using backslashes to show \"quotes\" without ending the string."

pause

# -------------------------------------------------------------------------------
# 2. TEXT PROCESSING (tr, sed, awk, tee)
# -------------------------------------------------------------------------------
echo "--- SECTION 2: TEXT PROCESSING ---"

# 2.1 tr (Translate): Changes characters (here, lowercase to uppercase).
# 2.2 tee: Reads from stdin and writes to both standard output AND a file.
echo "learning linux" | tr 'a-z' 'A-Z' | tee transformed.txt
echo "Verified file content using cat:"
cat transformed.txt

# 2.3 sed (Stream Editor): 's' stands for substitute. Syntax: s/find/replace/
echo -e "\nExercise: sed replacement"
echo "The cat sat on the mat" | sed 's/cat/dog/' | tee animal.txt
cat animal.txt

# 2.4 awk: A powerful tool for handling columns.
# '{print $1, $4}' tells awk to print only the 1st and 4th "words" (fields).
echo -e "\nExercise: awk column filtering"
echo "John Doe 25 Engineer" | awk '{print "Name: " $1 " | Role: " $4}' | tee profile.txt
cat profile.txt

pause

# -------------------------------------------------------------------------------
# 3. ENVIRONMENT & VARIABLES
# -------------------------------------------------------------------------------
echo "--- SECTION 3: ENVIRONMENT ---"

# 3.1 Export: Makes a local variable available to any child processes (subshells).
MY_STUDY_VAR="ShellScripting"
export MY_STUDY_VAR
echo "Exported Variable Value: $MY_STUDY_VAR"
# env: Lists all exported environment variables. grep filters for our specific one.
env | grep MY_STUDY_VAR

# 3.2 umask: Sets default permissions for new files. 0022 is standard.
# 3.3 alias: Creates a shortcut name for a longer command.
umask 0022
alias mydate='date' # Now typing 'mydate' runs 'date'
echo "Running the 'mydate' alias:"
mydate

pause

# -------------------------------------------------------------------------------
# 4. CONTROL FLOW (if, case, loops)
# -------------------------------------------------------------------------------
echo "--- SECTION 4: CONTROL FLOW ---"

# 4.1 read: Takes user input and saves it into the variable 'num'.
# 4.2 if/test: Checks a condition. '-gt' stands for 'Greater Than'.
echo "Enter a number (e.g., 15):"
read num
if [ "$num" -gt 10 ] 2>/dev/null; then
    echo "The 'if' statement evaluated TRUE: $num > 10."
else
    echo "The 'if' statement evaluated FALSE."
fi

# 4.3 for loop: Repeats an action for a specific list (1, 2, and 3).
echo -e "\nExercise: For loop creating files"
for i in {1..3}; do
    echo "Content for file $i" > "data_$i.txt"
    echo "Created data_$i.txt"
done
cat data_1.txt data_2.txt data_3.txt # View all three at once

# 4.4 case: A cleaner way to handle multiple 'if' conditions.
echo -e "\nSelect an option (A or B):"
read choice
case $choice in
    A|a) echo "You selected Alpha.";;
    B|b) echo "You selected Beta.";;
    *)   echo "Invalid choice.";;
esac

pause

# -------------------------------------------------------------------------------
# 5. CLEANUP & SOURCE
# -------------------------------------------------------------------------------
echo "--- SECTION 5: FINAL UTILITIES ---"

# 5.1 history: Displays the command log. 'tail' shows only the most recent ones.
echo "Viewing last 5 commands from your history:"
history 5

# 5.2 Cleanup: Good practice to delete temporary files created during the lesson.
# '2>/dev/null' silences errors if a file was already deleted.
rm output.txt error.txt transformed.txt animal.txt profile.txt data_*.txt 2>/dev/null
rmdir study_dir 2>/dev/null

echo "Study session complete! Practice makes permanent."