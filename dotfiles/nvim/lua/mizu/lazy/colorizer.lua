-- init.lua or a dedicated configuration file

-- Load and configure lazy.nvim (assuming it's already installed)
return {
    -- Add the colorizer plugin
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require('colorizer').setup({
                '*'; -- Highlight all file types
                '!vim'; -- Exclude specific file types if needed
            }, {
                RGB      = true; -- #RGB hex codes
                RRGGBB   = true; -- #RRGGBB hex codes
                names    = true; -- "Name" codes like Blue or blue
                RRGGBBAA = true; -- #RRGGBBAA hex codes
                rgb_fn   = true; -- CSS rgb() and rgba() functions
                hsl_fn   = true; -- CSS hsl() and hsla() functions
                css      = true; -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn   = true; -- Enable all CSS *functions*: rgb_fn, hsl_fn
                mode     = 'background'; -- Set the display mode (foreground or background)
            })

            -- You can also set specific configurations for certain filetypes:
            -- require('colorizer').setup({
            --     'css';
            --     'javascript';
            -- }, {
            --     RGB      = true;
            --     RRGGBB   = true;
            --     RRGGBBAA = true;
            --     rgb_fn   = true;
            --     hsl_fn   = true;
            --     css      = true;
            --     css_fn   = true;
            --     mode     = 'foreground';
            -- })

            -- Optional: You can also set colorizer to start automatically on opening files
            vim.cmd("ColorizerAttachToBuffer")
        end,
    },
}

-- Optionally, to manually enable Colorizer in specific buffers, use:
-- :ColorizerAttachToBuffer


