#!/usr/bin/env bash

UNIFI_URL="https://api.github.com/repos/UNIFI/UNIFI/releases"

LAST_VERSION=$(curl -SsL ${UNIFI_URL} | \
               grep -Po 'UniFi Network Application \K[0-9]*\.[0-9]*\.[0-9]*' \
              )

if [ "${LAST_VERSION}" ];then
  sed -i -e "s|UNIFI_VERSION='.*'|UNIFI_VERSION='${LAST_VERSION}'|" Dockerfile*
fi 

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update to version: ${LAST_VERSION}"
  git push
fi
