local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "L3MON4D3/LuaSnip"
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'Rigellute/rigel'
  use 'Yggdroot/hiPairs'
  use 'axvr/zepl.vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'vimlab/split-term.vim'
  use 'Yggdroot/indentLine'
  use "akinsho/toggleterm.nvim"
  use 'lewis6991/impatient.nvim'
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }


  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 
    "nvim-neorg/neorg",
    config = function()
      require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
          ["core.defaults"] = {}, -- Load all the default modules
          ["core.gtd.base"] = {},
          ["core.norg.completion"] = { config = { engine = "nvim-cmp" } } ,-- We current support nvim-compe and nvim-cmp only
          ["core.norg.concealer"] = {}, -- Allows for use of icons
          ["core.keybinds"] = { -- Configure core.keybinds
            config = {
              default_keybinds = true, -- Generate the default keybinds
              neorg_leader = "<Leader>o" -- This is the default if unspecified
            }
          },
          ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                life = "~/neorg",
                notes = "~/notes",
                chess = "~/chess",
                structures = "~/data-structures",
                work = "~/tasq/",
                rtd = "~/tasq/realtime-deferment/src/",
                setpoints = "~/tasq/setpoint-rec/src/",
                workflow = "~/tasq/workflow/src/"
  
              },
          autodetect = true,
          autochdir = false,
            }
          },
        },
      }
    end,
    requires = "nvim-lua/plenary.nvim"
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

