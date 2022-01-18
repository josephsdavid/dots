local mappings = require('user.utils').mappings
require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
          ["core.defaults"] = {}, -- Load all the default modules
          ["core.gtd.base"] = {},
          ["core.integrations.telescope"] = {}, -- Enable the telescope module
          ["core.norg.completion"] = { config = { engine = "nvim-cmp" } } ,-- We current support nvim-compe and nvim-cmp only
          ["core.norg.concealer"] = {}, -- Allows for use of icons
          ["core.norg.qol.toc"] = {},
          ["core.keybinds"] = { -- Configure core.keybinds
            config = {
              default_keybinds = true, -- Generate the default keybinds
              neorg_leader = mappings.norgleader("")-- This is the default if unspecified
            }
          },
          ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                home = "~/neorg",
                notes = "~/neorg/notes",
                personal = "~/neorg/personal",
                work = "~/neorg/work",


                --[[ notes = "~/notes",
                chess = "~/chess",
                structures = "~/data-structures",
                work = "~/tasq/", ]]
                --[[ rtd = "~/tasq/realtime-deferment/src/",
                setpoints = "~/tasq/setpoint-rec/src/",
                workflow = "~/tasq/workflow/src/"
]]
              },
          --[[ autodetect = true,
          autochdir = false, ]]
            }
          },
        },
      }


local neorg_callbacks = require("neorg.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
            { mappings.telescopeleader("l"), "core.integrations.telescope.find_linkable" },
        },

        i = { -- Bind in insert mode
            { mappings.C("l"), "core.integrations.telescope.insert_link" },
        },
    }, {
        silent = true,
        noremap = true,
    })
end)

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
            { mappings.telescopeleader("l"), "core.integrations.telescope.find_linkable" },
        },

        i = { -- Bind in insert mode
            { mappings.C("l"), "core.integrations.telescope.insert_link" },
        },
    }, {
        silent = true,
        noremap = true,
   })
end)

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", mappings.norgleader("gh"), ":tabe ~/neorg/index.norg<CR>", opts)
keymap("n", mappings.norgleader("gn"), ":tabe ~/neorg/notes/index.norg<CR>", opts)
keymap("n", mappings.norgleader("gt"), ":Neorg toc split", opts)
