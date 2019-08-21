#!/usr/bin/env bash

git add .
now=`date '+%F_%H:%M:%S'`
git commit -m "${now}"
git push origin master