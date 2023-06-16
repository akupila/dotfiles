return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    {'nvim-lua/popup.nvim'},
    {'BurntSushi/ripgrep'},
    {'nvim-lua/plenary.nvim'},
    {'nvim-lua/plenary.nvim'},
  },
  cmd = 'Telescope',
  init = function()
    vim.keymap.set("n", "<space>", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-_>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { noremap = true, silent = true }) -- C-/
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
  end,
  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      pickers = {
        buffers = {
          show_all_buffers = true,
          mappings = {
            i = {
              ["<c-q>"] = "delete_buffer",
            }
          }
        }
      }
    }
  end,
}
