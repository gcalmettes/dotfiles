#!/bin/bash

# kill already running processes
_ps=(waybar)
for _prs in "${_ps[@]}"; do
  if pidof "${_prs}" > /dev/null; then
    pkill "${_prs}"
  fi
done

# setup and start waybar
ln -sf "$HOME/.config/waybar/config.d/hypr-style.css" "$HOME/.config/waybar/style.css"
ln -sf "$HOME/.config/waybar/config.d/hypr-config.jsonc" "$HOME/.config/waybar/config.jsonc"
waybar &
