return {
  {
    "github/copilot.vim",

    config = function()
      vim.g.copilot_settings = { selectedCompletionModel = "gpt-4o-copilot" }

      -- Keymaps for GitHub Copilot
      vim.keymap.set("i", "<C-g>y", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-g>p", "<Plug>(copilot-previous)", { silent = true })
      vim.keymap.set("i", "<C-g>n", "<Plug>(copilot-next)", { silent = true })
      vim.keymap.set("i", "<C-g>l", "<Plug>(copilot-accept-line)", { silent = true })
      vim.keymap.set("i", "<C-g>w", "<Plug>(copilot-accept-word)", { silent = true })
    end,
  },
}
