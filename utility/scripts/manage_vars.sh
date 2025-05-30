#!/bin/bash

# Path to custom environment file
VARS_FILE="$HOME/.vars"

# Function for showing usage
usage() {
  echo "Usage:"
  echo "  $0 set VAR_NAME VALUE     # Set or update a variable"
  echo "  $0 del VAR_NAME           # Delete a variable"
  echo "  $0 list                   # List current variables"
  echo "  $0 help                   # Show this help message"
  exit 1
}

# Check for correct arguments
[ $# -lt 1 ] && usage

# Set or update a variable
if [ "$1" == "set" ]; then
  if [ $# -ne 3 ]; then
    usage
  fi
  VAR="$2"
  VAL="$3"

  # Remove old export of this variable if it exists
  sed -i "/^export $VAR=/d" "$VARS_FILE"
  
  # Append the new export to .vars file
  echo "export $VAR=\"$VAL\"" >> "$VARS_FILE"

  # Export the variable in the current session
  export "$VAR=\"$VAL\""

  echo "Set $VAR=\"$VAL\""
  source "${HOME}/.bashrc"
  exit 0
fi

# Delete a variable
if [ "$1" == "del" ]; then
  if [ $# -ne 2 ]; then
    usage
  fi
  VAR="$2"
  
  # Remove the variable from the .vars file
  sed -i "/^export $VAR=/d" "$VARS_FILE"

  # Unset the variable from the current session
  unset "$VAR"

  echo "Deleted $VAR"
  exit 0
fi

# List saved variables
if [ "$1" == "list" ]; then
  echo "Current variables in $VARS_FILE:"
  cat "$VARS_FILE"
  exit 0
fi

# Help option
if [ "$1" == "help" ]; then
  usage
fi

# If we get here, something went wrong with the arguments
usage
