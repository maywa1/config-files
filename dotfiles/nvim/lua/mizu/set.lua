vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Create an augroup for filetype-specific tabs
local ft_tabs = vim.api.nvim_create_augroup("FileTypeTabs", { clear = true })

-- JS, TS, TSX files -> 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  group = ft_tabs,
  pattern = { "javascript", "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80" -- I don't need this because there is no one making me have 80 char length code, I just broke that rule MUAHAHAHA >:3

