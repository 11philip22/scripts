import os 
import libtmux 
import time 

os.system("tmux new -s monitor -d")
tmux = libtmux.Server()
time.sleep(1)
session = tmux.find_where({ "session_name": "monitor" })
window = session.attached_window
pane = window.select_pane(1)
pane.send_keys("gotop -s -b -c monokai")
pane.split_window(attach=True, vertical=False,)
pane = window.select_pane(2)
pane.send_keys("htop")