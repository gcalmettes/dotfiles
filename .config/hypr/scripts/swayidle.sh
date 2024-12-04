#!/bin/bash

# Idle and lock configuration
#
# This will lock your screen after 300 seconds of inactivity, then turn off
# your displays after another 60 seconds, and turn your screens back on when
# resumed. It will also lock your screen before your computer goes to sleep.
# The timeouts can be customized via `$lock_timeout` and `$screen_timeout`
# variables. For a predictable behavior, keep the `$screen_timeout` value
# lesser than the `$lock_timeout`.
#
# You can also lock the screen manually by running `loginctl lock-session` or
# add a binding for the command. Example:
#     bindsym $mod+Shift+Escape  exec loginctl lock-session
#
# Note that all swaylock customizations are handled via /etc/swaylock/config and
# can be overridden via $XDG_CONFIG_HOME/swaylock/config (~/.config/swaylock/config).
#
# Requires: swayidle
# Requires: swaylock
# Requires: /usr/bin/pkill, /usr/bin/pgrep

lock_timeout=300
screen_timeout=60
suspend_timeout=900

LT=${lock_timeout:-300}
ST=${screen_timeout:-60}
SS_T=${suspend_timeout:-900}

swayidle -w \
    timeout $LT 'swaylock -f' \
    timeout $((LT + ST)) 'hyprctl dispatch dpms off' \
                  resume 'hyprctl dispatch dpms on'  \
    timeout $ST 'pgrep -xu "$USER" swaylock >/dev/null && hyprctl dispatch dpms off' \
         resume 'pgrep -xu "$USER" swaylock >/dev/null && hyprctl dispatch dpms on'  \
    timeout $SS_T 'systemctl suspend' \
        resume 'hyprctl monitors all | awk '"'"'/Monitor/ {print $2}'"'"' | xargs -I % hyprctl dispatch dmps on %' \
    before-sleep 'swaylock -f' \
    lock 'swaylock -f' \
    unlock 'pkill -xu "$USER" -SIGUSR1 swaylock'
