-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Enable treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable treesitter highlighting',
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
