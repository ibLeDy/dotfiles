#!/bin/bash
mkdir -p .config
mkdir -p /etc/{X11,default}
cp ~/.config/extensions-sync.json .config
cp /etc/X11/xorg.conf /etc/X11/
cp /etc/default/grub /etc/default/
