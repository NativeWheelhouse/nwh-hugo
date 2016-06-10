#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo -t Lanyon

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
git commit -m "deploying site `date`"

# Push source and build repos.
git push origin master

# Come Back
cd ..