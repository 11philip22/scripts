#! /bin/bash

JENKINSHOME=~/.jenkins

for output in $(ls ${JENKINSHOME}/plugins/ | grep ".jpi$" | cut -f 1 -d '.' ); do
    find ${JENKINSHOME}/jobs/ -name config.xml | xargs grep "${output}" 2>/dev/null
done