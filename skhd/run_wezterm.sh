#!/bin/bash

# if alacritty is open, create a new window, otherwise create new
# instance

if  $(pgrep alacritty > /dev/null)  ; then
  wezterm cli spawn --new-window
else
  /Applications/Wezterm.app/Contents/MacOS/wezterm
fi
