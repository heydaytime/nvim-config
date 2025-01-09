-- Install and configure go.nvim
-- Ensure Lazy.nvim and dependencies are already set up

return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua", -- Required for floating window support
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			go = "go", -- Specify the Go binary
			gofmt = "golines", -- Format using gopls
			fillstruct = "gopls", -- Fill struct using gopls
			max_line_len = 60, -- Set max line length for formatting
			tag_options = "json=omitempty", -- Default struct tag options
			lsp_cfg = true, -- Use default gopls LSP config
			lsp_on_attach = function(client, bufnr)
				local buf_map = function(mode, lhs, rhs, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
				buf_map("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
			end,
			test_runner = "go", -- Use `go` as the test runner
			dap_debug = true, -- Enable debugging
			dap_debug_gui = true, -- Enable GUI for debugging
			run_in_floaterm = true, -- Run commands in floating terminal
		})

		-- Automatically format files on save
		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
			end,
			group = format_sync_grp,
		})
	end,
	ft = { "go", "gomod" }, -- Load plugin for Go files
	event = { "CmdlineEnter" }, -- Lazy load on specific events
	build = ":lua require('go.install').update_all_sync()", -- Install/update required binaries
}
