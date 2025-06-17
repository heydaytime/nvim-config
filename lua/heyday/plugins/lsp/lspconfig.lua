return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    -- Configure servers directly with lspconfig
    -- Custom configurations

    if vim.loop.cwd() == "/Users/mihirbelose/esp/blink-led" then
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--query-driver=/Users/mihirbelose/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/xtensa-esp32-elf-gcc",
        },
      })
    end

    lspconfig.jdtls.setup({
      capabilities = capabilities,
      settings = {
        java = {
          project = {
            referencedLibraries = {
              "/Users/mihirbelose/ProgrammingProjects/SchoolProjects/JavaProjects/junit5.jar",
            },
          },
        },
      },
    })

    lspconfig.svelte.setup({
      capabilities = capabilities,
      filetypes = { "typescript", "javascript", "svelte", "html", "css" },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          buffer = bufnr,
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    lspconfig.graphql.setup({
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    -- Default configurations for other servers
    local default_servers = { "gopls", "ts_ls", "html", "cssls", "tailwindcss", "prismals", "pyright" }

    for _, server in ipairs(default_servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end
  end,
}
