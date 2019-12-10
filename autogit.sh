#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    msg=$(date '+%F_%H:%M:%S')
else
    msg=$@
fi

git add .
git commit -m "${msg}"
git push origin master