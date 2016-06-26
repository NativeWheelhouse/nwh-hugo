#!/bin/bash

echo -e "Generating static site..."

# Build the project.
hugo

SOURCE_BRANCH="master"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    exit 0
fi

# Go To Public folder
cd public

SHA=`git rev-parse --verify HEAD`

git config user.name "${COMMIT_AUTHOR}"
git config user.email "${COMMIT_AUTHOR_EMAIL}"

# Add changes to git and commit.
git add .
git commit -m "deploying site `date` ${SHA}"