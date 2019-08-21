#!/usr/bin/env bash


if [[ "$EUID" -ne 0 ]]; then
    echo "Please run as root"
    exit
fi


if [[ $1 = "clean" ]]; then
    rm /usr/local/bin/vpn
    rm /usr/local/bin/autogit

elif [[ $1 = "install" ]]; then
    script_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    ln -s ${script_root}/sshuttle.py /usr/local/bin/vpn
    ln -s ${script_root}/autogit.sh /usr/local/bin/autogit

else
    echo "Usage: sudo ./deploy-scripts.sh install/clean"
fi