#!/bin/bash

# Remote repo
remote_repository="https://github.com/FatimahAhmad123/simple_project_cpp.git"

# Local repo
cd /home/nabeel/Desktop/simple_project_cpp

# Fetch changes in remote repo
git fetch

# All branches in remote repo
remote_branches=$(git ls-remote --heads origin | cut -f 2) # -f only select fields


for remote_branch in $remote_branches; do
    
    branch_name="${remote_branch#refs/heads/}" # Extracting branch name

    git checkout $branch_name


    git pull origin $branch_name
	

        git add .

        commit_message="Auto-commit at $(date +'%Y-%m-%d %H:%M:%S')"
        git commit -m "$commit_message"

        git push origin $branch_name

        echo "Updated and pushed changes for branch $branch_name."
		
done
