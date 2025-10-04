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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "copilot",
      tools = {
        enabled = false,
      },
      auto_suggestions_provider = "copilot",
      providers = {
        copilot = {
          endpoint = "https://api.githubcopilot.com",
          model = "gpt-4o-2024-05-13",
          proxy = nil,
          allow_insecure = false,
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = true },
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    config = function(_, opts)
      require("avante").setup(opts)

      -- Custom keymaps to match your style
      vim.keymap.set({ "n", "i" }, "<C-g><C-g>", function()
        require("avante.api").ask()
      end, { desc = "AI Toggle Chat" })

      vim.keymap.set({ "n", "i" }, "<C-g>a", function()
        require("avante.api").ask()
      end, { desc = "AI Open" })

      vim.keymap.set({ "n", "i" }, "<C-g>x", function()
        vim.cmd("AvanteClear history")
      end, { desc = "AI Clear History" })

      vim.keymap.set({ "n", "i", "v" }, "<C-g>e", function()
        require("avante.api").ask({ question = "Explain this code" })
      end, { desc = "AI Explain" })

      vim.keymap.set({ "n", "i", "v" }, "<C-g>r", function()
        require("avante.api").ask({ question = "Review this code for potential issues" })
      end, { desc = "AI Review" })

      vim.keymap.set({ "n", "i", "v" }, "<C-g>t", function()
        require("avante.api").ask({ question = "Generate tests for this code" })
      end, { desc = "AI Tests" })

      vim.keymap.set({ "n", "i", "v" }, "<C-g>f", function()
        require("avante.api").ask({ question = "Fix any bugs or issues in this code" })
      end, { desc = "AI Fix" })

      vim.keymap.set({ "n", "i", "v" }, "<C-g>o", function()
        require("avante.api").ask({ question = "Optimize this code for better performance" })
      end, { desc = "AI Optimize" })

      vim.keymap.set({ "n", "i", "v" }, "<C-g>d", function()
        require("avante.api").ask({ question = "Add documentation for this code" })
      end, { desc = "AI Documentation" })

      vim.keymap.set({ "n", "i", "v" }, "<C-g>q", function()
        vim.ui.input({
          prompt = "AI Question> ",
        }, function(input)
          if input and input ~= "" then
            require("avante.api").ask({ question = input })
          end
        end)
      end, { desc = "AI Question" })
    end,
  },
}
