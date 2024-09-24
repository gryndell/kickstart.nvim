--[[ colorscheme.lua ]]
vim.opt.background = 'dark'
vim.cmd.colorscheme("monokai-nightasty")
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
