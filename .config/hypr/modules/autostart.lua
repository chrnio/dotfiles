-- modules/autostart.lua
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local terminal = "kitty"
local browser = "firefox"

hl.on("hyprland.start", function()
	hl.exec_cmd(terminal)
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd(browser)
end)
