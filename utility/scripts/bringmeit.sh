#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: bringmeit.sh <searchsploit_path>"
    exit 1
fi

SOURCE_FILE=/usr/share/exploitdb/exploits/$1

# Check if path exist
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: File '$SOURCE_FILE' does not exist."
    exit 1
fi

# Copy the file to the current directory
cp "$SOURCE_FILE" .

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "File copied to the current directory!"
else
    echo "Error: Failed to copy the file."
    exit 1
fi
