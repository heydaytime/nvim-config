return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/mnt/samba/vault",
      },
    },
    mappings = {
      -- Default mappings (keep these)
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
      -- Add your own custom mappings below!
    },
  },

  -- Or set keymaps outside the plugin config:
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note" },
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's note" },
    { "<leader>oT", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
  },
}
