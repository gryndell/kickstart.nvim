-- [[ init.lua ]]--

-- [[ Load Configs ]]--
require('vars')             -- Load variables
require('opts')             -- Load options
require('keymaps')          -- Load keymaps
require('plugins')          -- Load plugins
require('colorscheme')      -- Load colorscheme
require('functions')        -- Load custom functions
require('aucommands')       -- Load autocommands

require('bufferline').setup{}

--{{{ Markdown
vim.g.markdown_mdl_executable = 'mdl'
vim.g.markdown_mdl_options = ''
vim.g.markdown_fenced_languages = {
  'html', 'python', 'lua', 'vim', 'typescript', 'javascript', 'css', 'bash',
  'sh', 'json', 'yaml', 'c', 'cpp', 'go', 'rust', 'pandoc', 'fish'
}
vim.g.table_mode_corner = '|'
--}}} Markdown

--{{{ Table Mode
vim.cmd [[
  " Markdown-compatible tables with vim-table-mode
  let g:table_mode_corner = '|'
]]
--}}} Table Mode

--{{{ Wrap conditions
vim.cmd [[
  set whichwrap=b,s,h,l,<,>,[,]
]]
--}}} Wrap conditions

--{{{ Codeium
vim.cmd [[
  let g:codeium_filetypes = {
    \ "markdown": v:true,
    \ "pandoc": v:true,
    \ }
]]
--}}} Codeium

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et foldmethod=marker
