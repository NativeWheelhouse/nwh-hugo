#!/bin/bash

set -ex

# link the public folder to the remote repo
git clone "${DEPLOY_REPO_HTTPS_PREFIX}${DEPLOY_REPO}" public

cd public

git remote set-url --push origin "${DEPLOY_REPO_SSH_PREFIX}${DEPLOY_REPO}"

cd ..

echo "Generating static site..."

# Build the project.
hugo
