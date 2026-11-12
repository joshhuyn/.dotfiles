require("..globals.globals")

CURRENT_UI = QuickshellUI.DMS

-- {
--     output = "HDMI-A-1",
--     mode = "3840x2160@60",
--     position = "0x0",
--     scale = 1,
--
--     minWorkspace = 21,
--     maxWorkspace = 30
-- },

-- MONITORS = {
--     {
--         output = "eDP-1",
--         mode = "1920x1080@60",
--         position = "0x0",
--         scale = 1,
--         disabled = true,
--
--         minWorkspace = 11,
--         maxWorkspace = 20
--     },
--     {
--         output = "DP-5",
--         mode = "2560x1440@60",
--         position = "1920x0",
--         scale = 1,
--
--         minWorkspace = 1,
--         maxWorkspace = 10
--     },
--     {
--         output = "DP-4",
--         mode = "3840x2160@60",
--         position = "0x0",
--         scale = 2,
--
--         minWorkspace = 1,
--         maxWorkspace = 10
--     },
--     {
--         output = "DP-3",
--         mode = "1920x1080@60",
--         position = "4480x0",
--         scale = 1,
--
--         minWorkspace = 1,
--         maxWorkspace = 10
--     },
--     -- {
--     --     output = "DP-5",
--     --     mode = "3840x2160@60",
--     --     position = "5760x0",
--     --     scale = 1,
--     --
--     --     minWorkspace = 21,
--     --     maxWorkspace = 30
--     -- },
-- }

MONITORS = {
    {
        output = "DP-4",
        mode = "1920x1080@60",
        position = "0x0",
        scale = 1,

        minWorkspace = 11,
        maxWorkspace = 20
    },
    {
        output = "DP-3",
        mode = "1920x1080@60",
        position = "1920x0",
        scale = 1,

        minWorkspace = 1,
        maxWorkspace = 10
    },
    {
        output = "eDP-1",
        mode = "1920x1080@60",
        position = "3840x0",
        scale = 1,

        minWorkspace = 21,
        maxWorkspace = 30
    },
}
