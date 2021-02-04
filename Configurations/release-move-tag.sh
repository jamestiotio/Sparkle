#!/bin/bash
set -e

# Convenience script to automatically commit Package.swift after updating the checksum and move the latest tag
latest_git_tag=$(git describe --abbrev=0) # gets the latest tag name
commits_since_tag=$(git rev-list ${latest_git_tag}.. --count)
if [ "$commits_since_tag" -gt 0 ]; then
    # If there have been commits since the latest tag, it's highly likely that we did not intend to do a full release
    echo "WARNING: $commits_since_tag commit(s) since tag '$latest_git_tag'. Did you tag a new version?"
    echo "Package.swift has not been committed and tag has not been moved."
else
    # TODO: add sanity check to see if version is actually being updated or not?
    read -p "Do you want to commit changes to Package.swift and force move tag '$latest_git_tag'? (required for SPM release) [y/N]" -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        long_message=$(git tag -n99 -l $latest_git_tag) # gets corresponding message
        long_message=${long_message/$latest_git_tag} # trims tag name
        long_message="$(echo -e "${long_message}" | sed -e 's/^[[:space:]]*//')" # trim leading whitespace
        git add Package.swift
        git commit -m "Update Package.swift"
        git tag -fa $latest_git_tag -m "${long_message}"
        echo "Package.swift committed and tag '$latest_git_tag' moved."
    else
        echo "Package.swift has not been committed and tag has not been moved."
    fi
fi
