-- Set indentation to spaces
vim.cmd("set expandtab")
-- Set tab width
vim.cmd("set tabstop=2")
-- Set soft tab width
vim.cmd("set softtabstop=2")
-- Set indentation width
vim.cmd("set shiftwidth=2")
--
vim.g.mapleader = " "

-- Construct the path to the `lazy.nvim` directory under the Neovim data directory
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if the `lazy.nvim` directory exists. If not, clone the repository from GitHub into that directory
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",                                   -- Git command
    "clone",                                 -- Clone operation
    "--filter=blob:none",                    -- Reduce bandwidth usage by cloning only necessary objects
    "https://github.com/folke/lazy.nvim.git",-- GitHub repository URL
    "--branch=stable",                       -- Checkout the latest stable release
    lazypath,                                -- Destination directory for cloning
  })
end

-- Append the `lazypath` to the `rtp` (runtimepath) option, making Neovim aware of the lazy-loaded plugins
vim.o.rtp = vim.o.rtp .. ',' .. lazypath

-- Define empty tables for plugins and options
local plugins = {

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
      {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',

      dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

  {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
 }
}


local opts = {}

-- Set up the lazy-loading mechanism for plugins with empty `plugins` and `opts`
require("lazy").setup(plugins)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua","javascript"},
--auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"





