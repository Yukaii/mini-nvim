-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            {"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
            {"\nPress any key to exit..."}
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.wo.relativenumber = true

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- add your plugins here
        {
            'echasnovski/mini.nvim',
            version = '*',
            config = function()
                require('mini.basics').setup()
                require('mini.pairs').setup()
                require('mini.files').setup()
                require('mini.indentscope').setup()
                local hipatterns = require('mini.hipatterns')
                hipatterns.setup({
                    highlighters = {
                        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                        fixme = {
                            pattern = '%f[%w]()FIXME()%f[%W]',
                            group = 'MiniHipatternsFixme'
                        },
                        hack = {
                            pattern = '%f[%w]()HACK()%f[%W]',
                            group = 'MiniHipatternsHack'
                        },
                        todo = {
                            pattern = '%f[%w]()TODO()%f[%W]',
                            group = 'MiniHipatternsTodo'
                        },
                        note = {
                            pattern = '%f[%w]()NOTE()%f[%W]',
                            group = 'MiniHipatternsNote'
                        },

                        -- Highlight hex color strings (`#rrggbb`) using that color
                        hex_color = hipatterns.gen_highlighter.hex_color()
                    }
                })
                require('mini.starter').setup()
                require('mini.cursorword').setup()
                require('mini.statusline').setup()
                require('mini.tabline').setup()
                require('mini.icons').setup()
                require('mini.notify').setup()
                require('mini.git').setup()
                require('mini.diff').setup()
            end
        }, {'echasnovski/mini.icons', version = false, config = true},
        {'rebelot/kanagawa.nvim'}, {'lewis6991/gitsigns.nvim', config = true}
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = {colorscheme = {"habamax"}},
    -- automatically check for plugin updates
    checker = {enabled = true}
})

vim.cmd("colorscheme kanagawa")
