local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({
  vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc = "Add current file to harpoon"});
  vim.keymap.set("n", "<leader>hs", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Show harpoon UI"});

  vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {desc = "Select current file to harpoon index 1"});
  vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {desc = "Select current file to harpoon index 2"});
  vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {desc = "Select current file to harpoon index 3"});
  vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {desc = "Select current file to harpoon index 4"});

 -- Toggle previous & next buffers stored within Harpoon list
  vim.keymap.set("n", "<leader>bb", function() harpoon:list():prev() end,  {desc = "Previous harpoon file"});
  vim.keymap.set("n", "<leader>nn", function() harpoon:list():next() end,  {desc = "Next harpoon file"});
})
-- REQUIRED

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
