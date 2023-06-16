return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
      vim.keymap.set({"i"}, "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
      vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr })

      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        desc = "Format code on save",
        callback = function()
          vim.lsp.buf.format()
        end
      })
    end

    lspconfig.gopls.setup({
      on_attach = on_attach,
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
      on_attach = on_attach,
    })

    lspconfig.tsserver.setup({
      on_attach = on_attach,
    })

    lspconfig.tailwindcss.setup({
      on_attach = on_attach,
    })
  end
}

