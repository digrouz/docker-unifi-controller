#!/usr/bin/env bash

UNIFI_URL="https://community.ui.com/rss/releases/UniFi-Network-Application/e6712595-81bb-4829-8e42-9e2630fabcfe"

LAST_VERSION=$(curl -SsL ${UNIFI_URL} | \
               grep -Po 'UniFi Network Application \K[0-9]*\.[0-9]*\.[0-9]*' | \
               sort -n | \
               tail -1 \
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
