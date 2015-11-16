#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
# if using a theme, replace by `hugo -t <yourtheme>`
echo "Generating website..."
hugo
echo "Website generated."

# Go To Public folder
cd public
# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

head_hash=$(git rev-parse HEAD)
echo "new commit made: ${head_hash}"

# Merge master branch with the change and push to remote
echo "Checking out master..."
git checkout master
echo "merging with ${head_hash}..."
git merge ${head_hash}
echo "pushing master to remote"
git push origin master

# Come Back
cd ..

echo "Done."
