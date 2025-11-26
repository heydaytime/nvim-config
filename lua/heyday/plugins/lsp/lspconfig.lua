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

    -- Configure diagnostics
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

    -- Configure clangd for ESP project only
    if vim.loop.cwd() == "/Users/mihirbelose/esp/blink-led" then
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--query-driver=/Users/mihirbelose/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/xtensa-esp32-elf-gcc",
        },
        root_markers = { "compile_commands.json", ".git" },
      })
      vim.lsp.enable("clangd")
    end

    vim.lsp.config("marksman", {
      capabilities = capabilities,
      filetypes = { "markdown" },
      root_markers = { ".git", "README.md" },
    })

    -- Configure jdtls
    vim.lsp.config("jdtls", {
      capabilities = capabilities,
      root_markers = { "pom.xml", "build.gradle", ".git" },
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

    -- Configure svelte
    vim.lsp.config("svelte", {
      capabilities = capabilities,
      filetypes = { "typescript", "javascript", "svelte", "html", "css" },
      root_markers = { "package.json", "svelte.config.js", ".git" },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    -- Configure lua_ls
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    -- Configure zls (Zig Language Server)
    vim.lsp.config("zls", {
      capabilities = capabilities,
      filetypes = { "zig", "zir" },
      root_markers = { "zls.json", "build.zig", ".git" },
    })

    vim.lsp.config("pyright", {
      capabilities = capabilities,
      root_markers = { "pyproject.toml", "setup.py", ".git" },
    })

    -- Enable LSPs only for their specific filetypes
    --
    --
    --
    --

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.lsp.enable("marksman")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        vim.lsp.enable("jdtls")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescript", "javascript", "svelte" },
      callback = function()
        vim.lsp.enable("svelte")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lua",
      callback = function()
        vim.lsp.enable("lua_ls")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "zig", "zir" },
      callback = function()
        vim.lsp.enable("zls")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        vim.lsp.enable("pyright")
      end,
    })

    -- Set default capabilities for all other servers
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}
