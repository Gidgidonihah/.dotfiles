-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
--
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
  ensure_installed = {
    "bash",
    "css",
    "git_config",
    "helm",
    "html",
    "ini",
    "javascript",
    "json",
    "json5",
    "lua",
    "markdown",
    "mermaid",
    "nginx",
    "python",
    "regex",
    "ruby",
    "sql",
    "terraform",
    "toml",
    "typescript",
    "yaml",
  },

  -- Highlighting settings
  -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#highlight
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Incremental selection
  -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#incremental-selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<Leader>ss",
      node_incremental = "<Leader>si",
      scope_incremental = "<Leader>sc",
      node_decremental = "<Leader>sd",
    },
  },

  -- Indentation
  -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#indentation
  indent = {
    enable = true
  },
}

-- folding
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
