#!/bin/bash

# if alacritty is open, create a new window, otherwise create new
# instance

if  $(pgrep alacritty > /dev/null)  ; then
  alacritty msg create-window
else
  /Applications/Alacritty.app/Contents/MacOS/alacritty
fi
