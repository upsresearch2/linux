#!/bin/bash

# Simple Docker Learning Script for Ubuntu
# Make executable with: chmod +x learn_docker.sh
# Run with: ./learn_docker.sh

# Color definitions (accessible: high contrast)
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
RESET='\033[0m'

pause() {
  echo -e "${YELLOW}\n--- Press ENTER to continue to the next section ---${RESET}"
  read
}

run_cmd() {
  echo -e "${CYAN}\n$ $1${RESET}"
  eval "$1"
}

echo -e "${GREEN}Welcome! This script will introduce you to Docker basics step by step.${RESET}"
pause

#############################################
# SECTION 1: What is Docker & Check Install
#############################################
echo -e "${GREEN}SECTION 1: Checking Docker installation${RESET}"

run_cmd "docker --version"

echo -e "\nDocker is a platform to build, run, and manage containers."
echo "Containers package apps with everything they need to run."

pause

#############################################
# SECTION 2: Run Your First Container
#############################################
echo -e "${GREEN}SECTION 2: Running your first container${RESET}"

run_cmd "docker run hello-world"

echo -e "\nThis command downloads an image and runs it in a container."

pause

#############################################
# SECTION 3: List Containers
#############################################
echo -e "${GREEN}SECTION 3: Listing containers${RESET}"

run_cmd "docker ps"

echo -e "\nShows running containers (likely empty)."

run_cmd "docker ps -a"

echo -e "\nShows all containers, including stopped ones."

pause

#############################################
# SECTION 4: Run Interactive Container
#############################################
echo -e "${GREEN}SECTION 4: Interactive container (Ubuntu shell)${RESET}"

echo -e "We will start an Ubuntu container interactively."
echo -e "Type 'exit' when inside the container to return here."

run_cmd "docker run -it ubuntu bash"

pause

#############################################
# SECTION 5: Detached Mode
#############################################
echo -e "${GREEN}SECTION 5: Running container in background${RESET}"

run_cmd "docker run -d --name mynginx -p 8080:80 nginx"

echo -e "\nThis runs an Nginx web server in the background."
echo -e "Try opening: http://localhost:8080 in your browser."

run_cmd "docker ps"

pause

#############################################
# SECTION 6: View Logs
#############################################
echo -e "${GREEN}SECTION 6: Viewing logs${RESET}"

run_cmd "docker logs mynginx"

pause

#############################################
# SECTION 7: Stop Container
#############################################
echo -e "${GREEN}SECTION 7: Stopping a container${RESET}"

run_cmd "docker stop mynginx"

run_cmd "docker ps"

pause

#############################################
# SECTION 8: Images
#############################################
echo -e "${GREEN}SECTION 8: Working with images${RESET}"

run_cmd "docker images"

echo -e "\nImages are templates used to create containers."

pause

#############################################
# SECTION 9: Cleanup
#############################################
echo -e "${GREEN}SECTION 9: Cleanup${RESET}"

echo -e "Removing containers and images created during this session."

run_cmd "docker rm mynginx 2>/dev/null"
run_cmd "docker rmi nginx 2>/dev/null"
run_cmd "docker rmi hello-world 2>/dev/null"

echo -e "\nCleanup complete!"

echo -e "${GREEN}\nCongratulations! You've completed the Docker basics tutorial.${RESET}"