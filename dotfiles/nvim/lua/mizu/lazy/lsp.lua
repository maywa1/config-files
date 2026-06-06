return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})

        require("mason").setup({
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "pyright",
                "lua_ls",
                "zls",
            },
            handlers = {
                -- Default handler
                function(server_name)
                    vim.lsp.config(server_name, {
                        capabilities = capabilities,
                    })
                    vim.lsp.enable(server_name)
                end,

                -- Zig language server
                zls = function()
                    vim.lsp.config("zls", {
                        root_dir = vim.fs.root(0, { ".git", "build.zig", "zls.json" }),
                        capabilities = capabilities,
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                        on_attach = function(client, bufnr)
                            vim.g.zig_fmt_parse_errors = 0
                            vim.g.zig_fmt_autosave = 0
                        end,
                    })
                    vim.lsp.enable("zls")
                end,

                -- Rust Analyzer
                rust_analyzer = function()
                    vim.lsp.config("rust_analyzer", {
                        capabilities = capabilities,
                        settings = {
                            ["rust-analyzer"] = {
                                cargo = { allFeatures = true },
                                procMacro = { enable = true },
                                check = { command = "clippy" },
                            },
                        },
                        on_attach = function(_, bufnr)
                            local opts = { buffer = bufnr, silent = true }
                            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        end,
                    })
                    vim.lsp.enable("rust_analyzer")
                end,

                -- Lua Language Server
                lua_ls = function()
                    vim.lsp.config("lua_ls", {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "bit", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                    vim.lsp.enable("lua_ls")
                end,
            },
        })

        -- Completion setup
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<Down>"] = cmp.mapping.select_next_item(),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                ["<C-F10>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
        })

        -- Diagnostics configuration
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}

