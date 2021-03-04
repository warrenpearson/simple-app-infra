#!/bin/bash

echo "Querying dpkg lockfile" >> /tmp/dpkg_wait.log
i="0"

while [ $i -lt 15 ]
do
  if [ $(fuser /var/lib/dpkg/lock) ]; then
    echo "Found lockfile, sleeping" >> /tmp/dpkg_wait.log
    i="0"
  fi

  sleep 1
  i=$[$i+1]
done
echo "Done querying dpkg lockfile" >> /tmp/dpkg_wait.log
