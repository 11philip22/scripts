#!/usr/bin/bash

# install from package manager
# add codium repo
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list
# add stack repo
echo 'deb http://mirror.transip.net/stack/software/deb/Ubuntu_18.04/ ./' | sudo tee /etc/apt/sources.list.d/stack-client.list
wget -O - https://mirror.transip.net/stack/release.key | sudo apt-key add -
# install packages
sudo apt update
sudo apt install -y ranger zsh git tmux rxvt-unicode xfonts-terminus neofetch wget stack-client codium \
                 # docker deps
                 apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo apt remove -y pidgin sgt-launcher sgt-puzzles gnome-sudoku gnome-mines xfburn onboard mousepad remmina
sudo apt autoremove -y

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER

# download scripts
mkdir ~/Devel
git clone git@github.com:11philip22/scripts.git ~/Devel/scripts

# install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/11philip22/oh-my-zsh/master/tools/install.sh)"
rm ~/.zshrc
ln -s ~/Devel/scripts/zshrc ~/.zshrc

# download wallpapers
wget --output-document=/usr/share/xfce4/backdrops/wallpaper1.png https://i.imgur.com/kfHKnjt.png
wget --output-document=/usr/share/xfce4/backdrops/wallpaper2.jpg https://i.imgur.com/035woPC.jpg

# add keybinds
cat <<EOF > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
<?xml version="1.0" encoding="UTF-8"?>

