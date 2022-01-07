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
