return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      input = {
        -- Prevent dressing input from showing in completions
        insert_only = true,
        start_in_insert = true,
        -- Use a more specific filetype
        get_config = function(opts)
          if opts.prompt and opts.prompt:find("AI Question") then
            return {
              relative = "win",
              prefer_width = 40,
            }
          end
        end,
      },
    })

    -- Disable completions for DressingInput buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "DressingInput",
      callback = function()
        vim.opt_local.completefunc = ""
        vim.opt_local.omnifunc = ""
        vim.b.copilot_enabled = 0 -- Disable Copilot for these buffers
      end,
    })
  end,
}
