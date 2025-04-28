#!/bin/bash

# Source directory
SOURCE_DIR="/home/rall4/penplate/utility/github-scripts"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# List the scripts in the source directory
echo "Available scripts:"
files=("$SOURCE_DIR"/*.sh)  # Get all .sh files
for i in "${!files[@]}"; do
    # Extract the filename from the path
    filename=$(basename "${files[i]}")
    echo "$((i + 1)). $filename"
done

# Prompt user for selection
read -p "Enter the number of the script you want to copy: " choice

# Validate the input
if [[ ! "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#files[@]}" ]; then
    echo "Invalid choice. Please run the script again."
    exit 1
fi

# Copy the selected script to the current directory
selected_file="${files[$((choice - 1))]}"
cp "$selected_file" .

# Confirm the copy
echo "Copied $(basename "$selected_file") to the current directory."
