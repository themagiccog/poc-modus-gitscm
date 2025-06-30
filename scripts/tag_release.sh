#!/usr/bin/env bash
set -e

version=$(cat version.txt)
IFS='.' read -r major minor patch <<< "$version"
patch=$((patch + 1))
new="$major.$minor.$patch"

echo "$new" > version.txt
echo -e "## [$new] - $(date +%F)\n- New release" >> changelog.md

git add version.txt changelog.md
git commit -m "chore(release): v$new"
git tag "v$new"
git push origin main --tags
