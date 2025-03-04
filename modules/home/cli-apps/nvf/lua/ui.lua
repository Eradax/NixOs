require('tokyonight').setup {
    transparent = false,
}
vim.cmd [[colorscheme tokyonight-night]]



-----------------
-- About noice --
-----------------
require("noice").setup({
    routes = {
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                    { find = "%d fewer lines" },
                    { find = "%d more lines" },
                },
            },
            opts = { skip = true },
        }
    },
})


----- neo-tree -----
-- https://github.com/nvim-neo-tree/neo-tree.nvim
require("neo-tree").setup({
    add_blank_line_at_top = false,
    auto_clean_after_session_restore = false,
    default_source = "filesystem",
    enable_cursor_hijack = false,
    enable_diagnostics = true,
    enable_git_status = true,
    enable_modified_markers = true,
    enable_opened_markers = true,
    enable_refresh_on_write = true,
    git_status_async = false,
    hide_root_node = false,
    log_level = "info",
    log_to_file = false,
    open_files_do_not_replace_types = {
        "terminal",
        "Trouble",
        "qf",
        "edgy"
    },
    open_files_in_last_window = true,
    retain_hidden_root_indent = false,
    window = {
        width = 30
    }
})


----- smart column ------
-- https://github.com/m4xshen/smartcolumn.nvim
require("smartcolumn").setup({
    colorcolumn = { "80", "100" },
    custom_colorcolumn = {},
    disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "NvimTree",
        "alpha"
    }
})

----------------------
-- About bufferline --
----------------------
require("bufferline").setup({
    options = {
        -- mode = 'tabs',
        numbers = 'none',
        close_command = 'bdelete! %d',
        right_mouse_command = '',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = 'bdelete! %d',

        indicator = {
            -- icon = ' ', -- '▎',
            -- style = "icon",
            style = "none",
        },

        left_trunc_marker = '…',
        right_trunc_marker = '…',

        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',

        -- reserve space for neo-tree
        offsets = { {
            filetype = "neo-tree",
            -- text = vim.fn.getcwd,
            -- text_align = "right"
            text = "File Explorer",
            text_align = "center",
        } },

        color_icons = true,

        persist_buffer_sort = true,
        -- separator_style = "thin",
        -- enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = 'id',
    },
})


---- project nvim -----
-- https://github.com/ahmedkhalf/project.nvim
-- auto cd into project root
require('project_nvim').setup({
    detection_methods = {
        "lsp",
        "pattern"
    },
    exclude_dirs = {},
    lsp_ignored = {},
    manual_mode = true,
    patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "flake.nix",
        "cargo.toml"
    },
    scope_chdir = "global",
    show_hidden = false,
    silent_chdir = true
})


---- colorizer ----
-- https://github.com/norcalli/nvim-colorizer.lua
require('colorizer').setup({
    filetypes = { "*" },
    user_default_options = {
        RGB      = true,  -- #f0f hex codes
        RRGGBB   = true,  -- #ff00ff hex codes
        RRGGBBAA = true,  -- #ff00ff00 hex codes
        rgb_fn   = true,  -- CSS rgb(255, 0, 255) and rgba() functions
        hsl_fn   = true,  -- CSS hsl(300, 100%, 50%) and hsla() functions

        names    = false, -- "Name" codes like Blue
        css      = false,  -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn   = false,  -- Enable all CSS *functions*: rgb_fn, hsl_fn

        -- Available modes: foreground, background, virtualtext
        mode     = 'background', -- set the display mode
        tailWind = true,
        virtualtext = "■",

        -- enable sass colors
        sass = {
            enable = false,
            parsers = { "css" },
        },

        -- update colors even if the buffer isn't focused
        always_update = false
    },
    buftypes = {},
})

-- NOTE: ccc breaks nixd :)

----- nvim ufo ------
local ufo = require('ufo')
ufo.setup()

vim.o.foldcolumn = '0' -- '1' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- fold are built in, see binds here
-- za - toggle fold under cursor
-- zA - toggle fold under cursor recursively
-- https://neovim.io/doc/user/fold.html#fold-commands
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
-- za toggle fold


---- highlight undo -------
--
require('highlight-undo').setup({
    duration = 500,
    highlight_for_count = true,
    undo = {
        -- hlgroup = HighlightUndo, -- what is this defines as?
        mode = 'n',
        lhs = 'u',
        map = 'undo',
        opts = {}
    },


    redo = {
        -- hlgroup = HighlightUndo,
        mode = 'n',
        lhs = '<C-r>',
        map = 'redo',
        opts = {}
    },
})


------ indent blank line -------
-- https://github.com/lukas-reineke/indent-blankline.nvim
require("ibl").setup({
    debounce = 200,
    indent = {
        char = "│",
        priority = 1,
        repeat_linebreak = true,
        smart_indent_cap = true
    },
    scope = {
        char = "│",
        enabled = true,
        exclude = {
            language = {},
            node_type = {
                ["*"] = {
                    "source_file",
                    "program"
                },
                lua = {
                    "chunk"
                },
                python = {
                    "module"
                }
            }
        },
        include = {
            node_type = {}
        },
        injected_languages = true,
        priority = 1024,
        show_end = false,
        show_exact_scope = false,
        show_start = false
    },
    viewport_buffer = {
        max = 500,
        min = 30
    },
    whitespace = {
        remove_blankline_trail = true
    }
})
