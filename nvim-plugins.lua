-- Location of plugin configurations
local LSP_CONFIG_PATH = "~/.config/nvim/lua/nvim-lspconfig"
local TREESITTER_CONFIG_PATH = "~/.config/nvim/lua/nvim-treesitter"

-- Add plugin configurations to runtime path
vim.opt.rtp:append(LSP_CONFIG_PATH)
vim.opt.rtp:append(TREESITTER_CONFIG_PATH)

-- Load LSP configuration
local lsp_config = require("lsp-config")

-- Load Treesitter configuration
local treesitter_config = require("treesitter-config")

