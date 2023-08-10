#!/bin/sh
# ==========================================
# Basic .xinitrc Configuration
# ==========================================
# This file is run by startx command, it starts the graphical interface

# ==========================================
# Keyboard Layout
# ==========================================
# Set your keyboard layout if it's not US, uncomment the line and replace 'de' with your layout
# setxkbmap de

# ==========================================
# Xresources
# ==========================================
# Merge Xresources, this is where you define your terminal's look among other things
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# ==========================================
# xmodmap
# ==========================================
# xmodmap can be used to change keymaps
# If you have an .Xmodmap file in your home directory, uncomment this line to use it
# xmodmap ~/.Xmodmap

# ==========================================
# ssh-agent
# ==========================================
# If you use SSH, this will start ssh-agent upon login
# eval $(ssh-agent)

# ==========================================
# Startup Programs
# ==========================================
# Start any programs that you want to run at login
# For example, to start a terminal, uncomment the following line:
# xterm &

# ==========================================
# DPI
# ==========================================
# If you have a High DPI monitor, you might need to set the DPI for X
# xrandr --dpi 192

# ==========================================
# Start the Window Manager
# ==========================================
# Make sure to exec the command, so that it replaces this shell with the window manager
# The following line will start i3
exec i3

# You can replace 'i3' with your preferred window manager
# Be sure to comment out the 'exec i3' line if you do
# exec awesome
# exec bspwm
# exec dwm

# Remember to make this file executable by running chmod +x ~/.xinitrc
