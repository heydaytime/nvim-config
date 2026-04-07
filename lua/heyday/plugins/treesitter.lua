return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    install_dir = vim.fn.stdpath("data") .. "/site",
  },
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
    require("nvim-treesitter").install({
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "prisma",
      "markdown",
      "markdown_inline",
      "graphql",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "c",
      "gdscript",
      "godot_resource",
      "gdshader",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "javascript",
        "typescript",
        "tsx",
        "javascriptreact",
        "typescriptreact",
        "json",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "gdscript",
        "godot_resource",
        "gdshader",
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
