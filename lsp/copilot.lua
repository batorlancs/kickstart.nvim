-- Copilot LSP configuration for sidekick.nvim NES (Next Edit Suggestions)
-- The copilot-language-server is bundled with copilot.lua plugin

-- Get the path to copilot.lua's bundled LSP server
local function get_copilot_server_path()
  -- Path for copilot.lua bundled server
  local copilot_path = vim.fn.stdpath('data') .. '/lazy/copilot.lua/copilot/js/language-server.js'
  if vim.fn.filereadable(copilot_path) == 1 then
    return copilot_path
  end
  -- Alternative path (older versions)
  local copilot_dist_path = vim.fn.stdpath('data') .. '/lazy/copilot.lua/copilot/dist/language-server.js'
  if vim.fn.filereadable(copilot_dist_path) == 1 then
    return copilot_dist_path
  end
  -- Fallback: try mason installation
  local mason_path = vim.fn.stdpath('data') .. '/mason/packages/copilot-language-server/node_modules/copilot-language-server/dist/language-server.js'
  if vim.fn.filereadable(mason_path) == 1 then
    return mason_path
  end
  -- Fallback: try global npm installation
  return 'copilot-language-server'
end

---@type vim.lsp.Config
return {
  cmd = { 'node', get_copilot_server_path(), '--stdio' },
  filetypes = {
    'bash',
    'c',
    'cpp',
    'css',
    'go',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'lua',
    'markdown',
    'python',
    'rust',
    'sh',
    'typescript',
    'typescriptreact',
    'vim',
    'yaml',
    'zsh',
  },
  root_markers = { '.git', '.editorconfig', 'package.json' },
  settings = {},
}
