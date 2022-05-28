#!/bin/sh

# If a command fails then the deploy stops
set -e

if [ 0 == 0 ]; then
echo "commit the huge source repo"
msg="add content $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git add content
git commit -m "$msg"
git push origin master

fi

printf "\033[0;32mDeploying hugo site to GitHub...\033[0m\n"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
