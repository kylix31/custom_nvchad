return {
   ["williamboman/nvim-lsp-installer"] = {},

   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.configs.null-ls").setup()
      end,
   },

   ["folke/trouble.nvim"] = {
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
         require("custom.configs.trouble").setup()
      end,
   },

   ["tpope/vim-fugitive"] = {},

   ["windwp/nvim-ts-autotag"] = {},

   ["iamcco/markdown-preview.nvim"] = {
      ft = "markdown",
      run = "cd app && yarn install",
   },

   ["puremourning/vimspector"] = {},

   ["anuvyklack/pretty-fold.nvim"] = {
      requires = "anuvyklack/nvim-keymap-amend", -- only for preview
      config = function()
         require("pretty-fold").setup()
         require("pretty-fold.preview").setup()
      end,
   },
}
