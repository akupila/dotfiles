return {
  'tpope/vim-fugitive',
  cmd = {'Git'},
  init = function() 
    vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")
  end
}
