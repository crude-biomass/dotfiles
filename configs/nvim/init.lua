--  _ _ _ ___ ___ ___ ___ ___ ___| |_ ___ ___   
-- | | | | .'|  _| -_|  _| -_| . |  _| . |  _|  
-- |_____|__,|_| |___|___|___|  _|_| |___|_|    
--                           |_|                                                                     
require("base")

--[[ lazy.nvim bootstrap ]]--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--[[ lazy.nvim plugins ]]--
require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local treesit = require("nvim-treesitter.configs")
			treesit.setup({
				ensure_installed = {
					"lua",
					"vim",
					"c",
					"nasm",
					"cpp",
					"bash",
					"python",
					"make",
					"cmake",
					"json",
					"markdown",
					"markdown_inline",
					"query" 
				},

				sync_install = { enable = false },

				auto_install = { enable = true },

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local line = require("lualine")
			line.setup({
				options = {
					theme = "powerline_dark",
					icons_enabled = false,
					component_separators = { left = '', right = ''},
					section_separators = { left = '', right = ''},
				},
			})
		end
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
})
