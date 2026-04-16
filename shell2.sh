#===============================================================================
#LINUX SHELL COMMANDS: INTERMEDIATE PRACTICE
#===============================================================================

#-------------------------------------------------------------------------------
#1. REDIRECTION & STREAMS (stdin, stdout, stderr)
#-------------------------------------------------------------------------------

# EXERCISE: Redirect stdout to a file and stderr to another.
ls /root > output.txt 2> error.txt
# >  : Redirects standard output (stdout).
# 2> : Redirects standard error (stderr). 
cat error.txt  # View the error (Permission denied) using cat.

# EXERCISE: Append output to a file instead of overwriting.
echo "Line 1" > notes.txt
echo "Line 2" >> notes.txt
cat notes.txt  # Verify both lines exist.

# EXERCISE: Redirect stdin using <.
cat << EOF > input_sample.txt
Hello World
EOF
tr 'a-z' 'A-Z' < input_sample.txt
# < : Takes the content of input_sample.txt as stdin for tr.

#-------------------------------------------------------------------------------
#2. LOGICAL OPERATORS & ESCAPE SEQUENCES (&&, ||, \)
#-------------------------------------------------------------------------------

# EXERCISE: Use AND (&&) and OR (||) for conditional execution.
mkdir test_dir && echo "Directory created successfully"
ls non_existent_file || echo "File not found!"
# && : Runs the second command ONLY if the first succeeds (exit code 0).
# || : Runs the second command ONLY if the first fails (exit code non-zero).

# EXERCISE: Use escape sequences for special characters and formatting.
echo -e "Line one\nLine Two\t(Tabbed)"
# -e : Enables interpretation of backslash escapes like \n (newline) and \t (tab).
echo "This is a \"double quote\" inside a string"
# \ : Escapes the quote so the shell treats it as literal text.

#-------------------------------------------------------------------------------
#3. TEXT PROCESSING WITH VERIFICATION (tr, sed, awk, tee, cat)
#-------------------------------------------------------------------------------

# EXERCISE: Replace text and save while viewing, then verify with cat.
echo "apple banana cherry" | sed 's/banana/orange/' | tee fruits.txt
cat fruits.txt
# sed: Changes banana to orange.
# tee: Saves to file AND shows you the result immediately.

# EXERCISE: Use awk to extract data and format it.
echo "User1:Pass123:1001" | awk -F: '{print "User: " $1 " ID: " $3}' > user_info.txt
cat user_info.txt
# -F: : Sets the field separator to a colon.

#-------------------------------------------------------------------------------
#4. ENVIRONMENT & SCRIPTS (export, source, read, if)
#-------------------------------------------------------------------------------

# EXERCISE: Create a script snippet, source it, and check variables.
echo "export SESSION_ID=99" > session.sh
source ./session.sh
echo "Current Session: $SESSION_ID"

# EXERCISE: Read input and use 'if' with 'cat'.
echo "Create a secret message?"
read msg
if [ ! -z "$msg" ]; then
    echo "$msg" > secret.txt
    echo "Message saved. Displaying content:"
    cat secret.txt
fi

#-------------------------------------------------------------------------------
#5. LOOPS & CASE (for, while, case)
#-------------------------------------------------------------------------------

# EXERCISE: Loop to create multiple files and verify with 'cat'.
for i in 1 2 3; do
    echo "This is file number $i" > "file_$i.txt"
done
cat file_1.txt file_2.txt file_3.txt

# EXERCISE: Use 'case' to decide which file to read.
echo "Which file to cat? (1/2/3)"
read choice
case $choice in
    1) cat file_1.txt;;
    2) cat file_2.txt;;
    3) cat file_3.txt;;
    *) echo "Invalid choice";;
esac

#-------------------------------------------------------------------------------
#6. SHELL UTILITIES (history, Git, alias)
#-------------------------------------------------------------------------------

# EXERCISE: Create an alias that uses 'cat'.
alias ccat='cat -n' # Alias to cat with line numbers.
ccat fruits.txt

# EXERCISE: Check history for a specific command.
history | grep "sed" | tail -n 5

# EXERCISE: Check Git status (if in a repo).
git status || echo "Not a git repository"
===============================================================================