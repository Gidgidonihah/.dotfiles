require("nebulous").setup {
  variant = "midnight", -- Possibly
  -- -- Examples below
  -- disable = {
  --   background = true,
  --   endOfBuffer = false,
  --   terminal_colors = false,
  -- },
  -- italic = {
  --   comments   = false,
  --   keywords   = true,
  --   functions  = false,
  --   variables  = true,
  -- },
  -- custom_colors = { -- this table can hold any group of colors with their respective values
  --   LineNr = { fg = "#5BBBDA", bg = "NONE", style = "NONE" },
  --   CursorLineNr = { fg = "#E1CD6C", bg = "NONE", style = "NONE" },

  --   -- it is possible to specify only the element to be changed
  --   TelescopePreviewBorder = { fg = "#A13413" },
  --   LspDiagnosticsDefaultError = { bg = "#E11313" },
  --   TSTagDelimiter = { style = "bold,italic" },
  -- }
}

-- Define the highlight group
vim.api.nvim_set_hl(0, "JWeir", { fg = "#d33682" })

-- Match jweir and TODO patterns
-- Note: This is duplicated in the .vimrc for·
vim.cmd([[
  augroup JWeirHighlight
    autocmd!
    autocmd ColorScheme * lua vim.api.nvim_set_hl(0, "JWeir", { fg = "#d33682" })
    autocmd BufWinEnter,InsertEnter,InsertLeave * 2match JWeir /\c@\?jweir\|TODO/
    autocmd BufWinLeave * call clearmatches()
  augroup END
]])

-- Set the diagnostic virtual text colors (e.g. ale warnings/errors)
vim.cmd([[
  augroup OverrideDiagnostics
    autocmd!
    " Set the diagnostic virtual text to a very light color
    highlight DiagnosticVirtualTextError ctermbg=13 gui=undercurl guifg=#a30237
    highlight DiagnosticVirtualTextWarn ctermbg=13 gui=undercurl guifg=#7a5e16

    " If you want to just revert to grey,
    " highlight DiagnosticVirtualTextError ctermbg=13 gui=undercurl guifg=#5c5658
    " highlight DiagnosticVirtualTextWarn ctermbg=13 gui=undercurl guifg=#5c5658
  augroup END
]])
