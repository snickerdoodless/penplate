#!/bin/bash

INIT_FOLDER="/home/rall4/penplate/utility/template/template_folder/"

# Check if the source folder exists
if [ ! -d "$INIT_FOLDER" ]; then
    echo "Error: Init failed! Check the source folder: $INIT_FOLDER"
    exit 1
fi

# Copy all contents from the source folder to the current directory
cp -r "$INIT_FOLDER"* .

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Success! All contents copied to the current directory."
else
    echo "Error: Failed to copy the contents."
    exit 1
fi
