#!/bin/bash

set -e
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

SOURCE_BRANCH="master"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    exit 0
fi

# Go To Public folder
cd public
git checkout $SOURCE_BRANCH

#convert origin from https to ssh so the key will work
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

git config user.name "${COMMIT_AUTHOR}"
git config user.email "${COMMIT_AUTHOR_EMAIL}"

# Add changes to git and commit.
git add .
git commit -m "deploying site `date` ${SHA}"
git status

# Get the deploy key by using Travis's stored variables to decrypt travisci.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}

openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in ../nwh_travisci.enc -out ../deploy_key -d

chmod 600 ../deploy_key
eval `ssh-agent -s`
ssh-add ../deploy_key

# Push source
echo $SSH_REPO
echo $SOURCE_BRANCH
git push $SSH_REPO $SOURCE_BRANCH

# Come Back
cd ..