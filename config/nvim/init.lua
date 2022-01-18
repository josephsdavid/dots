require "user.options"
require "user.plugins"
require "user.lsp"
require "user.colorscheme"
require "user.treesitter"
require "user.keybinds"
require "user.cmp"
require "user.luasnip"
require "user.telescope"
require "user.toggleterm"
require "user.comment"
require "user.lualine"
require "user.clickfree"
-- require "user.lightspeed"
require "user.null-ls"
-- require "user.gitsigns"
require "user.neogit"
require "user.vimscript"
require "user.neorg"
require 'packer_compiled'
require "user.bufferline"
require "user.indentline"
vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

local utils = require("user.utils")
local mappings = utils.mappings

require("aerial").setup({
  on_attach = function(bufnr)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(bufnr, 'n', mappings.go("a"), '<cmd>AerialToggle!<CR>', {})
    -- Jump forwards/backwards with '{' and '}'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
    -- Jump up the tree with '[[' or ']]'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
  end,
  default_direction = "prefer_left",
  backends = { "treesitter", "lsp",  "markdown" },
  manage_folds = true,
  link_folds_to_tree = true
})
