return {
  "arborist-ts/arborist.nvim",
  build = ":ArboristUpdate",
  config = function()
    local arborist = require("arborist")

    -- Install parsers
    arborist.setup({
      ensure_installed = {
        "vimdoc", "javascript", "typescript", "c", "lua", "rust",
        "jsdoc", "bash",
      },
      auto_install = true,
    })

    -- Enable highlighting and indentation using Neovim's built-in TS support
    local ts = vim.treesitter

    -- Activate highlighting and indent for installed parsers
    local parser_configs = ts.language.get_loaded_languages() or {}
    for _, lang in ipairs(parser_configs) do
      ts.query.get(lang, "highlights") -- ensures queries are loaded
    end

    -- Markdown: keep regex highlighting
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.cmd("syntax enable")
      end,
    })

    -- Custom parser 'templ'
    arborist.add_parser("templ", {
      url = "https://github.com/vrischmann/tree-sitter-templ.git",
      files = { "src/parser.c", "src/scanner.c" },
      branch = "master",
    })
    vim.treesitter.language.register("templ", "templ")
  end
}
