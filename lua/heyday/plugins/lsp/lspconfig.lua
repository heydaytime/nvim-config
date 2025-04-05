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
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Set up capabilities for autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Define diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- Default handler for all servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      -- Custom configuration for specific servers:
      ["clangd"] = function()
        lspconfig["clangd"].setup({
          capabilities = capabilities,
          cmd = {
            "clangd",
            "--query-driver=/Users/mihirbelose/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc",
          },
        })
      end,
      ["jdtls"] = function()
        lspconfig["jdtls"].setup({
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
      end,
      ["svelte"] = function()
        lspconfig["svelte"].setup({
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
      end,
      ["graphql"] = function()
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              completion = { callSnippet = "Replace" },
            },
          },
        })
      end,
    })
  end,
}
