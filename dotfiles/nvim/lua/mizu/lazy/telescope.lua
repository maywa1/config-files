return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
            -- Set up a keybinding to open the .config/nvim directory
        vim.api.nvim_set_keymap('n', '<leader>pc', '', {
            noremap = true,
            callback = function()
                builtin.find_files({
                    prompt_title = "Neovim Config",
                    cwd = "~/.config/nvim",
                    hidden = true, -- Show hidden files
                })
            end,
            desc = "Find files in Neovim config directory"
        })
    end
}

