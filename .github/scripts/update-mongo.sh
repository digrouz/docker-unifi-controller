#!/usr/bin/env bash

MONGO_URL="https://www.mongodb.com/download-center/community/releases"

LAST_VERSION=$(curl -SsL ${MONGO_URL} | \
               grep -o -e 'https://repo.mongodb.org/apt/debian/dists/bookworm/mongodb-org/8.0/main/binary-amd64/mongodb-org-server_8.0.[0-9]\+_amd64.deb' | \
               uniq | \
               grep -o -e '[0-9]\+.[0-9]\+.[0-9]\+'
              )

if [ "${LAST_VERSION}" ];then
  sed -i -e "s|MONGO_VERSION='.*'|MONGO_VERSION='${LAST_VERSION}'|" Dockerfile*
fi 

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "Mongodb update to version: ${LAST_VERSION}"
  git push
fi
