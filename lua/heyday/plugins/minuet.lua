return {
  -- Main Minuet AI plugin
  {
    "milanglacier/minuet-ai.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("minuet").setup({
        -- Use local Ollama provider
        provider = "openai_compatible",

        -- Basic settings
        context_window = 16000,
        throttle = 1000,
        debounce = 400,
        request_timeout = 3,
        n_completions = 3,
        notify = "warn",

        -- Virtual text completion (GitHub Copilot style)
        virtualtext = {
          auto_trigger_ft = { "python", "lua", "javascript", "typescript", "rust", "go" }, -- Add your languages
          keymap = {
            accept = "<C-g>y", -- Ctrl+g then y (accept)
            accept_line = "<C-g>l", -- Ctrl+g then l (line)
            accept_n_lines = "<C-g>k", -- Ctrl+g then k (n lines)
            next = "<C-g>n", -- Ctrl+g then n (next)
            prev = "<C-g>p", -- Ctrl+g then p (previous)
            dismiss = "<C-g>e", -- Ctrl+g then e (escape/dismiss)
          },
        },

        -- Disable auto-completion for cmp/blink
        cmp = {
          enable_auto_complete = false,
        },
        blink = {
          enable_auto_complete = false,
        },

        -- LSP integration (for built-in completion)
        lsp = {
          enabled_ft = {}, -- Add filetypes if you want LSP integration
          enabled_auto_trigger_ft = {},
        },

        -- Provider configuration - Local Ollama only
        provider_options = {
          openai_compatible = {
            model = "codellama:13b",
            end_point = "http://localhost:11434/v1/chat/completions",
            api_key = "TERM", -- Dummy for Ollama
            name = "Ollama",
            optional = {
              max_tokens = 256,
            },
          },
        },
      })
    end,
  },
}
