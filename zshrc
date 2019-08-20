#written by Philip Woldhek

export ZSH="/home/philip/.oh-my-zsh"
export VISUAL=vim
export EDITOR="$VISUAL"

ZSH_THEME="junkfood"

plugins=(git extract)

source $ZSH/oh-my-zsh.sh

##########aliases##########

alias agenda='gcalcli calm'
alias todo='gcalcli agenda'
alias Ro='sudo pacman -Rscn $(pacman -Qtdq)'
alias rschool='ranger ~/school'
alias rscripts='ranger ~/scripts'
alias rpics='ranger ~/pics'
alias rphone='ranger ~/phone'
alias rshare='ranger ~/share-map'
alias rmount='ranger /mnt'
alias mkdir='mkdir -pv'
alias c='clear'
#alias ip='ifconfig | grep -o --color=always -P "(^([A-Za-z0-9]+)\:?)|(inet|inet6)\s*(?:addr:?)?\s*((\d{1,3}\.){3}\d{1,3}|((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])){3}))|:)))(%.+)?)"'
alias dockerclean='sudo docker rm -f $(sudo docker ps -a -q) && sudo docker rmi -f $(sudo docker images -q)'
alias sudo='sudo '
#alias vpn='bash /home/philip/sshuttle.sh'
alias warpnet='cd /home/philip/school/stage-warpnet'
alias school='cd /home/philip/school/school'
alias scripts='cd /home/philip/scripts'
alias downloads='cd /home/philip/Downloads'
alias r='ranger'
alias mnt='cd /mnt'
alias share='cd /home/philip/share-map'
alias rdwm='ranger /home/philip/.config/dwm'
alias gdwm='cd /home/philip/.config/dwm'
alias m='sudo bash /home/philip/scripts/dmenumount.sh'
alias github='cd /home/philip/share-map/github'
alias 3tb='cd /srv/sto3'
alias raid='cd /srv/sto1'
alias 4tb='cd /srv/sto2'
alias nano='vim'
alias mktar='tar -czvf'
alias sto1='cd /srv/sto1'
alias sto2='cd /srv/sto2'
alias sto3='cd /srv/sto4'
alias sto4='cd /srv/sto5'
alias deluxe='cd /srv/sto2/scripts'

##########functions##########

function wifimon() {
 if ifconfig | grep -q wlp4s0mon
  then
   sudo airmon-ng check kill &
   sleep 1 &
   sudo airmon-ng stop wlp4s0mon
  else
   sudo airmon-ng check kill &
   sleep 1 &
   sudo airmon-ng start wlp4s0
 fi
}

export wifimon

function changemac() {
 sudo ifconfig wlp4s0 down
 sudo macchanger -r wlp4s0
 sudo ifconfig wlp4s0 up
}

export changemac

function headset() {
 if echo -e "info" | bluetoothctl | grep Missing
  then
   echo -e "power on" | bluetoothctl
   sleep 1
   echo -e "connect A0:E6:F8:18:DD:F5" | bluetoothctl
  else
   echo -e "power off" | bluetoothctl
 fi
}

export headset
