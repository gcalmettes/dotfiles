-- --------------
--  AUTOSTART
-- --------------

hl.on("hyprland.start", function()
    -- needed for waybar status
    hl.exec_cmd("nm-applet --indicator &")
    hl.exec_cmd("blueman-applet &")
    -- wallpaper image
    hl.exec_cmd("swaybg --image ~/.config/sway/wallpapers/milkyway.png --mode fill")
    -- swayidle
    hl.exec_cmd("$HOME/.config/hypr/scripts/swayidle.sh")
    -- start polkit agent
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- start waybar
    hl.exec_cmd("$HOME/.config/hypr/scripts/startup.sh")
    -- start clipboard manager
    -- https://github.com/sentriz/cliphist
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
end)

hl.on("config.reloaded", function()
    hl.exec_cmd("$HOME/.config/hypr/scripts/startup.sh")
end)

