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

--{{{ Completion
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- nvim-cmp supports additional completion capabilities, so broadcast to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}


---}}} Completion

-- vim: ts=2 sts=2 sw=2 et foldmethod=marker
