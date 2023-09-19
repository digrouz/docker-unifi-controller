#!/usr/bin/env bash

UNIFI_URL="http://dl-origin.ubnt.com/unifi/debian/dists/stable/ubiquiti/binary-amd64/Packages"

LAST_VERSION=$(curl -SsLX ${UNIFI_URL} | \
               grep -A 7 -m 1 'Package: unifi' | \
               awk -F ': ' '/Version/{print $2;exit}' | \
               awk -F '-' '{print $1}' \
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
