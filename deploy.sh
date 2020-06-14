#!/bin/sh

# If a command fails then the deploy stops
set -e

echo "commit the huge source repo"
git add content/blog
msg="update blog content $(date)"
git commit -m "$msg"
git push origin master

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
