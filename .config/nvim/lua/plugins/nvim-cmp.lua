return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
  },
  config = function()
    local cmp = require("cmp")
    local types = require('cmp.types')

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ["<c-e>"] = cmp.mapping.abort(),
      }),
      matching = {
      },
      preselect = types.cmp.PreselectMode.None,
      formatting = {
        format = function(_, vim_item)
          print(vim_item.word)
          vim_item.abbr = string.sub(vim_item.abbr, 1, 200)
          return vim_item
        end
      },
      -- snippet = {
      --   expand = function(args)
      --     require('luasnip').lsp_expand(args.body)
      --   end,
      -- },
      sources = cmp.config.sources({
        { name = "nvim_lsp", group_index = 1 },
        { name = "path", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "buffer", keyword_length = 5, group_index = 3 },
      }),
    })
  end,
}
