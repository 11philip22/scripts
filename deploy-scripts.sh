#!/usr/bin/env bash

# if [[ "$EUID" -ne 0 ]]; then
#     echo "Please run as root"
#     exit
# fi

install_dir="$HOME/.local/bin"

if [[ ! ":$PATH:" == *":${install_dir}:"* ]]; then
    echo "${install_dir} Is not in your PATH. Exiting"
    exit 1
fi

if [[ $1 = "clean" ]]; then
    rm "${install_dir}"/vpn
    rm "${install_dir}"/autogit
    # rm "${install_dir}"/kpndisplay
    rm "${install_dir}"/fix_xubuntu_slim
    # rm "${install_dir}"/solodisplay

elif [[ $1 = "install" ]]; then
    script_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    
    ln -s "${script_root}"/sshuttle.py "${install_dir}"/vpn
    ln -s "${script_root}"/autogit.sh "${install_dir}"/autogit
    # ln -s "${script_root}"/kpndisplay.sh "${install_dir}"/kpndisplay
    ln -s "${script_root}"/fix_xubuntu_slim.sh "${install_dir}"/fix_xubuntu_slim
    # ln -s "${script_root}"/solodisplay.sh "${install_dir}"/solodisplay

else
    echo "Usage: sudo ./deploy-scripts.sh install/clean"
fi