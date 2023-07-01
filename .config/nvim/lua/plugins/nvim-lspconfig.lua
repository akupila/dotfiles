return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.gopls.setup({
      settings = {
        gopls = {
          staticcheck = true,
          gofumpt = true,
          analyses = {
            nilness = true,
            unusedwrite = true,
          },
          experimentalPostfixCompletions = false,
          hoverKind = "FullDocumentation",
          linksInHover = false,
        },
      },
    })

    lspconfig.terraformls.setup({
    })

    lspconfig.tsserver.setup({
    })

    lspconfig.tailwindcss.setup({
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set({'n', 'i'}, '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = ev.buf,
          callback = function()
              vim.lsp.buf.format { async = false }
          end
        })

      end,
    })
  end
}

