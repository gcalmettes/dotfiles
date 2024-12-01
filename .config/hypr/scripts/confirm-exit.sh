#!/bin/bash

# Confirmation before exiting hyprland session
# Inspired by https://github.com/hyprwm/Hyprland/discussions/2125

LOCK="/tmp/exit.lock"

acquire_lock() {
  if [ -f "$LOCK" ]; then
    # delete existing lock and succeed
    rm $LOCK
    return 0
  else
    # create lock and return fail signal
    touch $LOCK
    return 1
  fi
}

if acquire_lock; then
  # session exit confirmed
  hyprctl dispatch exit
else
  # confirm before exiting. Do nothing otherwise
  hyprctl notify -0 10000 "rgb(ff1ea3)" "Rerun command to exit"
  sleep 10 && rm /tmp/exit.lock
fi
