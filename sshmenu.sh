#!/bin/bash
#written by Philip Woldhek

PS3='Please enter your choice: '
options=("Osiris" "Aten" "Nun" "Azazel" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Osiris")
            ssh osiris
            exit 1
            ;;
        "Aten")
            ssh aten
            exit 1
            ;;
        "Nun")
            ssh nun
            exit 1
            ;;
        "Azazel")
            ssh azazel
    	    exit 1
            ;;
        "Quit")
            exit 1
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
