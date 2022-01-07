local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main"
  },
}

parser_configs.norg_meta = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
    files = { "src/parser.c" },
    branch = "main"
  },
}

parser_configs.norg_table = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
    files = { "src/parser.c" },
    branch = "main"
  },
}
require'nvim-treesitter.configs'.setup {
  ignore_install = { "haskell" },
  highlight = {
   enable = true,          -- false will disable the whole extension
   disable = { "c" },    -- list of language that will be disabled
   custom_captures = {        -- mapping of user defined captures to highlight groups
    -- ["foo.bar"] = "Identifier"  -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
   },
  },

  indent = { enable = true, disable = { "yaml" } },

  incremental_selection = {
   enable = true,
   disable = { "cpp", "lua" },
   keymaps = {            -- mappings for incremental selection (visual mappings)
    init_selection = "gnn",     -- maps in normal mode to init the node/scope selection
    node_incremental = "grn",    -- increment to the upper named parent
    scope_incremental = "grc",   -- increment to the upper scope (as defined in locals.scm)
    node_decremental = "grm",    -- decrement to the previous node
   }
  },
  refactor = {
   highlight_definitions = {
    enable = true
   },
   highlight_current_scope = {
    enable = true
   },
   smart_rename = {
    enable = true,
    keymaps = {
     smart_rename = "grr"     -- mapping to rename reference under cursor
    }
   },
   navigation = {
    enable = true,
    keymaps = {
     goto_definition = "gnd",   -- mapping to go to definition of symbol under cursor
     list_definitions = "gnD"   -- mapping to list all definitions in current file
    }
   }
  },
  textobjects = { -- syntax-aware textobjects
  enable = true,
  disable = {},
  keymaps = {
    ["iL"] = { -- you can define your own textobjects directly here
     python = "(function_definition) @function",
     cpp = "(function_definition) @function",
     c = "(function_definition) @function",
     java = "(method_declaration) @function"
    },
    -- or you use the queries from supported languages with textobjects.scm
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["aC"] = "@class.outer",
    ["iC"] = "@class.inner",
    ["ac"] = "@conditional.outer",
    ["ic"] = "@conditional.inner",
    ["ae"] = "@block.outer",
    ["ie"] = "@block.inner",
    ["al"] = "@loop.outer",
    ["il"] = "@loop.inner",
    ["is"] = "@statement.inner",
    ["as"] = "@statement.outer",
    ["ad"] = "@comment.outer",
    ["am"] = "@call.outer",
    ["im"] = "@call.inner"
   }
  },
  ensure_installed = {"python", "norg", "c", "norg_meta", "norg_table"} -- one of "all", "language", or a list of languages
}

