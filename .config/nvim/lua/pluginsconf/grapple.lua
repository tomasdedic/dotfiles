

require("telescope").load_extension("grapple")
require("grapple").setup({
    -- save_path = vim.fs.joinpath(vim.fn.stdpath("data"), "grapple"),
    scope = "global",
    scopes = {},
    -- default_scopes = { ... },
    icons = true,
    status = true,
    name_pos = "end",
    style = "relative",
    quick_select = "123456789",
    command = vim.cmd.edit,
    prune = "30d",
    tag_title = nil,
    scope_title = nil,
    loaded_title = nil,
    win_opts = {
        -- Can be fractional
        width = 80,
        height = 12,
        row = 0.5,
        col = 0.5,

        relative = "editor",
        border = "single",
        focusable = false,
        style = "minimal",
        title_pos = "center",
        title = "Grapple",
        title_padding = "",
    },
})
