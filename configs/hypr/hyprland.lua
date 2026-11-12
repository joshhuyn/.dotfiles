require("globals.globals")
require("per-device/variables")

-- ==================
-- MONITOR CONFIG
-- ==================

hl.on("window.active", function()
end)

-- somewhere in your Hyprland config
package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")

smw.setup({
    workspace_count = 10,
})

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- local smw = require("split-monitor-workspaces")
--
-- smw.setup({
--     workspace_count = 5,
-- })

for _, monitor in ipairs(MONITORS) do
    local isDisabled = monitor.disabled

    hl.monitor({ output = monitor.output, disabled = isDisabled, mode = monitor.mode, position = monitor.position, scale = monitor.scale })

    if not isDisabled then
        for i = monitor.minWorkspace,monitor.maxWorkspace do
            hl.workspace_rule({ workspace = i, monitor = monitor.output })
        end
    end
end

-- ==================
-- ENVIRONMENT VARS
-- ==================

hl.env("TERMINAL", "alacritty")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")

hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
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

    hl.exec_cmd("hyprpm reload")

    if CURRENT_UI == QuickshellUI.DMS
    then
      hl.exec_cmd("dms run")
    elseif CURRENT_UI == QuickshellUI.NOCTALIA 
    then
        hl.exec_cmd("qs -c noctalia-shell")
    end
end)


enableColemak=true
globalFloatingOpacity = 1

function setupInput()
    -- ==================
    -- INPUT CONFIG
    -- ==================
    local variant = ",qwerty"

    if not enableColemak then
        variant = "colemak,qwerty"
    end
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
            kb_variant = variant,
            kb_options = "grp:win_space_toggle",

            touchpad = {
                natural_scroll = false
            }
        }
    })
end

setupInput();

function updateWindowRule(opacity)
    opacity = 1 - opacity / 4

    if (opacity > 1) then
        opacity = 1
    elseif (opacity < 0) then
        opacity = 0
    end

    hl.window_rule({
        name = "opacity",
        match = {
            tag = "opacityVariable"
        },
        opacity = opacity,
        no_focus = true,
        no_blur = true
    })

    hl.dispatch(hl.dsp.window.pin({ action = "set" }))
end

hl.config { plugin = { dynamic_cursors = {
    enabled = true,
    mode = "stretch"
}}}


-- ==================
-- GENERAL LAYOUT
-- ==================
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 2.5,
        border_size = 1,

        col = {
            -- active_border = "rgba(D65D0Eaa)",
            -- catppuccin: active_border = "rgba(C6A0F6aa)",
            -- catppuccin: inactive_border = "rgba(59595900)"
            active_border = "rgba(D65D0EAA)",
            inactive_border = "rgba(59595900)"
        },

        resize_on_border = false,

        allow_tearing = false,

        layout = "dwindle"
    },

-- ==================
-- DECORATION
-- ==================
    decoration = {
        rounding = 15,
        rounding_power = 2.0,

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
        enabled = false,
    }
})

hl.animation({ enabled = true, leaf = "windowsIn", speed = 1, bezier = "default" })
hl.animation({ enabled = true, leaf = "windowsOut", speed = 1, bezier = "default" })
hl.animation({ enabled = true, leaf = "workspaces", speed = 5, bezier = "default", style = "slidevert"})
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
    -- catppuccin: border_color = "rgb(EE99A0)",
    border_color = "rgb(FE8019)",
})


-- ==================
-- MISC
-- ==================
hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 1,
        focus_on_activate = true
    }
})

-- ==================
-- KEYBINDINGS
-- ==================

local terminal = "alacritty"
local fileManager = "dolphin"
local menu = "vicinae open"
--local menu = "wmenu-run -if 'hack 14'"

local mainMod = "SUPER"

for i = 1, smw.get_amount_of_workspaces() do
    local n = tostring(i)
    if n == "10" then n = "0" end -- Optional if you configured 10 workspaces: bind workspace 10 to SUPER + 0
    -- Switch to the Nth workspace on the currently focused monitor.
    hl.bind(mainMod .. " +" .. n, smw.workspace(n))
    -- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
    hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end

-- TODO add move to monitor
hl.bind(mainMod .. " + SHIFT + z", function()
    -- hl.dsp.window.move({ workspace = 21 })
end)


hl.bind(mainMod .. " + E", smw.workspace("empty"))
hl.bind(mainMod .. " + SHIFT + E", smw.move_to_workspace("empty"))


if CURRENT_UI == QuickshellUI.DMS
then
    -- dms
    hl.bind(mainMod .. " + ALT + l", hl.dsp.exec_cmd("dms ipc call lock lock"))
elseif CURRENT_UI == QuickshellUI.NOCTALIA 
then
    -- noctalia
    hl.bind(mainMod .. " + ALT + l", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call lockScreen lock"))
end

hl.bind(mainMod .. " + Y", hl.dsp.window.tag({ tag = "opacityVariable" }))
hl.bind(mainMod .. " + SHIFT + Y", function()
    hl.window_rule({
        name = "opacity",
        match = {
            tag = "opacityVariable"
        },
        opacity = 1,
        no_focus = false,
        no_blur = false
    })

    local windows = hl.get_windows()
    for _, w in ipairs(windows) do
        hl.dispatch(hl.dsp.window.tag({ tag = "-opacityVariable", window = w }))
        hl.dispatch(hl.dsp.window.pin({ action = "unset", window = w }))
    end

    globalFloatingOpacity = 1
end)

hl.bind(mainMod .. " + N", function()
    setupInput()
    enableColemak = not enableColemak
end)

hl.bind(mainMod .. " + bracketleft", function()
    globalFloatingOpacity = globalFloatingOpacity + 1
    if (globalFloatingOpacity > 10) then
        globalFloatingOpacity = 10
    end

    updateWindowRule(globalFloatingOpacity)
end)


hl.bind(mainMod .. " + bracketright", function()
    globalFloatingOpacity = globalFloatingOpacity - 1
    if (globalFloatingOpacity < 0) then
        globalFloatingOpacity = 0
    end

    updateWindowRule(globalFloatingOpacity)
end)

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("JOH_ENABLE_TMUX='true' " .. terminal))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("JOH_ENABLE_TMUX='false' " .. terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
-- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ internal = 1 }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ internal = 2 }))

hl.bind(mainMod .. " + v", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + A", hl.dsp.workspace.toggle_special("magic2"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "special:magic2" }))


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
