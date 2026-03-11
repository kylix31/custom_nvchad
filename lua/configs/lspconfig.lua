require("nvchad.configs.lspconfig").defaults()

-- LSP server configurations
-- local configs = {
--   -- Vue/TypeScript integration
--   vue = {
--     vue_language_server_path = "/usr/bin/vue-language-server",
--     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
--   },
-- }

-- Language servers to enable
local servers = {
  -- Web development
  "html",
  "cssls",
  "cssmodules_ls",
  "tailwindcss",
  "ts_ls",
  "eslint",
  "vue_ls",

  -- Python
  "pyright",
  "ruff",

  -- Go
  "gopls",

  -- Java
  "jdtls",

  -- Kotlin
  "kotlin_lsp",

  -- Ruby
  "ruby_lsp",
  "rubocop",

  -- Data/Config
  "yamlls",
  "lemminx",
  "sqlls",
  "taplo",
  "protols",

  -- Infrastructure
  "terraformls",
  "dockerls",
  "bashls",

  -- Database
  "prismals",

  -- Disabled servers (uncomment to enable)
  -- "clangd",
  -- "efm",
  -- "phpactor",
  -- "copilot",
  -- "pylsp",
}

-- Configure Vue/TypeScript integration
-- local function setup_vue_typescript()
--   local vue_plugin = {
--     name = "@vue/typescript-plugin",
--     location = configs.vue.vue_language_server_path,
--     languages = { "vue" },
--     configNamespace = "typescript",
--   }

-- vim.lsp.config("vtsls", {
--   settings = {
--     vtsls = {
--       tsserver = {
--         globalPlugins = { vue_plugin },
--       },
--     },
--   },
--   filetypes = configs.vue.filetypes,
-- })

-- vim.lsp.config("ts_ls", {
--   init_options = {
--     plugins = { vue_plugin },
--   },
--   filetypes = configs.vue.filetypes,
-- })
-- end

-- setup_vue_typescript()

vim.lsp.config("tailwindcss", {
  filetypes = {
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir",
    "elixir",
    "ejs",
    "erb",
    "eruby",
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "htmlangular",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "templ",
  },
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
