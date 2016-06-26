#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Go To Public folder
cd public

# If there are no changes (e.g. this is a README update) then just bail.
if [ -z `git diff --exit-code` ]; then
    echo "No changes to the static site on this push; exiting."
    exit 0
fi

set -e # always exit with failure when something fails
git config user.name "${COMMIT_AUTHOR}"
git config user.email "${COMMIT_AUTHOR_EMAIL}"

# Add changes to git.
git add .

# Commit changes.
git commit -m "deploying site `date` ${SHA}"

# Get the deploy key by using Travis's stored variables to decrypt travisci.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}

openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in ../travisci.enc -out ../deploy_key -d

chmod 600 ../deploy_key
eval `ssh-agent -s`
ssh-add ../deploy_key

# Push source and build repos.
git push origin master

# Come Back
cd ..