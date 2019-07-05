import os, sys

def grep(bestand):
	a = open(bestand, "r")

	for emails in a:
		os.system("grep -r {0}".format(emails))

# for filename in os.listdir(directory):
# 	os.system("x {0}".format(filename))
	 