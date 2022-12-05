#!/bin/bash
#
# Name - pipeline.sh
#
# Purpose - CI/CD Pipeline
# HK Transfield
# -----------------------------------------------------------------

git_msg="$1"


#######################################
# installs all npm modules
# creates a build of the application
#######################################
install_and_build_app() {
    echo "(1) Install modules"
    npm install

    echo "(2) Build (compiling the application)"
    npm run build
}

#######################################
# Adds new changes to git repository
# and pushes it to Github
#######################################
handle_git() {
        echo "(3) Commiting changes and pushing repository to Github"

        local m="$1"

        git add .
        git commit -m "$m"
        git push
        echo "(4) Changes successfully pushed to Github"
}

#######################################
# Runs the application
#######################################
start_app() {
    echo "(5) Start (run the application)"
    cd assets/
    npm run start
}

#######################################
# Displays an error message and
# exits the program if the program
# does not compile
#######################################
handle_compile_error() {
    echo "Error: Something was encountered during the building!"
    exit 0
}

# make sure git commit message supplied as cli arg or die
[ $# -eq 0 ] && { echo "Error: Please enter a git commit message"; echo "Usage: $0 <message>"; exit 1; }

# begin pipeline
(install_and_build_app && handle_git "$git_msg" && start_app) || handle_compile_error
