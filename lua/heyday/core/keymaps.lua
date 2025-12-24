vim.g.mapleader = " "

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymap to open the diagnostic [Q]uickfix list
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })

-- Keymap to toggle inlay hints (if supported by the LSP)
vim.keymap.set("n", "<leader>th", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "[T]oggle Inlay [H]ints" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Make default delete/change operations use black hole register
-- vim.keymap.set({ "n", "v" }, "d", [["_d]])
-- vim.keymap.set({ "n", "v" }, "D", [["_D]])
-- vim.keymap.set({ "n", "v" }, "c", [["_c]])
-- vim.keymap.set({ "n", "v" }, "C", [["_C]])
-- vim.keymap.set({ "n", "v" }, "x", [["_x]])
-- vim.keymap.set({ "n", "v" }, "X", [["_X]])

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart Rename" })

vim.diagnostic.config({
  -- Virtual text (inline diagnostic messages)
  virtual_text = {
    spacing = 4, -- Spaces between code and message
    prefix = "▎", -- Icon before message ('●', '■', '▎', '»', etc.)
    severity = nil, -- Only show for specific severities (e.g., { min = vim.diagnostic.severity.WARN })
    source = false, -- Show source of diagnostic (e.g., "eslint")
    format = nil, -- Custom formatting function
  },

  -- Signs in the gutter (left side icons)
  signs = true, -- Show diagnostic signs
  underline = true, -- Underline diagnostic locations
  update_in_insert = false, -- Update diagnostics while typing (true = noisy, false = cleaner)
  severity_sort = true, -- Sort diagnostics by severity (errors before warnings)

  -- Floating window settings
  float = {
    show_header = true, -- Show "Diagnostics:" header
    source = "always", -- Show diagnostic source ('always', 'if_many', false)
    border = "single", -- Border style ('none', 'single', 'double', 'rounded', 'solid', 'shadow')
    format = nil, -- Custom formatting function
    suffix = nil, -- Custom suffix function
    prefix = nil, -- Custom prefix function (for each diagnostic line)
    focusable = true, -- Can you focus/navigate the float window
    style = "minimal", -- Window style
    header = "", -- Custom header text
    scope = "cursor", -- Show diagnostics for 'cursor', 'line', or 'buffer'
  },
})
