-- Leader key setup
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic Options
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.guifont = { 'Comic Shanns Nerd Font Mono:h16', 'symbols' }
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Clipboard sync
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Key Mappings
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-CR>', ':copen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'q', '^', { noremap = true, silent = true })
vim.keymap.set('n', 'r', '$', { noremap = true, silent = true })
vim.keymap.set('v', 'q', '0', { noremap = true, silent = true })
vim.keymap.set('v', 'r', '$', { noremap = true, silent = true })
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cp', ':Telescope neoclip<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '|', ':vsplit<CR>')
vim.keymap.set('n', '+', ':split<CR>')

-- Lazy.nvim Plugin Manager Setup
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', 'https://github.com/folke/lazy.nvim.git', lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- Kickstart's Default Plugins
  'tpope/vim-sleuth',
  { 'folke/which-key.nvim', opts = {} },
  { 'lewis6991/gitsigns.nvim', opts = {} },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  'numToStr/Comment.nvim', 
  { 'folke/tokyonight.nvim', priority = 1000 },

  -- Your Custom Plugins
  { 'rebelot/kanagawa.nvim' }, -- Keep your alternative theme available
  { 'supermaven-inc/supermaven-nvim' },
  {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end,
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end,
  },
  { 'justinmk/vim-sneak' },
  {
    '907th/vim-auto-save',
    config = function()
      vim.g.auto_save = 1
      vim.g.auto_save_silent = 1
    end,
  },
  {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension 'neoclip'
    end,
  },
    { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { 'famiu/bufdelete.nvim' },
  { 'tpope/vim-fugitive' },
  { 'windwp/nvim-ts-autotag' },
  {
    'themaxmarchuk/tailwindcss-colors.nvim',
    config = function()
      require('tailwindcss-colors').setup()
    end,
  },

  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  { 'folke/tokyonight.nvim', priority = 1000 },
  'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-tree.lua',
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons', }

-- Treesitter Configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'gitcommit',
    'gitignore',
    'go',
    'gomod',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'regex',
    'tsx',
    'vim',
    'vimdoc',
    'html',
    'javascript',
    'typescript',
  },
  highlight = { enable = true },
  autotag = { enable = true },
  indent = { enable = true },
}


-- Git Keybindings
vim.keymap.set('n', '<leader>ga', ':Git add .<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gp', ':Git pull<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gP', ':Git push<CR>', { noremap = true, silent = true })

-- Toggle Terminal Functions
function ToggleHorizontalTerminal()
  local term_buf = vim.fn.bufnr '^term://.*$'
  if term_buf > 0 then
    vim.cmd 'hide'
  else
    vim.cmd 'split | terminal'
  end
end

function ToggleVerticalTerminal()
  local term_buf = vim.fn.bufnr '^term://.*$'
  if term_buf > 0 then
    vim.cmd 'hide'
  else
    vim.cmd 'vsplit | terminal'
  end
end

vim.keymap.set('n', '<A-h>', '<cmd>lua ToggleHorizontalTerminal()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-i>', '<cmd>lua ToggleVerticalTerminal()<CR>', { noremap = true, silent = true })

-- Diagnostic Mappings
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true })

-- Autoformatting on Save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Status Line Configuration
require('lualine').setup {
  options = { theme = 'kanagawa' },
}

-- Treesitter Autotag Configuration
require('nvim-ts-autotag').setup()

-- Colorscheme (Retain Kickstart's default)
vim.cmd.colorscheme 'tokyonight-night'

-- LSP Configuration
require('mason').setup()
require('mason-lspconfig').setup()
require('lspconfig').emmet_ls.setup {
  filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact', 'vue', 'svelte' },
  init_options = {
    html = {
      options = {
        ['output.selfClosingStyle'] = 'xhtml',
      },
    },
  },
}

require('nvim-tree').setup({
  view = {
    width = 30,
    side = 'right',
  },
  filters = {
    dotfiles = false,
    custom = { '.git', 'node_modules', '.cache' },
  },
})

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.cmd.hi 'Comment gui=none'

-- Key Mapping for NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Delete from Cursor to End of Line (dr) and Start of Line (dq)
vim.keymap.set("n", "dr", "d$", { noremap = true, silent = true })
vim.keymap.set("n", "dq", "d0", { noremap = true, silent = true })

-- Clear Search Highlights with `--`
vim.keymap.set("n", "--", ":noh<CR>", { noremap = true, silent = true })

require('kanagawa').setup({ theme = "dragon" })
vim.cmd.colorscheme('kanagawa-dragon')
vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true, desc = "Toggle comment" })
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { noremap = true, silent = true, desc = "Toggle comment" })

-- Move lines up and down in normal mode
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })

-- Move selected lines up and down in visual mode
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })


-- Telescope Setup
local builtin = require('telescope.builtin')

-- Find Files with `<leader>f f`
vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true, desc = "Find Files" })

-- Find Word with `<leader>f w`
vim.keymap.set("n", "<leader>fw", builtin.live_grep, { noremap = true, silent = true, desc = "Find Word" })