<channel name="xfce4-keyboard-shortcuts" version="1.0">
  <property name="commands" type="empty">
    <property name="default" type="empty">
      <property name="&lt;Alt&gt;F1" type="empty"/>
      <property name="&lt;Alt&gt;F2" type="empty">
        <property name="startup-notify" type="empty"/>
      </property>
      <property name="&lt;Alt&gt;F3" type="empty">
        <property name="startup-notify" type="empty"/>
      </property>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Delete" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;l" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;t" type="empty"/>
      <property name="XF86Display" type="empty"/>
      <property name="&lt;Super&gt;p" type="empty"/>
      <property name="&lt;Primary&gt;Escape" type="empty"/>
      <property name="XF86WWW" type="empty"/>
      <property name="XF86Mail" type="empty"/>
      <property name="Print" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Escape" type="empty"/>
      <property name="&lt;Alt&gt;Print" type="empty"/>
      <property name="&lt;Shift&gt;Print" type="empty"/>
      <property name="XF86HomePage" type="empty"/>
      <property name="&lt;Super&gt;w" type="empty"/>
      <property name="&lt;Super&gt;m" type="empty"/>
      <property name="XF86Explorer" type="empty"/>
      <property name="&lt;Super&gt;f" type="empty"/>
      <property name="&lt;Super&gt;F1" type="empty"/>
      <property name="&lt;Super&gt;t" type="empty"/>
      <property name="&lt;Super&gt;r" type="empty"/>
      <property name="&lt;Super&gt;e" type="empty"/>
      <property name="XF86Calculator" type="empty"/>
      <property name="XF86Music" type="empty"/>
      <property name="&lt;Super&gt;1" type="empty"/>
      <property name="XF86Messenger" type="empty"/>
      <property name="&lt;Super&gt;2" type="empty"/>
      <property name="&lt;Super&gt;3" type="empty"/>
      <property name="&lt;Super&gt;4" type="empty"/>
    </property>
    <property name="custom" type="empty">
      <property name="&lt;Alt&gt;F3" type="empty">
        <property name="startup-notify" type="bool" value="true"/>
      </property>
      <property name="&lt;Alt&gt;F2" type="empty">
        <property name="startup-notify" type="bool" value="true"/>
      </property>
      <property name="override" type="bool" value="true"/>
      <property name="&lt;Alt&gt;Return" type="string" value="exo-open --launch TerminalEmulator"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;d" type="string" value="exo-open --launch FileManager"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;m" type="string" value="exo-open --launch MailReader"/>
      <property name="&lt;Alt&gt;d" type="string" value="xfrun4">
        <property name="startup-notify" type="bool" value="true"/>
      </property>
      <property name="&lt;Shift&gt;&lt;Alt&gt;c" type="string" value="xflock4"/>
      <property name="Print" type="string" value="xfce4-screenshooter -r"/>
      <property name="&lt;Alt&gt;p" type="string" value="xfce4-display-settings --minimal"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;w" type="string" value="/usr/bin/google-chrome-stable"/>
    </property>
  </property>
  <property name="xfwm4" type="empty">
    <property name="default" type="empty">
      <property name="&lt;Alt&gt;Insert" type="empty"/>
      <property name="Escape" type="empty"/>
      <property name="Left" type="empty"/>
      <property name="Right" type="empty"/>
      <property name="Up" type="empty"/>
      <property name="Down" type="empty"/>
      <property name="&lt;Alt&gt;Tab" type="empty"/>
      <property name="&lt;Alt&gt;&lt;Shift&gt;Tab" type="empty"/>
      <property name="&lt;Alt&gt;Delete" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Down" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Left" type="empty"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;Page_Down" type="empty"/>
      <property name="&lt;Alt&gt;F4" type="empty"/>
      <property name="&lt;Alt&gt;F6" type="empty"/>
      <property name="&lt;Alt&gt;F7" type="empty"/>
      <property name="&lt;Alt&gt;F8" type="empty"/>
      <property name="&lt;Alt&gt;F9" type="empty"/>
      <property name="&lt;Alt&gt;F10" type="empty"/>
      <property name="&lt;Alt&gt;F11" type="empty"/>
      <property name="&lt;Alt&gt;F12" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Left" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;End" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Home" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Right" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Up" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_1" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_2" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_3" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_4" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_5" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_6" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_7" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_8" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_9" type="empty"/>
      <property name="&lt;Alt&gt;space" type="empty"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;Page_Up" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Right" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;d" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Up" type="empty"/>
      <property name="&lt;Super&gt;Tab" type="empty"/>
      <property name="&lt;Primary&gt;F1" type="empty"/>
      <property name="&lt;Primary&gt;F2" type="empty"/>
      <property name="&lt;Primary&gt;F3" type="empty"/>
      <property name="&lt;Primary&gt;F4" type="empty"/>
      <property name="&lt;Primary&gt;F5" type="empty"/>
      <property name="&lt;Primary&gt;F6" type="empty"/>
      <property name="&lt;Primary&gt;F7" type="empty"/>
      <property name="&lt;Primary&gt;F8" type="empty"/>
      <property name="&lt;Primary&gt;F9" type="empty"/>
      <property name="&lt;Primary&gt;F10" type="empty"/>
      <property name="&lt;Primary&gt;F11" type="empty"/>
      <property name="&lt;Primary&gt;F12" type="empty"/>
      <property name="&lt;Alt&gt;F5" type="empty"/>
      <property name="&lt;Super&gt;KP_1" type="empty"/>
      <property name="&lt;Super&gt;Down" type="empty"/>
      <property name="&lt;Super&gt;KP_3" type="empty"/>
      <property name="&lt;Super&gt;Left" type="empty"/>
      <property name="&lt;Super&gt;Right" type="empty"/>
      <property name="&lt;Super&gt;KP_7" type="empty"/>
      <property name="&lt;Super&gt;Up" type="empty"/>
      <property name="&lt;Super&gt;KP_9" type="empty"/>
    </property>
    <property name="custom" type="empty">
      <property name="&lt;Alt&gt;Insert" type="string" value="add_workspace_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_3" type="string" value="move_window_workspace_3_key"/>
      <property name="&lt;Primary&gt;F2" type="string" value="workspace_2_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Down" type="string" value="down_workspace_key"/>
      <property name="&lt;Super&gt;Down" type="string" value="tile_down_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_9" type="string" value="move_window_workspace_9_key"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Left" type="string" value="move_window_left_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;End" type="string" value="move_window_next_workspace_key"/>
      <property name="&lt;Primary&gt;F8" type="string" value="workspace_8_key"/>
      <property name="&lt;Primary&gt;F10" type="string" value="workspace_10_key"/>
      <property name="Right" type="string" value="right_key"/>
      <property name="Down" type="string" value="down_key"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;Page_Down" type="string" value="lower_window_key"/>
      <property name="&lt;Super&gt;Right" type="string" value="tile_right_key"/>
      <property name="&lt;Primary&gt;F9" type="string" value="workspace_9_key"/>
      <property name="&lt;Alt&gt;Tab" type="string" value="cycle_windows_key"/>
      <property name="Left" type="string" value="left_key"/>
      <property name="&lt;Super&gt;Up" type="string" value="tile_up_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Right" type="string" value="right_workspace_key"/>
      <property name="&lt;Primary&gt;F11" type="string" value="workspace_11_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_5" type="string" value="move_window_workspace_5_key"/>
      <property name="&lt;Primary&gt;F6" type="string" value="workspace_6_key"/>
      <property name="&lt;Alt&gt;Delete" type="string" value="del_workspace_key"/>
      <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
      <property name="&lt;Super&gt;KP_7" type="string" value="tile_up_left_key"/>
      <property name="&lt;Super&gt;Left" type="string" value="tile_left_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;d" type="string" value="show_desktop_key"/>
      <property name="&lt;Primary&gt;F1" type="string" value="workspace_1_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_4" type="string" value="move_window_workspace_4_key"/>
      <property name="&lt;Primary&gt;F12" type="string" value="workspace_12_key"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Right" type="string" value="move_window_right_key"/>
      <property name="Up" type="string" value="up_key"/>
      <property name="&lt;Primary&gt;F4" type="string" value="workspace_4_key"/>
      <property name="&lt;Alt&gt;F11" type="string" value="fullscreen_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_6" type="string" value="move_window_workspace_6_key"/>
      <property name="&lt;Alt&gt;&lt;Shift&gt;Tab" type="string" value="cycle_reverse_windows_key"/>
      <property name="Escape" type="string" value="cancel_key"/>
      <property name="&lt;Alt&gt;space" type="string" value="popup_menu_key"/>
      <property name="&lt;Super&gt;KP_1" type="string" value="tile_down_left_key"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;Page_Up" type="string" value="raise_window_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_1" type="string" value="move_window_workspace_1_key"/>
      <property name="&lt;Alt&gt;F12" type="string" value="above_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_7" type="string" value="move_window_workspace_7_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Home" type="string" value="move_window_prev_workspace_key"/>
      <property name="&lt;Super&gt;KP_9" type="string" value="tile_up_right_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_2" type="string" value="move_window_workspace_2_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Left" type="string" value="left_workspace_key"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Up" type="string" value="move_window_up_key"/>
      <property name="&lt;Alt&gt;F8" type="string" value="stick_window_key"/>
      <property name="&lt;Primary&gt;F5" type="string" value="workspace_5_key"/>
      <property name="&lt;Primary&gt;F7" type="string" value="workspace_7_key"/>
      <property name="&lt;Primary&gt;F3" type="string" value="workspace_3_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_8" type="string" value="move_window_workspace_8_key"/>
      <property name="&lt;Super&gt;KP_3" type="string" value="tile_down_right_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Up" type="string" value="up_workspace_key"/>
      <property name="override" type="bool" value="true"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;q" type="string" value="close_window_key"/>
      <property name="&lt;Alt&gt;f" type="string" value="maximize_window_key"/>
      <property name="&lt;Alt&gt;v" type="string" value="maximize_vert_key"/>
      <property name="&lt;Alt&gt;h" type="string" value="maximize_horiz_key"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;h" type="string" value="hide_window_key"/>
    </property>
  </property>
  <property name="providers" type="array">
    <value type="string" value="commands"/>
    <value type="string" value="xfwm4"/>
  </property>
</channel>
EOF