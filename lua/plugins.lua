--[[ plugins.lua ]]
-- Install `lazy.nvim` plugin manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Use words in buffer
      'hrsh7th/cmp-buffer',

      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Autocompletion in the command line
      'hrsh7th/cmp-cmdline',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk,
          { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer,
          { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk,
          { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis,
          { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame,
          { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted,
          { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>',
          { desc = 'select git hunk' })
      end,
    },
  },

-- {
--   -- Theme inspired by Atom
--   'navarasu/onedark.nvim',
--   priority = 1000,
--   lazy = false,
--   config = function()
--     require('onedark').setup {
--       -- Set a style preset. 'dark' is default.
--       style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
--       no_italic = false,
--       no_bold = false,
--       no_underline = false,
--     }
--     require('onedark').load()
--     vim.cmd [[ highlight Normal guibg=NONE ]]
--     vim.cmd [[ highlight EndOfBuffer guibg=NONE ]]
--   end,
-- },

  {
    -- Monokai-Nightasty
    "polirritmico/monokai-nightasty.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      { "<leader>tt", "<Cmd>MonokaiToggleLight<CR>", desc = "Monokai-Nightasty: Toggle dark/light theme." },
    },
    ---@type monokai.UserConfig
    opts = {
      dark_style_background = "transparent", -- default, dark, transparent, #color
      light_style_background = "default", -- default, dark, transparent, #color
      color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
      lualine_bold = true, -- Lualine a and z sections font width
      lualine_style = "dark", -- "dark", "light" or "default" (Follows dark/light style)
      markdown_header_marks = true, -- Add headers marks highlights (the `#` character) to Treesitter highlight query
      -- Style to be applied to different syntax groups. See `:help nvim_set_hl`
      hl_styles = {
        comments = { italic = false },
        keywords = { italic = true },
      },

      -- This also could be a table like this: `terminal_colors = { Normal = { fg = "#e6e6e6" } }`
      terminal_colors = function(colors)
        return { fg = colors.fg_dark }
      end,

      --- You can override specific color/highlights. Theme color values
      --- in `extras/palettes`. Also could be any hex RGB color you like.
      on_colors = function(colors)
        -- Custom color only for light theme
        local current_is_light = vim.o.background == "light"
        colors.comment = current_is_light and "#2d7e79" or colors.grey

        -- Custom color only for dark theme
        colors.border = not current_is_light and colors.magenta or colors.border

        -- Custom lualine normal color
        colors.lualine.normal_bg = current_is_light and "#7ebd00" or colors.green
      end,

      on_highlights = function(highlights, colors)
        -- You could add styles like bold, underline, italic
        highlights.TelescopeSelection = { bold = true }
        highlights.TelescopeBorder = { fg = colors.grey }
        highlights["@lsp.type.property.lua"] = { fg = colors.fg }
      end,
    },
    config = function(_, opts)
      -- Highlight line at the cursor position
      vim.opt.cursorline = true

      -- Default to dark theme
      vim.o.background = "dark"  -- dark | light

      require("monokai-nightasty").load(opts)
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = ' ', right = ' ' },
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more
        --       instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'go', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }

    end,
  },

  {
    'windwp/nvim-autopairs', -- pairs of parentheses etc.
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  'kshenoy/vim-signature',      -- show marks in gutter
  'dhruvasagar/vim-table-mode', -- table mode
  'gabrielelana/vim-markdown',  -- better markdown syntax highlighting
  -- 'Exafunction/codeium.vim',    -- AI assistant
  'vim-pandoc/vim-pandoc',      -- pandoc integration
  'vim-pandoc/vim-pandoc-syntax', -- pandoc syntax
  config = function ()
  -- Change '<C-g>' here to any keycode you like.
  vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end,
        { expr = true, silent = true })
  vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end,
        { expr = true, silent = true })
  end,
  {
    'akinsho/bufferline.nvim',  -- show buffers in tabline
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    highlights = {
      fill = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      background = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      buffer_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      close_button = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      close_button_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      tab_selected = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      tab = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      tab_close = {
        -- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
        fg = { attribute = "fg", highlight = "TabLineSel" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      duplicate_selected = {
        fg = { attribute = "fg", highlight = "TabLineSel" },
        bg = { attribute = "bg", highlight = "TabLineSel" },
        italic = true,
      },
      duplicate_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
        italic = true,
      },
      duplicate = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
        italic = true,
      },

      modified = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      modified_selected = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      modified_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },

      separator = {
        fg = { attribute = "bg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      separator_selected = {
        fg = { attribute = "bg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      -- separator_visible = {
      --   fg = {attribute='bg',highlight='TabLine'},
      --   bg = {attribute='bg',highlight='TabLine'}
      --   },
      indicator_selected = {
        fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
    },
  },
  {
    "wincent/loupe",
    lazy = false,
    config = function ()
      vim.o.grepformat = "%f:%l:%c:%m"
      vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
    end
  }, -- loupe
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- disable netrw at the start
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup ({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
      vim.cmd [[ highlight NvimTreeNormal guibg=NONE ]]
      vim.cmd [[ highlight NvimTreeEndOfBuffer guibg=NONE ]]
    end,
  }, -- nvim-tree
  {
    'MeanderingProgrammer/markdown.nvim',
    main = "render-markdown",
    opts = {},
    name = 'render-markdown',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
      }
  }, -- markdown.nvim
  {
    'kiddos/gemini.nvim',
    opts = {
      hints = {
        insert_result_key = '<Tab>',
      },
      completion = {
        insert_result_key = '<Tab>',
      },
      instruction = {
        menu_key = '<C-m>',
      },
    }
  }, -- gemini.nvim
})

local lspconfig = require("lspconfig")
lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
