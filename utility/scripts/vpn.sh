#!/bin/bash

#This scripts is to star openvpn with simplier line.

if [ "$#" -ne 1 ]; then
    echo "Usage: vpn <filename>.ovpn"
    exit 1
else
    sudo openvpn $1
fi

