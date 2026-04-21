#!/bin/bash

# ===============================================================================
# LINUX PROCESS MANAGEMENT & JOB CONTROL
# Save as: process_management.sh | Execute with: ./process_management.sh
# ===============================================================================

pause() {
    echo -e "\n\033[0;36m[Press Enter to continue...]\033[0m"
    read
    clear
}

clear
echo "Starting Process Management Study Session..."
sleep 1

# -------------------------------------------------------------------------------
# 1. VIEWING PROCESSES
# -------------------------------------------------------------------------------
echo "--- 1. VIEWING PROCESSES ---"

# ps: Displays a snapshot of current processes for the current user
echo "Simple ps (current shell):"
ps

# ps -f: Displays a 'full' format listing (including UID, PID, PPID)
echo -e "\nFull format ps -f:"
ps -f

# ps -ef: Displays every process running on the system
echo -e "\nEvery process (ps -ef) - first 10 lines:"
ps -ef | head -10

# ps -ef | grep: Searching for specific processes (filtering for 'bash')
echo -e "\nFiltering for bash processes:"
ps -ef | grep bash

# ps -l: Long format (shows the 'F' flag; 0 represents a normal process)
echo -e "\nLong format (note the Flags column):"
ps -l

# ps ax: Shows all processes, including those not attached to a terminal
echo -e "\nAll system processes (ps ax) - first 11 lines:"
ps ax | head -11

pause

# -------------------------------------------------------------------------------
# 2. HIERARCHY & REAL-TIME MONITORING
# -------------------------------------------------------------------------------
echo "--- 2. HIERARCHY & TOP ---"

# ls /proc: View the virtual filesystem where Linux stores process info
echo "Contents of /proc (Each number is a PID folder):"
ls /proc | head -20

# pstree: Displays processes in a tree structure to show parent/child relationships
echo -e "\nProcess Tree (pstree):"
pstree | head -15

# top: Real-time dynamic view of running processes
echo -e "\nNote: Normally you run 'top' or 'htop' to see live updates."
echo "Running 'top' in batch mode for 1 iteration:"
top -b -n 1 | head -15

pause

# -------------------------------------------------------------------------------
# 3. TERMINATING PROCESSES (Signals & Kill)
# -------------------------------------------------------------------------------
echo "--- 3. TERMINATING PROCESSES ---"

# kill -l: List all available signal names and numbers (e.g., 9=SIGKILL, 15=SIGTERM)
echo "Listing available kill signals:"
kill -l | xargs | fold -s -w 60

# Practical Example: Start a dummy process in the background
sleep 100 &
DUMMY_PID=$!
echo -e "\nStarted dummy process (sleep 100) with PID: $DUMMY_PID"

# kill -3 (SIGQUIT): Terminates a process and produces a core dump
echo "Terminating PID $DUMMY_PID with signal -3 (SIGQUIT)..."
kill -3 $DUMMY_PID
sleep 1
ps -p $DUMMY_PID || echo "Process $DUMMY_PID has been terminated."

# pgrep: Finds PIDs based on user or pattern
# Usage: pgrep -u username "pattern"
echo -e "\nExample: pgrep -u $(whoami) \"bash\""
pgrep -u $(whoami) "bash"

# killall: Kills all processes by name (useful for multiple instances)
# Example: killall -3 sample_process (Simulated)
echo -e "\nCommand: killall -3 sample"
echo "This would kill every instance of a process named 'sample'."

pause

# -------------------------------------------------------------------------------
# 4. JOB CONTROL (Foreground & Background)
# -------------------------------------------------------------------------------
echo "--- 4. JOB CONTROL ---"

# & operator: Starts a command in the background immediately
echo "Starting 'sleep 30' in background..."
sleep 30 &

# jobs: Lists background jobs and their job numbers
echo -e "\nListing current jobs:"
jobs

# Control flow example: Start, pause, and move to background
echo -e "\nStarting 'sleep 15'..."
sleep 15 &
# bg: Sends a stopped or foreground job to the background
echo "Command: bg (would resume a suspended job in background)"

pause

# -------------------------------------------------------------------------------
# 5. SCHEDULING (at command)
# -------------------------------------------------------------------------------
echo "--- 5. SCHEDULING WITH 'at' ---"

# at: Schedules a one-time task
echo "Scheduling a message to be appended to at_output.txt in 1 minute..."
echo "echo 'Hello after 1 minute' >> ~/at_output.txt" | at now + 1 minute 2>/dev/null || echo "Note: 'at' utility not installed/started."

echo -e "\nTo view scheduled tasks: atq"
echo "To view content after 1 minute: cat ~/at_output.txt"

echo -e "\nStudy session complete! Practice 'htop' manually for a better visual experience."