-- You can add your own plugins here or in other files in this directory!
-- I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.opt.colorcolumn = '80'
vim.opt.relativenumber = true
vim.opt.number = true -- Keep the absolute number on the current line

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.cmd 'highlight ColorColumn ctermbg=darkgray guibg=#313244'
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'css', 'scss', 'less' },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
  end,
})

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      'node_modules',
    },
  },
}

return {

  -- 'nvim-neo-tree/neo-tree.nvim',
  -- dependencies = {
  --   'nvim-lua/plenary.nvim',
  --   -- 'nvim-tree/nvim-web-devicons', -- Icons
  --   'MunifTanjim/nui.nvim',
  -- },
  -- { 'nvim-tree/nvim-web-devicons', opts = { default = true } },
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },
}
