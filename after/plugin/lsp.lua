local lsp = require("lsp-zero")
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
lsp_capabilities.offsetEncoding = { "utf-16" }

local lsp_on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end


local jdtls_config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

  },

  root_dir = function(fname)
    return lsp.util.find_git_ancestor(fname) or lsp.util.path.dirname(fname)
  end,

}

lsp.extend_lspconfig({
  set_lsp_keymaps = false,
  on_attach = lsp_on_attach,
  capabilities = lsp_capabilities
})

require("lspconfig.configs").z33_lsp = {
  default_config = {
    cmd = { "z33-lsp" },
    filetypes = { "asm" },
    root_dir = require("lspconfig/util").path.dirname
  },
}

require("lspconfig.configs").yals = {
  default_config = {
    cmd = { "node", "/home/ethan/yals/out/server.js", "--stdio" },
    filetypes = { "yacc", "lex" },
    root_dir = require("lspconfig/util").path.dirname,
  },
}

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({})
  end,
})

require('lspconfig')["ltex"].setup({
    settings = {
        ltex = {
            language = "fr",
            completionEnabled = true,
        }
    }
})

require('lspconfig')["yals"].setup({})
require('lspconfig')["pasls"].setup({
  init_options = {
    overloadPolicy = 3,
    publishDiagnostics = true,
    checkSyntax = true,
    insertCompletionAsSnippets = true,
    insertCompletionProcedureBrackets = nil,
    includeWorkspaceFoldersAsUnitPaths = true,
    includeWorkspaceFoldersAsIncludePaths = true,
    documentSymbols = true,
  }
})

local MY_FQBN = "arduino:avr:nano"
--local MY_FQBN = "arduino:samd:mkrwifi1010"
require('lspconfig')["arduino_language_server"].setup {
  cmd = {
    "arduino-language-server",
    "-cli-config", "/path/to/arduino-cli.yaml",
    "-fqbn",
    MY_FQBN
  }
}

--require('lspconfig')['z33_lsp'].setup({})

local luasnip = require('luasnip')
luasnip.config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

require('luasnip.loaders.from_vscode').lazy_load()
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
local cmp_config = lsp.defaults.cmp_config({})
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<CR>"] = cmp.mapping.confirm({
    -- this is the important line
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  }),
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  -- go to next placeholder in the snippet
  ['<Tab>'] = cmp.mapping(function(fallback)
    if luasnip.jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
    end
  end, { 'i', 's' }),
  -- go to previous placeholder in the snippet
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' }),
})

local cmp_sources = {
  { name = "copilot",  priority = 8 },
  { name = "nvim_lsp", priority = 8 },
  { name = "nvim_lua", priority = 7 },
  { name = "luasnip",  priority = 5 },
  { name = "path",     priority = 4 },
  { name = "buffer",   priority = 4 },
}

cmp_config.mapping = cmp_mappings
cmp_config.select = cmp_select
cmp_config.sources = cmp_sources

cmp.setup(cmp_config)

vim.diagnostic.config({
  lsp.defaults.diagnostics({
    virtual_text = true
  })
})
