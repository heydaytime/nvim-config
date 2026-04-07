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

    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    end

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
        on_attach = on_attach,
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
      on_attach = on_attach,
      filetypes = { "markdown" },
      root_markers = { ".git", "README.md" },
    })

    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
      root_markers = { "package.json", "tsconfig.json", ".git" },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
      callback = function()
        vim.lsp.enable("ts_ls")
      end,
    })

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "go", "gomod" },
      root_markers = { "go.mod", ".git" },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod" },
      callback = function()
        vim.lsp.enable("gopls")
      end,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    vim.lsp.config("zls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "zig", "zir" },
      root_markers = { "zls.json", "build.zig", ".git" },
    })

    vim.lsp.config("pyright", {
      capabilities = capabilities,
      on_attach = on_attach,
      root_markers = { "pyproject.toml", "setup.py", ".git" },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.lsp.enable("marksman")
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

    vim.lsp.config("gdscript", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "gdscript" },
      root_markers = { "project.godot", ".git" },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "gdscript",
      callback = function()
        vim.lsp.enable("gdscript")
      end,
    })

    vim.lsp.config("omnisharp", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "cs" },
      root_markers = { "*.sln", "*.csproj", ".git" },
      cmd = { "/opt/homebrew/Cellar/omnisharp/1.35.3/libexec/run", "--languageserver" },
      cmd_env = {
        DOTNET_ROOT = vim.env.DOTNET_ROOT or "/opt/homebrew/opt/dotnet@8/libexec",
        PATH = "/opt/homebrew/opt/dotnet@8/libexec:" .. vim.env.PATH,
      },
      settings = {
        FormattingOptions = {
          EnableEditorConfigSupport = true,
          OrganizeImports = true,
        },
        RoslynExtensionsOptions = {
          EnableAnalyzersSupport = true,
          EnableImportCompletion = true,
        },
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "cs",
      callback = function()
        vim.lsp.enable("omnisharp")
      end,
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}
