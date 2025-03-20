return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- Keymaps
    -- Add file to harpoon
    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Add file to harpoon" })

    -- Open harpoon menu
    vim.keymap.set("n", "<leader>hw", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Open harpoon menu" })

    -- File selection using shifted keys:
    vim.keymap.set("n", "<leader>!", function()
      harpoon:list():select(1)
    end, { desc = "Go to harpoon file 1" })

    vim.keymap.set("n", "<leader>@", function()
      harpoon:list():select(2)
    end, { desc = "Go to harpoon file 2" })

    vim.keymap.set("n", "<leader>#", function()
      harpoon:list():select(3)
    end, { desc = "Go to harpoon file 3" })

    vim.keymap.set("n", "<leader>$", function()
      harpoon:list():select(4)
    end, { desc = "Go to harpoon file 4" })

    vim.keymap.set("n", "<leader>%", function()
      harpoon:list():select(5)
    end, { desc = "Go to harpoon file 5" })

    vim.keymap.set("n", "<leader>^", function()
      harpoon:list():select(6)
    end, { desc = "Go to harpoon file 6" })

    vim.keymap.set("n", "<leader>&", function()
      harpoon:list():select(7)
    end, { desc = "Go to harpoon file 7" })

    vim.keymap.set("n", "<leader>*", function()
      harpoon:list():select(8)
    end, { desc = "Go to harpoon file 8" })

    vim.keymap.set("n", "<leader>(", function()
      harpoon:list():select(9)
    end, { desc = "Go to harpoon file 9" })

    vim.keymap.set("n", "<leader>)", function()
      harpoon:list():select(10)
    end, { desc = "Go to harpoon file 10" })
  end,
}
