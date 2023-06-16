-- Mappings --
vim.g.mapleader = ","

-- Alternate file with Q insted of Ex mode
vim.keymap.set('n', 'Q', '<C-^>')
vim.keymap.set('v', 'Q', '')

-- Exit insert mode with jk
vim.keymap.set('i', 'jk', '<esc>')

-- Move to column on wrapped line
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')

-- Clear highlight
vim.keymap.set('n', '<leader><space>', '<cmd>nohlsearch<cr>')

-- Move visual block while maintaining selection
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Highlight search without moving
vim.keymap.set('n', '*', ':let start_pos = winsaveview()<CR>*:call winrestview(start_pos)<cr>')

-- Close buffer without closing split
vim.keymap.set('n', '<C-q>', ':bprevious | bdelete #<cr>')

-- Show diagnostics
vim.keymap.set('n', '<C-k>', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- Options --
vim.o.backup = false
vim.o.backupcopy = 'yes'
vim.o.clipboard = 'unnamed'
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldlevelstart = 99
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.lazyredraw = true
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shortmess = 'aIc'
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 250

vim.opt.listchars = { tab = '⎸ ' }

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.wo.spell = true
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Diagnostics --
vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        source = 'always',
        border = 'rounded',
        focusable = false,
    },
    update_in_insert = true,
    severity_sort = true,
})

-- Plugins --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
  checker = {
    enable = true,
  }
})

