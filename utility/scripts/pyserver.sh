#!/bin/bash

# Show IP info for tun0 interface
ip a | grep -i "tun0"

# Default port to 80 if not provided
if [ -z "$1" ]; then
  port=80
else
  port=$1
fi

# Start python http server on the specified port
sudo python3 -m http.server "$port"
