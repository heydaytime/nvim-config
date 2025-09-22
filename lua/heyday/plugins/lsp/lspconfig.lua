return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
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

    -- Refactoring everything to vim.lsp.config

    if vim.loop.cwd() == "/Users/mihirbelose/esp/blink-led" then
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--query-driver=/Users/mihirbelose/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/xtensa-esp32-elf-gcc",
        },
      })
    end

    vim.lsp.config("jdtls", {
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

    vim.lsp.config("svelte", {
      capabilities = capabilities,
      filetypes = { "typescript", "javascript", "svelte", "html", "css" },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    vim.lsp.config("ltex", {
      settings = {
        ltex = {
          language = "en-US",
          checkFrequency = "save", -- or "edit" for real-time
        },
      },
      filetypes = { "markdown", "text", "tex", "gitcommit" },
    })

    vim.lsp.config("graphql", {
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}
