require("globals.globals")
require("per-device/variables")

-- ==================
-- MONITOR CONFIG
-- ==================

hl.on("window.active", function()
end)

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

for _, monitor in ipairs(MONITORS) do
    hl.monitor({ output = monitor.output, mode = monitor.mode, position = monitor.position, scale = monitor.scale })

    for i = monitor.minWorkspace,monitor.maxWorkspace do
        hl.workspace_rule({ workspace = i, monitor = monitor.output })
    end
end

-- ==================
-- ENVIRONMENT VARS
-- ==================

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")
hl.env("TERMINAL", "alacritty")

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- ==================
-- STARTUP APPS
-- ==================
hl.on("hyprland.start", function ()
    hl.exec_cmd("bash -c 'wl-paste --watch cliphist store &'")
    hl.exec_cmd("/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")
    hl.exec_cmd("vicinae server &")
    hl.exec_cmd("kdeconnectd")
    hl.exec_cmd("xdg-settings set default-web-browser vivaldi_vivaldi-stable.desktop ")

    if CURRENT_UI == QuickshellUI.DMS 
    then
      hl.exec_cmd("dms run")
    elseif CURRENT_UI == QuickshellUI.NOCTALIA 
    then
        hl.exec_cmd("qs -c noctalia-shell")
    end
end)


-- ==================
-- INPUT CONFIG
-- ==================
hl.config({
    input = {
        kb_model = "",
        kb_rules = "",

        repeat_rate = 50,
        repeat_delay = 200,

        follow_mouse = 1,

        force_no_accel = true,
        sensitivity = 0,
        accel_profile = "flat",

        kb_layout = "us,de",
        kb_variant = ",",
        kb_options = "grp:win_space_toggle",

        touchpad = {
            natural_scroll = false
        }
    }
})

-- ==================
-- GENERAL LAYOUT
-- ==================
hl.config({
    general = {
        gaps_in = 2.5,
        gaps_out = 5,
        border_size = 2,

        col = {
            -- active_border = "rgba(D65D0Eaa)",
            active_border = "rgba(458588aa)",
            inactive_border = "rgba(595959aa)"
        },

        resize_on_border = false,

        allow_tearing = false,

        layout = "dwindle"
    },

-- ==================
-- DECORATION
-- ==================
    decoration = {
        rounding = 5,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    -- ==================
    -- ANIMATIONS
    -- ==================
    animations = {
        enabled = true,
    }
})

hl.animation({ enabled = true, leaf = "windowsIn", speed = 1, bezier = "default" })
hl.animation({ enabled = true, leaf = "windowsOut", speed = 1, bezier = "default" })
hl.animation({ enabled = true, leaf = "workspaces", speed = 5, bezier = "default" })
hl.animation({ enabled = true, leaf = "windowsMove", speed = 1, bezier = "default" })
hl.animation({ enabled = true, leaf = "fade", speed = 1, bezier = "default" })
hl.animation({ enabled = true, leaf = "border", speed = 1, bezier = "default" })

-- ==================
-- LAYOUTS
-- ==================
hl.config({
    dwindle = {
        preserve_split = true
    }
})

hl.config({
    master = {
        mfact = 0.5
    }
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})


hl.window_rule({
    name = "scratchpad-orange-border",
    match = { workspace = "special:magic" },
    border_color = "rgb(FFA500)",
})


-- ==================
-- MISC
-- ==================
hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 1
    }
})

-- ==================
-- KEYBINDINGS
-- ==================

local terminal = "alacritty"
local fileManager = "dolphin"
local menu = "vicinae open"

local mainMod = "SUPER"

if CURRENT_UI == QuickshellUI.DMS 
then
    -- dms
    hl.bind(mainMod .. " + ALT + l", hl.dsp.exec_cmd("dms ipc call lock lock"))
elseif CURRENT_UI == QuickshellUI.NOCTALIA 
then
    -- noctalia
    hl.bind(mainMod .. " + ALT + l", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call lockScreen lock"))
end

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ internal = 1 }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ internal = 2 }))

hl.bind(mainMod .. " + ALT + F", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))


hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

for i = 11, 20 do
    local key = i % 10
    hl.bind(mainMod .. " + CONTROL + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + CONTROL + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

for i = 21, 30 do
    local key = i % 10
    hl.bind(mainMod .. " + ALT + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + ALT + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end
