-- Minimal init.lua - Neovim configuration bootstrap

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Load core configuration
require 'custom.core.options'
require 'custom.core.keymaps'
require 'custom.core.autocommands'

-- Delete current file and close buffer (with confirmation)
vim.keymap.set('n', '<leader>fd', function()
  local file = vim.fn.expand '%:p'
  if file == '' then
    vim.notify('No file to delete', vim.log.levels.ERROR)
    return
  end

  local confirm = vim.fn.confirm('Delete "' .. file .. '"?', '&Yes\n&No', 2)
  if confirm ~= 1 then
    return
  end

  local ok, err = pcall(os.remove, file)
  if not ok then
    vim.notify('Failed to delete: ' .. err, vim.log.levels.ERROR)
    return
  end

  vim.cmd 'bd!'
  vim.notify('Deleted ' .. vim.fn.fnamemodify(file, ':t'), vim.log.levels.INFO)
end, { desc = '[F]ile [D]elete', silent = true })

-- Rename current file (prompts for new name)
vim.keymap.set('n', '<leader>fr', function()
  local old_path = vim.fn.expand '%:p'

  vim.ui.input({
    prompt = 'Rename to: ',
    default = old_path,
    completion = 'file',
  }, function(new_path)
    if not new_path or new_path == '' or new_path == old_path then
      return
    end

    if vim.loop.fs_stat(new_path) then
      vim.notify('File already exists!', vim.log.levels.ERROR)
      return
    end

    local ok, err = os.rename(old_path, new_path)
    if not ok then
      vim.notify('Rename failed: ' .. err, vim.log.levels.ERROR)
      return
    end

    vim.api.nvim_buf_set_name(0, new_path)
    vim.cmd 'edit'

    vim.notify('Renamed → ' .. vim.fn.fnamemodify(new_path, ':t'), vim.log.levels.INFO)
  end)
end, { desc = '[F]ile [R]ename', silent = true })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
require('lazy').setup({
  -- Core plugins
  { import = 'custom.plugins.core' },
  { import = 'custom.plugins.lsp' },
  { import = 'custom.plugins.themes' },
  require 'custom.plugins.treesitter',

  -- Kickstart plugins (keep as-is)
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.lint',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Automatically reload files changed outside of Neovim
vim.o.autoread = true

-- Trigger autoread when files change on disk
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  command = 'checktime',
})

-- Notification when file changes on disk
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  pattern = '*',
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.WARN)
  end,
})

--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

local _command = vim.api.nvim_create_user_command

_command('Wq', function()
  vim.cmd 'wq'
end, {})

_command('Wqa', function()
  vim.cmd 'wqa'
end, {})

_command('W', function()
  vim.cmd 'w'
end, {})

_command('Q', function()
  vim.cmd 'q'
end, {})
