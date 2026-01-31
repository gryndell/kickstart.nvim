--[[ colorscheme.lua ]]
vim.opt.background = 'dark'
vim.cmd.colorscheme("elflord")
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'yellow' })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'grey' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'grey' })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = 'grey' })
