--[[ colorscheme.lua ]]

-- require('onedark').setup {
--     -- Set a style preset. 'dark' is default.
--     style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
--     no_italic = false,
--     no_bold = false,
--     no_underline = false,
-- }
-- require('onedark').load()
vim.opt.background = 'dark'
vim.cmd.colorscheme("monokai-nightasty")
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })

