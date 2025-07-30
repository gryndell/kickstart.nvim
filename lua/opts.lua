--[[ opts.lua ]]

local opt = vim.opt

--{{ Context
opt.colorcolumn = '80'      -- str:  Show col for max line length
opt.number = true           -- bool: Show line numbers
opt.relativenumber = true   -- bool: Show relative line numbers
opt.scrolloff = 4           -- int:  Min num lines of context
opt.signcolumn = "number"   -- str:  Show the sign column
--}}} Context

--{{{ Encoding
opt.encoding = 'utf8'       -- str:  String encoding to use
opt.fileencoding = 'utf8'   -- str:  File encoding to use
--}}} Encoding

--{{{ Theme
opt.syntax = "ON"           -- str:  Allow syntax highlighting
opt.termguicolors = true    -- bool: If term supports ui color then enable
opt.pumheight = 10          -- Makes popup menu smaller
opt.ruler = true            -- Show cursor position always
opt.cmdheight = 2
opt.iskeyword = opt.iskeyword + '-'     -- Treat '-' as a word break
opt.conceallevel = 0        -- Initialise conceallevel
-- opt.cursorline = true       -- Highlight the current line
-- opt.cursorcolumn = true     -- Highlight the current column
opt.updatetime = 300        -- Faster completion
opt.formatoptions = 'tqj'
opt.clipboard = 'unnamedplus'
opt.path = opt.path + '**'
opt.swapfile = false
opt.showcmd = true
opt.helplang = 'en'
opt.viewoptions = 'folds,options,cursor,curdir'
opt.listchars = 'tab:»»,trail:·,nbsp:␣,extends:→,precedes:←'
opt.list = true
opt.fileformat = 'unix'
opt.autoread = true
opt.wildmode = 'longest,list,full'
opt.wildmenu = true
opt.lazyredraw = true
opt.showmatch = true
opt.tags = 'tags'
opt.guifont = 'Hack Nerd Font Mono 16'
--}} Theme

--{{{ Search
opt.ignorecase = true       -- bool: Ignore case in search patterns
opt.smartcase = true        -- bool: Override ignorecase if search contains capitals
opt.infercase = true
opt.incsearch = true        -- bool: Use incremental search
opt.hlsearch = true         -- bool: Highlight search matches
--}}} Search

--{{{ White Space
opt.tabstop = 4             -- num:  Number of spaces tabs count for
opt.shiftwidth = 4          -- num:  Size of an indent
opt.softtabstop = 4         -- num:  Number of spaces tabs count for in insert mode
opt.smarttab = true         -- Makes tabbing smarter/adaptive
opt.expandtab = true        -- bool: Use spaces instead of tabs
opt.smartindent = true      -- Makes indenting smart
opt.autoindent = true       -- Autoinserts indents
opt.backspace = 'indent,eol,start'
opt.joinspaces = true
--}}} White Space

--{{{ Splits
opt.splitright = false      -- bool: Place new window to left of current one
opt.splitbelow = false      -- bool: Place new window above the current one
--}}} Splits

-- Mouse
opt.mouse = 'a'

-- vim: foldmethod=marker

