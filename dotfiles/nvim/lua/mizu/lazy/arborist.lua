return {
  "arborist.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("arborist").setup()
  end,
}
