require("nvchad.configs.lspconfig").defaults()

-- LSP server configurations
local configs = {
  -- Vue/TypeScript integration
  vue = {
    vue_language_server_path = "/usr/bin/vue-language-server",
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  },
}

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
local function setup_vue_typescript()
  local vue_plugin = {
    name = "@vue/typescript-plugin",
    location = configs.vue.vue_language_server_path,
    languages = { "vue" },
    configNamespace = "typescript",
  }

  vim.lsp.config("vtsls", {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = { vue_plugin },
        },
      },
    },
    filetypes = configs.vue.filetypes,
  })

  vim.lsp.config("ts_ls", {
    init_options = {
      plugins = { vue_plugin },
    },
    filetypes = configs.vue.filetypes,
  })

  vim.lsp.config("vue_ls", {})
end

setup_vue_typescript()
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
