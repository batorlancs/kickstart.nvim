# Agent Notes for Neovim Config

This repository is the complete Neovim configuration. Do not look outside this project for config files.

## Where plugins live
- Plugin manager: `init.lua` (lazy.nvim setup)
- Core plugin specs: `init.lua`
- Custom plugin specs: `lua/custom/plugins/`
- Extra plugin config files: `lua/custom/plugins/*.lua`
- Lockfile: `lazy-lock.json`

## Common debug targets
- Startup and core settings: `init.lua`
- Custom colors and theme tweaks: `lua/custom/colors.lua`
- LSP-specific tweaks: `lsp/`

## Debugging tips
- Use `:Lazy` to inspect plugin status
- Use `:checkhealth` for install/runtime issues
