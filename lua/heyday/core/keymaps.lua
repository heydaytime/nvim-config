vim.g.mapleader = " "

-- ===========================
-- Shared Keymaps (Both VSCode and Terminal Neovim)
-- ===========================

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste from black hole register (keeps the yanked text)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- ===========================
-- VSCode-Specific Keymaps
-- ===========================
if vim.g.vscode then
  local vscode = require("vscode")

  -- Tab switching with number keys (matching harpoon behavior)
  vim.keymap.set("n", "<leader>1", function()
    vscode.action("workbench.action.openEditorAtIndex1")
  end, { desc = "Go to editor tab 1" })
  vim.keymap.set("n", "<leader>2", function()
    vscode.action("workbench.action.openEditorAtIndex2")
  end, { desc = "Go to editor tab 2" })
  vim.keymap.set("n", "<leader>3", function()
    vscode.action("workbench.action.openEditorAtIndex3")
  end, { desc = "Go to editor tab 3" })
  vim.keymap.set("n", "<leader>4", function()
    vscode.action("workbench.action.openEditorAtIndex4")
  end, { desc = "Go to editor tab 4" })
  vim.keymap.set("n", "<leader>5", function()
    vscode.action("workbench.action.openEditorAtIndex5")
  end, { desc = "Go to editor tab 5" })
  vim.keymap.set("n", "<leader>6", function()
    vscode.action("workbench.action.openEditorAtIndex6")
  end, { desc = "Go to editor tab 6" })
  vim.keymap.set("n", "<leader>7", function()
    vscode.action("workbench.action.openEditorAtIndex7")
  end, { desc = "Go to editor tab 7" })
  vim.keymap.set("n", "<leader>8", function()
    vscode.action("workbench.action.openEditorAtIndex8")
  end, { desc = "Go to editor tab 8" })
  vim.keymap.set("n", "<leader>9", function()
    vscode.action("workbench.action.openEditorAtIndex9")
  end, { desc = "Go to editor tab 9" })
  vim.keymap.set("n", "<leader>0", function()
    vscode.action("workbench.action.lastEditorInGroup")
  end, { desc = "Go to last editor tab" })

  -- Tab switching with shifted symbol keys (matching harpoon's shifted mappings)
  vim.keymap.set("n", "<leader>!", function()
    vscode.action("workbench.action.openEditorAtIndex1")
  end, { desc = "Go to editor tab 1" })
  vim.keymap.set("n", "<leader>[", function()
    vscode.action("workbench.action.openEditorAtIndex2")
  end, { desc = "Go to editor tab 2" })
  vim.keymap.set("n", "<leader>{", function()
    vscode.action("workbench.action.openEditorAtIndex3")
  end, { desc = "Go to editor tab 3" })
  vim.keymap.set("n", "<leader>(", function()
    vscode.action("workbench.action.openEditorAtIndex4")
  end, { desc = "Go to editor tab 4" })
  vim.keymap.set("n", "<leader>%", function()
    vscode.action("workbench.action.openEditorAtIndex5")
  end, { desc = "Go to editor tab 5" })
  vim.keymap.set("n", "<leader>*", function()
    vscode.action("workbench.action.openEditorAtIndex6")
  end, { desc = "Go to editor tab 6" })
  vim.keymap.set("n", "<leader>&", function()
    vscode.action("workbench.action.openEditorAtIndex7")
  end, { desc = "Go to editor tab 7" })
  vim.keymap.set("n", "<leader>)", function()
    vscode.action("workbench.action.openEditorAtIndex8")
  end, { desc = "Go to editor tab 8" })
  vim.keymap.set("n", "<leader>}", function()
    vscode.action("workbench.action.openEditorAtIndex9")
  end, { desc = "Go to editor tab 9" })
  vim.keymap.set("n", "<leader>]", function()
    vscode.action("workbench.action.lastEditorInGroup")
  end, { desc = "Go to last editor tab" })

-- ===========================
-- Terminal Neovim-Specific Keymaps
-- ===========================
else
  -- Diagnostic floating window
  vim.keymap.set("n", "<leader>q", function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor", -- or "line"
      border = "rounded",
      source = "if_many",
    })
  end, { desc = "Show diagnostics at cursor" })

  -- Window navigation
  vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })

  -- Toggle inlay hints (if supported by the LSP)
  vim.keymap.set("n", "<leader>th", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "[T]oggle Inlay [H]ints" })

  -- LSP actions
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart Rename" })

  -- Diagnostic configuration
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
end
