-- You can add your own plugins here or in other files in this directory!
-- I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.opt.colorcolumn = '80'
vim.opt.relativenumber = true
vim.opt.number = true -- Keep the absolute number on the current line

vim.diagnostic.config {
  virtual_text = true,
}

vim.api.nvim_create_user_command('OilTelescope', function()
  require('telescope.builtin').find_files {
    prompt_title = 'Find Folder',
    find_command = { 'fdfind', '--type', 'd', '--color', 'never' },
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local entry = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        vim.cmd('Oil ' .. entry.path)
      end)
      return true
    end,
  }
end, {})

vim.keymap.set('n', '<leader>st', '<cmd>OilTelescope<cr>', { desc = '[S]earch File [T]ree' })

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
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },
}
