-- ------------------
-- MY PROGRAMS
-- ------------------

 -- Sets "Windows" (<>) key as main modifier
local mainMod = "SUPER"
-- Terminal emulator
local terminal = "foot"
-- Prefered filemanager (e.g.: dolphin)
local filemanager = "thunar"
-- Application launcher
local rofi_cmd = "rofi -show-icons"
-- Shows a combined list of the applications with desktop files and executables from PATH.
local menu = rofi_cmd .. " -show combi -combi-modes drun"


-- ------------
-- KEYBINDINGS
-- ------------

---------------
-- System

-- Kill // Exit hypr with confirmation (log out of Wayland session) // <><Shift> e ##
hl.bind(mainMod .. " + SHIFT + E", function()
    local utils = require("utils")
    local lock_file = "/tmp/exit.lock"
    if utils.exists(lock_file) then
      -- delete lock file and exit
      os.remove(lock_file)
      hl.dispatch(hl.dsp.exit())
    else
      hl.notification.create({
        text = "Rerun command to exit",
        timeout = 10000,
        color= "rgb(ff1ea3)",
      })
      local f = io.open(lock_file, "w")
      f:write("exit session")
      f:close()
      -- remove file if nothing was done by user
      hl.dispatch(hl.dsp.exec_cmd("sleep 10 && rm " .. lock_file))
    end
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


---------------
-- Apps

-- Launch // Terminal // <> Enter ##
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))

-- Launch // Terminal in directory of currently focused windows, if any // <><Alt> Enter ##
hl.bind(mainMod .. "+ Alt_L", hl.dsp.exec_cmd("run-cwd-hypr " .. terminal))
-- hl.bind(mainMod .. " + Alt_l + Return", hl.dsp.exec_cmd("run-cwd-hypr terminal"))
-- hl.bind(mainMod .. " + alt_l + Return", hl.dsp.exec_cmd(menu))

-- Launch // Browser // <><Shift> Enter ##
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("gtk-launch $(xdg-settings get default-web-browser)"))

-- Launch // Application launcher // <> d ##
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

-- Launch // File manager // <> m ##
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(filemanager))

-- Launch // Lock screen // <> z ##
-- bind = $mainMod, Z, exec, swaylock -f
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("loginctl lock-session"))

-- Clipboard manager
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))

-- Capture the currently active output to clipboard (no mod key, so empty)
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grimshot copy output,"))
-- Capture the currently active window to clipboard
hl.bind("SHIFT + Alt_L + Print", hl.dsp.exec_cmd("grimshot copy active"))
-- Select and capture a custom rectangular area to clipboard
hl.bind("SHIFT + Control_L + Print", hl.dsp.exec_cmd("grimshot copy area"))

-- Same than above, but for Logitech MX-Keys.
-- It send <Mod4+Shift+s> when PrintScr is pressed.
-- bind = MOD4 SHIFT ALT, S, exec, grimshot copy active # this is ALT PRINT on MX-Keys
hl.bind("MOD4 + SHIFT + CTRL + S", hl.dsp.exec_cmd("grimshot copy area"))
hl.bind("CTRL + SHIFT + P", hl.dsp.exec_cmd("grimshot copy area"))

---------------
-- Windows

-- Kill // Focused window // <><Shift> q ##
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

-- Fullscreen mode
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- Toggle the current focused window between tiling and floating mode
hl.bind(mainMod .. " + SHIFT + Space", function()
    local activewindow = hl.get_active_window()
    if activewindow.floating then
      hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    else
      local activemonitor = hl.get_active_monitor()
      hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
      hl.dispatch(hl.dsp.window.resize({ x=activemonitor.width * 70 / 100, y=activemonitor.height * 70 / 100 }))
      hl.dispatch(hl.dsp.window.center())
    end
end)

