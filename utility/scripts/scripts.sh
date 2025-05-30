#!/bin/bash

# Source directory
SOURCE_DIR="/home/rall4/penplate/utility/github-scripts"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# List items (files and folders) in the source directory
echo "Available scripts and folders:"
items=("$SOURCE_DIR"/*)
for i in "${!items[@]}"; do
    name=$(basename "${items[i]}")
    if [ -d "${items[i]}" ]; then
        echo "$((i + 1)). [DIR]  $name"
    else
        echo "$((i + 1)).       $name"
    fi
done

# Prompt user for selection
read -p "Enter the number of the item you want to copy: " choice

# Validate the input
if [[ ! "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#items[@]}" ]; then
    echo "Invalid choice. Please run the script again."
    exit 1
fi

# Get the selected item
selected_item="${items[$((choice - 1))]}"

# Copy file or directory accordingly
if [ -d "$selected_item" ]; then
    cp -r "$selected_item" .
    echo "Copied directory $(basename "$selected_item") to the current directory."
else
    cp "$selected_item" .
    echo "Copied file $(basename "$selected_item") to the current directory."
fi
