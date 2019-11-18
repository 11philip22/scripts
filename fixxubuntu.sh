#!/usr/bin/env bash

# This program is written for ubuntu 19.04 running on a Lenovo Thinkpad t490.
# Its mostly personalized settings and programs but also a few fixes:
# -HSP/A2DP bluetooth devices (please check if your bluetooth works before you run this part)
# -screen tearing and black lockscreen will probably work on on other devices with Intel UHD Graphics 620

if [[ "$EUID" -ne 0 ]]
    then echo "Please run with sudo"
    exit
fi

username=philip

apt update
apt install -y vscodium ranger zsh git neofetch tmux subversion rxvt-unicode python3-pip ncmpccp mpd xfonts-terminus \
chromium curl
apt remove -y pidgin sgt-launcher sgt-puzzles gnome-sudoku gnome-mines xfburn onboard mousepad remmina
apt autoremove

# disable cups because it makes my pc hang at shutdown
systemctl disable cups-browsed.service

# set wallpaper
wget --output-document=/usr/share/backgrounds/wallpaper1.png https://i.imgur.com/kfHKnjt.png
wget --output-document=/usr/share/backgrounds/wallpaper2.jpg https://i.imgur.com/035woPC.jpg
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set /usr/share/backgrounds/wallpaper1.png

# set gtk theme
xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"

# download scripts
mkdir -pv $HOME/scripts
git clone git@github.com:11philip22/scripts.git $HOME/scripts
chown -R ${username}:${username} $HOME/scripts
bash $HOME/scripts/deploy-scripts.sh

# fix grub
sed 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi=force"/' /etc/default/grub
grub-mkconfig

# fix vim
sed 's/Exec=vim/Exec=urxvt -e vim/' /usr/share/applications/vim.desktop
sed 's/Terminal=true/Terminal=false/' /usr/share/applications/vim.desktop

# fix screen tearing and locks screen
mkdir -p /etc/X11/xorg.conf.d/
touch /etc/X11/xorg.conf.d/20-intel.conf
cat <<EOF > /etc/X11/xorg.conf.d/20-intel.conf
Section "Device"
   Identifier  "Intel Graphics"
   Driver      "intel"
   Option      "TearFree"    "true"
EndSection
EOF

# fix auto updates
sed 'APT::Periodic::Update-Package-Lists "1";/APT::Periodic::Update-Package-Lists "0";/' /etc/apt/apt.conf.d/20auto-upgrades
sed 'APT::Periodic::Unattended-Upgrade "1";/APT::Periodic::Unattended-Upgrade "0";/' /etc/apt/apt.conf.d/20auto-upgrades

# fix zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s $HOME/scripts/zshrc $HOME/.zshrc
chown -R ${username}:${username} $HOME/.zshrc
wget --output-document=$HOME/.oh-my-zsh/themes/junkfood.zsh-theme \
https://gist.githubusercontent.com/11philip22/60b14d36d923a0e458e060179c5ccfd8/raw/d7f06cee82eff94f55d719f25b3c9ddf1f5c8f8f/junkfood.zsh-theme
rm -rf $HOME/.oh-my-zsh/.git

# install stack
echo 'deb http://mirror.transip.net/stack/software/deb/Ubuntu_18.04/ ./' | sudo tee /etc/apt/sources.list.d/stack-client.list
wget -O - https://mirror.transip.net/stack/release.key | sudo apt-key add -
sudo apt-get update
apt-get install stack-client

# install qemu/kvm
apt-get -y install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
adduser ${username} libvirt

# install citrix
wget --output-document=/tmp/citrix.deb \
https://downloads.citrix.com/14822/icaclientWeb_13.10.0.20_amd64.deb?__gda__=1565340535_8a441281b695e09f7a32742b0465593e
dpkg -i /tmp/citrix.deb

# install docker
apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
groupadd docker
usermod -aG docker ${username}