-- Cycle focus through windows of active workspace
hl.bind(
    mainMod .. " + TAB",
    function()
        local cmp = function(a,b) return a.pid < b.pid end
        local windows_in_ws = hl.get_windows({workspace=hl.get_active_workspace()})
        table.sort( windows_in_ws, cmp )
        local n_windows = #windows_in_ws
        local current_window_idx = 1
        if n_windows > 1 then
          for k,v in pairs(windows_in_ws) do
            if v == hl.get_active_window() then
              current_window_idx = k
              break
            end
          end
          next_idx = (current_window_idx % n_windows) + 1
          hl.dispatch ( hl.dsp.focus({ window = windows_in_ws[next_idx]}) )
        end
    end
)


-- Dwindle layout
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- R for rotate
hl.bind(mainMod .. " + R", hl.dsp.layout("togglesplit"))

-- S for swap
hl.bind(mainMod .. " + S", hl.dsp.layout("swapsplit"))


-- Navigate // Move your focus around // <> ↑ ↓ ← → ##
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Modify // Move the focused window with the same, but add Shift // <><Shift> ↑ ↓ ← → ##
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Resize windows
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse dragging: mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())


---------------
-- Workspaces

-- Navigate // Workspaces 1-10 // <> 0..9
-- Modify // Move active window to Workspace 1 - 10 // <><Shift> 0..9
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow=false }))
end


-- Dedicated special workspace for scratchpad
hl.bind(mainMod .. " + MINUS", hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mainMod .. " + SHIFT + MINUS", hl.dsp.window.move({ workspace = "special:scratch", follow = false }))

-- Another dedicated special workspace as backup
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic", follow = false }))


---------------
---------------
---------------
---------------
---------------



function printTable(t, f)

  file = io.open(f,"w")

   local function printTableHelper(obj, cnt)
      local cnt = cnt or 0

      if type(obj) == "table" then

         file:write("\n", string.rep("\t", cnt), "{\n")
         cnt = cnt + 1

         for k,v in pairs(obj) do

            if type(k) == "string" then
               file:write(string.rep("\t",cnt), '["'..k..'"]', ' = ')
            end

            if type(k) == "number" then
               file:write(string.rep("\t",cnt), "["..k.."]", " = ")
            end

            printTableHelper(v, cnt)
            file:write(",\n")
         end

         cnt = cnt-1
         file:write(string.rep("\t", cnt), "}")

      elseif type(obj) == "string" then
         file:write(string.format("%q", obj))

      else
         file:write(tostring(obj))
      end
   end

   if f == nil then
      printTableHelper(t)
   else
      file:write("return")
      printTableHelper(t)
      file:close()
   end
end





hl.bind(mainMod .. " + SHIFT + W", function()
    -- some logic...
    --
     local activewindow = hl.get_active_window()
    printTable(hl.dsp.window.move, "/home/gcalmettes/out.log")
end)

-- function toggle() {
-- 	width=$1
-- 	height=$2
--
-- 	# hyprctl --batch "dispatch togglefloating; dispatch resizeactive exact ${width} ${height}; dispatch centerwindow"
--   # hyprctl --batch "dispatch hl.dsp.window.float({action=\"toggle\"}); dispatch hl.dsp.window.center(); dispatch hl.dsp.window.resize({x=\"${width}\",y=\"${height}\"})"
--   hyprctl --batch "dispatch hl.dsp.window.float({action=\"toggle\"}); dispatch hl.dsp.window.center()"
-- }
--
-- function untoggle() {
-- 	hyprctl dispatch "hl.dsp.window.float({action=\"toggle\"})"
-- }
--
-- function handle() {
-- 	width=$1
-- 	height=$2
--
-- 	if [ "$floating" == "false" ]; then
-- 		toggle "$width" "$height"
-- 	else
-- 		untoggle
-- 	fi
-- }
--
-- case $window in
-- foot) handle "50%" "55%" ;;
-- *) handle "80%" "75%" ;;
-- esac




