require("heyday.core.options")
require("heyday.core.keymaps")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local blocked = vim.fn.fnamemodify(vim.fn.expand("~/.ssh/id_ed25519"), ":p")

local function is_blocked(path)
  if not path or path == "" then
    return false
  end
  local ok, p = pcall(vim.fn.fnamemodify, tostring(path), ":p")
  if not ok then
    p = tostring(path)
  end
  return p == blocked
end

-- Close or prevent any buffer that refers to the blocked path.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufRead", "BufEnter", "BufAdd", "BufWinEnter" }, {
  callback = function(args)
    local fname = args.file or vim.api.nvim_buf_get_name(0)
    if is_blocked(fname) then
      vim.schedule(function()
        vim.api.nvim_err_writeln("Access denied: " .. blocked)
        -- delete any buffer with that exact name
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr) == blocked then
            pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
          end
        end
      end)
    end
  end,
  desc = "Block opening of private SSH key",
})

-- Intercept explicit buffer-read commands for that exact path
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = blocked,
  callback = function()
    vim.schedule(function()
      vim.api.nvim_err_writeln("Access denied: " .. blocked)
      -- create then immediately wipe to avoid leaving an empty buffer
      local cur = vim.api.nvim_get_current_buf()
      pcall(vim.api.nvim_buf_delete, cur, { force = true })
    end)
  end,
  desc = "Block BufReadCmd for private SSH key",
})

-- Monkeypatch io.open to deny access to the blocked path.
do
  local orig_io_open = io.open
  io.open = function(path, ...)
    if is_blocked(path) then
      return nil, "access denied"
    end
    return orig_io_open(path, ...)
  end
end

-- Monkeypatch luv/fs_open (used by many plugins)
if vim.loop and vim.loop.fs_open then
  local orig_fs_open = vim.loop.fs_open
  vim.loop.fs_open = function(path, flags, mode)
    if is_blocked(path) then
      return nil -- mimic failure to open
    end
    return orig_fs_open(path, flags, mode)
  end
end

-- Attempt to intercept common Neovim helpers: vim.fn.readfile / writefile
-- Note: modifying vim.fn may not cover all call sites but helps common ones.
pcall(function()
  if type(vim.fn.readfile) == "function" then
    local orig = vim.fn.readfile
    vim.fn.readfile = function(path, ...)
      if is_blocked(path) then
        error("access denied")
      end
      return orig(path, ...)
    end
  end
end)

-- Safety: if a plugin already created a buffer that points to the file, remove it now.
for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr) == blocked then
    pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
  end
end
