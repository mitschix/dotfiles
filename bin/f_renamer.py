#!/usr/bin/env python
# Pythono3 code to rename multiple
# files in a directory or folder
import os

# Function to rename multiple files


def f_renamer(directory, string=None):
    dir_list = os.listdir(directory)
    dir_list.sort()
    for count, filename in enumerate(dir_list):
        ext = filename.split(".")[-1]
        dstname = f"{count:04d}_{string}.{ext}"
        src = os.path.join(directory, filename)
        dst = os.path.join(directory, dstname)
        if filename == dstname:
            print(f"Skipping... same file name {dstname}")
            continue
        else:
            print(f"Change {filename} to {dstname}.")

        # rename() function will
        # rename all the files
        os.rename(src, dst)


def main():
    cwd = os.getcwd()
    string = "wallpaper"
    f_renamer(cwd, string)


if __name__ == '__main__':
    main()
