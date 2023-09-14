#!/bin/bash

# Local repo
cd /home/nabeel/Desktop/simple_project_cpp

# Fetch changes in remote repo
git fetch

# All branches in remote repo
remote_branches=$(git ls-remote --heads origin | cut -f 2) # -f only select fields


for remote_branch in $remote_branches; do
    
    branch_name="${remote_branch#refs/heads/}" # Extracting branch name

    # Checkout to branch
	git checkout $branch_name

	# Pull changes from remote repo
    git pull origin $branch_name
	
	# Stage chnages
    git add .

	# Commit changes
    commit_message="Auto-commit at $(date +'%Y-%m-%d %H:%M:%S')"

    git commit -m "$commit_message"

	# Push changes to remote repo
    git push origin $branch_name
		
done
