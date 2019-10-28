from os import getcwd
from os import listdir
from os import rmdir
from pathlib import Path
from shutil import move

current_location = Path(getcwd())

pictures = []
for folder in current_location.iterdir():
    if folder.is_dir():
        for picture in folder.iterdir():
            pictures.append(picture)

for picture in pictures:
    new_name = picture.name
    counter = 1
    while True:
        test_path = Path(current_location, new_name)
        if test_path.exists():
            new_name = "{0}{1}{2}".format(picture.stem, counter, picture.suffix)
            print("{0} exists. trying: {1}".format(test_path.name, new_name))
            counter += 1
        else:
            break

    new_location = Path(current_location, new_name)
    print("moving: {0} to {1}".format(picture, new_location))
    move(str(picture), str(new_location))

for folder in current_location.iterdir():
    if folder.is_dir():
        if not listdir(str(folder)):
            print("Folder: {0} is empty. Deleting!".format(folder))
            rmdir(str(folder))
