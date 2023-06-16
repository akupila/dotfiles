return {
  'mzlogin/vim-markdown-toc',
  init = function() 
    vim.cmd [[
    let g:vmt_list_indent_text = '  '
    ]]
  end
}
