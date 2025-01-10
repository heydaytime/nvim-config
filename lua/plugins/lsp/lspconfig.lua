return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
    {
      "nvim-flutter/flutter-tools.nvim",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim", -- optional for vim.ui.select
      },
      config = true,
    },
  },
  config = function()
    -- Import required plugins
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Setup completion capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup diagnostic symbols
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- LSP keybindings
    local keymap = vim.keymap -- for conciseness
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end,
    })

    -- Setup Mason and generic LSP server handling
    mason_lspconfig.setup_handlers({
      function(server_name)
        if server_name ~= "dartls" then -- Avoid direct setup for dartls
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end
      end,
    })

    -- Reload DartLS if inactive
    local function reload_dartls_if_inactive()
      local dartls_client
      for _, client in ipairs(vim.lsp.get_clients()) do
        if client.name == "dartls" then
          dartls_client = client
          break
        end
      end

      vim.defer_fn(function()
        if dartls_client and not dartls_client.is_stopped() then
          return
        end

        if dartls_client and dartls_client.stop then
          dartls_client.stop()
        end

        require("flutter-tools.lsp").attach()
      end, 2000)
    end

    -- Auto-reload DartLS on saving Dart files
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.dart",
      callback = reload_dartls_if_inactive,
    })
  end,
}
