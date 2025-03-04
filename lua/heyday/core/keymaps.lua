vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<leader>fh", "<C-w>h", { desc = "Navigate left in Neovim" })
keymap.set("n", "<leader>fj", "<C-w>j", { desc = "Navigate down in Neovim" })
keymap.set("n", "<leader>fk", "<C-w>k", { desc = "Navigate up in Neovim" })
keymap.set("n", "<leader>fl", "<C-w>l", { desc = "Navigate right in Neovim" })

keymap.set("n", "<leader>fH", "<C-w>H", { desc = "Move window to the left" })
keymap.set("n", "<leader>fJ", "<C-w>J", { desc = "Move window to the bottom" })
keymap.set("n", "<leader>fK", "<C-w>K", { desc = "Move window to the top" })
keymap.set("n", "<leader>fL", "<C-w>L", { desc = "Move window to the right" })
