return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Only handle installation, not configuration
    mason_lspconfig.setup({
      ensure_installed = {
        "gopls",
        "clangd",
        "jdtls",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
      },
      automatic_installation = true,
      automatic_enable = false,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- formatter
        "stylua", -- Lua formatter
        "isort", -- Python formatter
        "black", -- Python formatter
        "pylint",
        "eslint_d",
      },
    })
  end,
}
