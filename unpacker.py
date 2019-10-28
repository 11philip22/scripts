from pathlib import Path
from zipfile import ZipFile


def unpacker(target_folder):
    for file in target_folder.iterdir():
        file_name = file.stem.replace("_full", "")
        with ZipFile(file, "r") as zip_file:
            zip_file.extractall(target_folder)
        rename_file = Path(target_folder, "photos")
        rename_file.rename(Path(target_folder, file_name))


if __name__ == "__main__":
    target = Path("")
    unpacker(target_folder=target)
