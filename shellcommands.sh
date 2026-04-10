#!/bin/bash

# ===============================================================================
# LINUX SHELL COMMANDS: INTERACTIVE STUDY SCRIPT
# Run this script to see commands in action.
# ===============================================================================

# Function to pause between exercises
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

# EXERCISE: Redirect stdout and stderr
echo "Exercise: Redirecting Output and Errors"
ls /root > output.txt 2> error.txt
echo "Contents of error.txt (Expect 'Permission denied'):"
cat error.txt

# EXERCISE: Logical Operators (&& and ||)
echo -e "\nExercise: Logical Operators"
mkdir -p study_dir && echo "Directory 'study_dir' created successfully."
ls non_existent_file || echo "Note: The file doesn't exist (This is the || in action)."

# EXERCISE: Escape Sequences
echo -e "\nExercise: Escape Sequences"
echo -e "Formatting check:\n\t- Tabbed Line\n\t- New Line"
echo "Escaping quotes: \"Hello Linux\""

pause

# -------------------------------------------------------------------------------
# 2. TEXT PROCESSING (tr, sed, awk, tee)
# -------------------------------------------------------------------------------
echo "--- SECTION 2: TEXT PROCESSING ---"

# EXERCISE: tr and tee
echo "Exercise: tr (translate) and tee"
echo "learning linux" | tr 'a-z' 'A-Z' | tee transformed.txt
echo "Verified file content with cat:"
cat transformed.txt

# EXERCISE: sed (stream editor)
echo -e "\nExercise: sed replacement"
echo "The cat sat on the mat" | sed 's/cat/dog/' | tee animal.txt
cat animal.txt

# EXERCISE: awk (pattern scanning)
echo -e "\nExercise: awk column filtering"
echo "John Doe 25 Engineer" | awk '{print "Name: " $1 " | Role: " $4}' | tee profile.txt
cat profile.txt

pause

# -------------------------------------------------------------------------------
# 3. ENVIRONMENT & VARIABLES
# -------------------------------------------------------------------------------
echo "--- SECTION 3: ENVIRONMENT ---"

# EXERCISE: Variables and Export
echo "Exercise: Exporting variables"
MY_STUDY_VAR="ShellScripting"
export MY_STUDY_VAR
echo "Exported Variable: $MY_STUDY_VAR"
env | grep MY_STUDY_VAR

# EXERCISE: Alias and umask
echo -e "\nExercise: Umask and Alias"
umask 0022
echo "Current umask: $(umask)"
alias mydate='date'
echo "Running alias 'mydate':"
mydate

pause

# -------------------------------------------------------------------------------
# 4. CONTROL FLOW (if, case, loops)
# -------------------------------------------------------------------------------
echo "--- SECTION 4: CONTROL FLOW ---"

# EXERCISE: Read and If
echo "Enter a number greater than 10:"
read num
if [ "$num" -gt 10 ] 2>/dev/null; then
    echo "Correct! $num is greater than 10."
else
    echo "That is not greater than 10 or not a number."
fi

# EXERCISE: For Loop
echo -e "\nExercise: For loop creating files"
for i in {1..3}; do
    echo "Data for file $i" > "data_$i.txt"
    echo "Created data_$i.txt"
done
cat data_1.txt data_2.txt data_3.txt

# EXERCISE: Case Statement
echo -e "\nSelect a color (red/blue):"
read color
case $color in
    red) echo "You chose Red!";;
    blue) echo "You chose Blue!";;
    *) echo "Unknown color.";;
esac

pause

# -------------------------------------------------------------------------------
# 5. CLEANUP & HISTORY
# -------------------------------------------------------------------------------
echo "--- SECTION 5: FINAL UTILITIES ---"

echo "Exercise: History tail"
history 5

echo -e "\nCleaning up practice files..."
rm output.txt error.txt transformed.txt animal.txt profile.txt session.sh data_*.txt notes.txt input_sample.txt fruits.txt user_info.txt secret.txt 2>/dev/null
rmdir study_dir 2>/dev/null

echo "Study session complete!"