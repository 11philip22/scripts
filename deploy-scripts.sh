#!/usr/bin/env bash


script_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -s ${script_root}/sshuttle.py /usr/local/bin/vpn
ln -s ${script_root}/autogit.sh /usr/local/bin/autogit