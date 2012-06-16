#!/bin/bash

## Variables
export PATH="${PATH}:/home/.scripts:/usr/local/bin"
export BROWSER="firefox"
export LANG="en_US.utf8"
export LC_ALL="en_US.utf8"
export EDITOR="vim"

## Logout with ctrl+alt+backspace ##
#setxkbmap -option terminate:ctrl_alt_bksp &

## Keyboard layout switching ##
#(sleep 3s && setxkbmap -option grp:switch,grp:alt_shift_toggle us,gr) &

## rxvt-unicode invocation ##
urxvtd -q -o -f &

## Set the cursor 
xsetroot -cursor_name left_ptr

## Set background image ##
feh --bg-fill ~/Pictures/hex.png
#feh --bg-fill ~/Pictures/fly-fool.png &
#feh --bg-fill ~/Pictures/podia.png &

## Apps to start when login ##
#(sleep 2s && fbxkb) &
#(sleep 3s && pidgin) &
#(sleep 5s && dropboxd) &
#(sleep 4s && skype) &
#ssh -X -p 20022 -D 50001 -f -C -N -i ~/.ssh/foss_rsa axil@foss

## Start session | order of launches important when it comes for mounting devices ##
exec ck-launch-session dbus-launch xmonad

 
