set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" TODO @jweir: read this: https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2

" https://github.com/glepnir/dashboard-nvim
" # TODO: https://github.com/APZelos/blamer.nvim
" TODO @jweir: https://github.com/tpope/vim-dispatch
" (https://vi.stackexchange.com/questions/16821/how-to-set-a-shortcut-to-run-make-in-vim-and-show-the-output)
"
" https://github.com/junegunn/fzf.vim
"
" TODO:
" - [ ] don't load all plugins at start. Load them as needed. e.g. rails only needed if
"       ruby code. phpcomplete.vim only if php. vim-go if go etc.
" - [ ] Drop solarized in favor of a monokai based on solarized
"       https://github.com/chriskempson/base16
" - [ ] Use bg=dark/light based on os sytem setting
"       https://www.reddit.com/r/vim/comments/kchos2/macos_autoset_background/
" - [ ] investigate plugins below
" - [ ] Be sure coc plugins are installed on first run. See below.
" - [ ] remap <leader>vre to edit vimrc, rather than this file, but only after all the
"       other TODOs in this file are dones
" - [ ] Check out this frontend candidates config: https://github.com/afreidz/nvim
" - [ ] Try replacing the pulse line function with https://github.com/inside/vim-search-pulse
" - [ ] Take a look at incorporating parts of these
"     * https://git.herrbischoff.com/awesome-macos-command-line/about/
"     * https://git.herrbischoff.com/awesome-command-line-apps/about/
"     * https://github.com/L0stSoul/vim-config
"     * https://github.com/victorvoid/vim-frontend
"     * https://dougblack.io/words/a-good-vimrc.html
"     * https://github.com/rockerBOO/awesome-neovim
"
" ## Plugins to try out
"
" Install these and play with them.
"
" * https://github.com/nvim-neotest/neotest
" * https://github.com/RRethy/vim-illuminate
" * https://github.com/goolord/alpha-nvim
" * https://github.com/nvim-treesitter/nvim-treesitter
"
"
" ## Plugins to investigate:
"
" We may want to install these. We may not. But at least look at them.
"
" * https://github.com/lukas-reineke/indent-blankline.nvim
" * https://github.com/folke/trouble.nvim
" * https://github.com/nvim-telescope/telescope.nvim
" * https://github.com/lewis6991/impatient.nvim
" * https://github.com/mfussenegger/nvim-dap - interactive debugging
" * https://github.com/voldikss/vim-floaterm
" * https://github.com/dstein64/vim-startuptime
" * replace airline with https://github.com/nvim-lualine/lualine.nvim?
" * https://github.com/akinsho/bufferline.nvim
" * https://github.com/kyazdani42/nvim-web-devicons
"   - https://github.com/ryanoasis/vim-devicons
"
"
" ## Config to investigate:
"
" Full vim config that may have interesting parts in it
"
" * https://github.com/LunarVim/nvim-basic-ide/tree/master/lua/user
"   Nicely organized into separate files. Lua only.
" * https://github.com/LunarVim/Neovim-from-scratch
"   Basically forked off the above
"
" ## COC installed plugins
"
" Be sure these are installed on first run. Or are they just committed in my dotfiles and
" run by default. Need to try a fresh install to be sure.
"
" * coc-pyright 1.1.255 ~/.config/coc/extensions/node_modules/coc-pyright
" * coc-html 1.6.1 ~/.config/coc/extensions/node_modules/coc-html
" + coc-yaml 1.7.5 ~/.config/coc/extensions/node_modules/coc-yaml
" + coc-tsserver 1.10.5 ~/.config/coc/extensions/node_modules/coc-tsserver
" + coc-solargraph 1.2.4 ~/.config/coc/extensions/node_modules/coc-solargraph
" + coc-json 1.4.2 ~/.config/coc/extensions/node_modules/coc-json
" + coc-css 1.3.0 ~/.config/coc/extensions/node_modules/coc-css
"
"
" ## Other possible themes
"
" * https://github.com/folke/tokyonight.nvim
