-- modules/keybindings.lua
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mod = "SUPER"

local terminal = "kitty"
local fileManager = "nautilus"
local menu = "fuzzel"
local browser = "zen-browser"
local altBrowser = "brave"

-- Terminal
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))

-- Close window
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())

-- Exit / logout menu
hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd("~/.config/hypr/scripts/logout-menu.sh"))

-- Apps
hl.bind(mod .. " + SHIFT + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd(altBrowser))
hl.bind(mod .. " + Z", hl.dsp.exec_cmd("zed"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("flatpak run com.github.johnfactotum.Foliate"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd("gnome-text-editor"))
hl.bind(mod .. " + SHIFT + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("brave --app=https://web.whatsapp.com"))
hl.bind(mod .. " + slash", hl.dsp.exec_cmd("bitwarden-desktop"))

-- Window management
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + SHIFT + J", hl.dsp.layout("togglesplit"))

-- Toggle waybar
hl.bind(mod .. " + W", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))

-- Lock screen
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Screenshots (requires grim, slurp, swappy, wl-clipboard)
-- Print         : interactive region  -> open in swappy
-- SHIFT + Print : full screen         -> open in swappy
-- Mod+SHIFT+C   : interactive region  -> copy to clipboard only
-- Screenshots (requires grim, slurp, swappy, wl-clipboard)
hl.bind(
	"Print",
	hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/hypr/scripts/screenshot.sh region"),
	{ locked = true }
)
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/hypr/scripts/screenshot.sh fullscreen"),
	{ locked = true }
)
hl.bind(
	mod .. " + SHIFT + C",
	hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/hypr/scripts/screenshot.sh copy"),
	{ locked = true }
)
-- Move focus with mod + hjkl
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces / move windows to workspace
for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume and brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media keys (requires playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
