
# See what would be pruned without actually deleting anything
git remote prune origin --dry-run

# If you're happy with the list, run the real command
git fetch --prune origin


# The '-vv' flag shows detailed tracking information
git branch -vv


# Automatic removal of branches when they are "gone"

git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d

