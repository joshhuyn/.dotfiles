return {
    {
        'ofirgall/ofirkai.nvim'
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        'uloco/bluloco.nvim',
        lazy = false,
        priority = 1000,
        dependencies = { 'rktjmp/lush.nvim' },
        config = function()
            -- your optional config goes here, see below.
        end,
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "rose-pine/neovim", name = "rose-pine"
    },
    {
        'nyoom-engineering/oxocarbon.nvim'
    }
}
