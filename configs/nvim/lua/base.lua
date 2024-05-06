vim.g.mapleader = " "
local keymap = vim.keymap 
local opt = vim.opt

keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader>f", ":Ex<CR>")

opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.guicursor = ""
opt.showmode = false
opt.scrolloff = 5

vim.cmd[[colorscheme lunaperche]]


