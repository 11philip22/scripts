import os
import dmenu
import pyimgur

def upload():
	client_id = "8e98531fa1631f6"
	PATH = "/tmp/screenshot.png"
	im = pyimgur.Imgur(client_id)
	uploaded_image = im.upload_image(PATH, title="Uploaded with PyImgur")
	print(uploaded_image.link)
	os.system("rm /tmp/screenshot.png")

def save_local():
	save_name = dmenu.show([''], prompt='type the filename (widout extension)')
	os.system("mv /tmp/screenshot.png /home/philip/pics/screenshots/" + save_name + ".png")

os.system("gnome-screenshot -a -f /tmp/screenshot.png 2> /dev/null")

if dmenu.show(['local', 'imgur']) == 'imgur':
	try:
		upload()
	except:
		if dmenu.show(['yes', 'no'], prompt='could not upload to upload to Imgur! save local?') == 'yes':
			save_local()
		else:
			os.system("rm /tmp/screenshot.png")
			exit()
else:
	save_local()
