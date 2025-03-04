-- This is not the final init.lua but its good to control the order
-- of things.

local modules = {
    "lua.misc",

    "lua.lsp",
    "lua.mappings",
    "lua.mouse",
    "lua.reload",
    "lua.text",

    "lua.ui",
    "lua.plugins.lualine",

    -- setting the theme in ui also sets spell color
    "lua.spell",

    "lua.plugins.telescope",
    "lua.plugins.todo-comments", -- has to be after telescope
    "lua.plugins.cell-auto",
    "lua.plugins.dap",
    "lua.plugins.image", -- FIXME: 02/11 borken
    "lua.plugins.luasnip",
    "lua.plugins.neorg",
    "lua.plugins.toggleterm",
}

-- Refresh module cache
for _, v in pairs(modules) do
    package.loaded[v] = nil
    require(v)
end
