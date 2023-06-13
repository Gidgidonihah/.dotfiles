"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Gidgidonihah's .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Maintainer:
"       Jason Weir
"       https://github.com/Gidgidonihah
"       @gidgidonihah
"
"   Todo:
"      * See .config/nvim/init.vim
"      * See TODOs in this file
"      * Reorganize this mess. Possibly into multiple files.
"
"   Sections:
"      Help
"      Setup
"      General Style Settings
"          Searching
"      Tips and Tricks
"          Tips to Remember
"          Tips to Forget (or muscle memorized)
"      Files, Backups and Undo
"          Spell Checking
"      Text and Whitespace
"      Movement, Tabs, Windows and Buffers
"      Status line
"      Helper functions
"      Custom Mappings
"      Plugin Settings
"
"   See Also:
"      ~/.config/nvim/init.vim
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Help {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Here's a list of common commands from my plugins:
"
"   Remember to run `:Helptags` to generate helptags from installed bundles
"
"   BufExplorer:
"       <leader>be - Open a buffer from a list of buffers in a buffer
"       <leader>bs - hSplit Open a buffer from a list of buffers in a buffer
"       <leader>bt - Toggle (Close/Open) a buffer from a list of buffers in a buffer
"       <leader>bv - vSplit Open a buffer from a list of buffers in a buffer
"   LoremIpsum:
"       :Loremipsum[!] [WORDCOUNT] [PARAGRAPH_TEMPLATE] [PREFIX POSTFIX] - Insert some random text.
"       :Loreplace [REPLACEMENT] [PREFIX] [POSTFIX] - Replace the random text with something else or simply remove it.
"   TagList:
"       <f3> - Toggle the taglist
"       t - Toggle the taglist
"   Python.vim:
"       https://github.com/vim-scripts/python.vim
"   General:
"       <f4> - Toggle mousemode
"       See tips and tricks section
"   undotree.vim:
"       <f5> - Toggle undotree
"       https://github.com/mbbill/undotree
"   csv.vim:
"       https://github.com/chrisbra/csv.vim#installation
"
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Setup {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " First, remove ALL autocommands so they aren't defined multiple times when .vimrc is sourced again upon save
    autocmd!

    " Enable FZF as a plugin. See https://github.com/junegunn/fzf/blob/master/README-VIM.md
    set rtp+=/usr/local/opt/fzf
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## General Style Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    colorscheme solarized " Give me a nice color scheme.
    set background=dark " Dark background, please.
    set nowrap          " Don't wrap by default. That's icky.
    set ai              " Auto Indent
    set wildmode=list:longest " Autocomplete like you would expect
    set ruler           " show the ruler
    set number          " show line numbers
    set tabstop=4       " tabs are 4 spaces
    set expandtab       " tabs are spaces
    set shiftwidth=4    " shifting moves 4 spaces
    set softtabstop=4   " treat spaces like tabs
    set hidden          " hide buffers instead of closing them when you switch
    set showmatch       " Show matching parens
    set title           " change the terminal's title
    set encoding=utf-8  " utf8 ftw
    set foldlevel=99    " folds should be open by default
    set backupcopy=yes  " Fix for inotify seeing 2 changes
    set textwidth=88    " Up from the default of 80. Be sure to adjust the colorcolumn as well
    set mouse=          " Disable mouse mode by default

    " Full stack indenting
    augroup frontendspacing
        autocmd!
        autocmd FileType markdown,html,htmldjango,css,sass,javascript,js,jsx,javascriptreact,json,typescript,tsx,ts,yaml,yml set tabstop=2
        autocmd FileType markdown,html,htmldjango,css,sass,javascript,js,jsx,javascriptreact,json,typescript,tsx,ts,yaml,yml set softtabstop=2
        autocmd FileType markdown,html,htmldjango,css,sass,javascript,js,jsx,javascriptreact,json,typescript,tsx,ts,yaml,yml set shiftwidth=2
    augroup END

    " Make program
    augroup buildsystems
        autocmd!
        autocmd FileType js setlocal makeprg=node\ %
        autocmd FileType python setlocal makeprg=python\ %
        autocmd FileType ruby,rb setlocal makeprg=ruby\ %
        autocmd FileType sh setlocal makeprg=sh\ %
    augroup END

    " Lines should be less than 90 chars. Show a helpful column
    if exists('+colorcolumn')
      set colorcolumn=89
    endif

    " ### Searching
    set hlsearch " Hilight the found searches
    set incsearch " Incremental Searching
    set ignorecase " ignore case in searching
    set smartcase " Smart case (case insensitive when until an uppercase letter is typed)
    set fileformat=unix

    " Keep search matches in the middle of the window and pulse the line when moving to them.
    if has("gui_running")
        " Only run in the GUI. Doesn't work and simply slows down searching in the terminal
        nnoremap n n:call PulseCursorLine()<cr>
        nnoremap N N:call PulseCursorLine()<cr>
    endif

    " store swap files in one of these directories
    set directory=~/.vim/.tmp,~/tmp,/tmp

    " Show hidden characters
    set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Tips and Tricks {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " ### Tips to Remember {{{
        " See also the helper functions below
        "
        " Git grep for the word under cursor
        nnoremap <leader>a :!gg<Space><c-r><c-W>

        " Yank to the OS clipboard with <leader>y
        map <leader>y "+y

        " Use <leader>d (or <leader>dd or <leader>dj or 20<leader>dd) to delete a line without adding it to the yanked stack
        nnoremap <silent> <leader>d "_d
        " Also in visual mode
        vnoremap <silent> <leader>d "_d

        " Forget to sudo? Worry no more!
        cmap w!! w !sudo tee % >/dev/null

        " Format json using python
        map =j !python -m json.tool

        " Sort lines based on length (valid numeric sort)
        map =s ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'

        " Format xml using xmllint
        map =x !xmllint --format %

        " Quick regex to add quotes around HTML attributes
        cabbrev quotize %s/\([^&^?]\)\(\<[[:alnum:]-]\{-}\)=\([[:alnum:]-#%]\+\)/\1\2="\3"/g

        " View Documentation
        noremap <silent> gd :!open dash://<cword><CR>

        " Easier fold managing
        " noremap <leader>f :setlocal foldmethod=expr<CR>zR<CR> " Open all folds
        " noremap <leader>F :setlocal foldmethod=indent<CR>zM<CR> " Close all folds
        noremap <leader>f zi " toggle all folds
        noremap <leader>F zi " toggle all folds

        " Swap the default folding options
        nnoremap zO zo " Open one level below with zO
        nnoremap zo zO " Open ALL level below with zo

        " Run a shell script while editing
        :command! Sh let f=expand("%")|vnew|execute '.!/bin/sh "' . f . '"'
    " }}}
    " ### Tips to Forget (or muscle memorized) {{{
        " sort python imports according to pep8
        command! -range=% Isort :<line1>,<line2>!  isort --settings-path ~/pyproject.toml --src . -

        " Backspace disables highlighting and closes quickfix window
        noremap <BS> :noh<CR>:cclose<CR>

        noremap ff $zf%<CR>

        " Strip all trailing whitespace from a file, using \w
        nnoremap <leader>w :retab<CR>:%s/\s\+$//<CR>:let @/=''<CR>

        " ALEFix all the things using \af
        nnoremap <leader>af :ALEFix<CR>

        " Edit the vimrc file
        " nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
        nnoremap <silent> <leader>vre :e ~/.vimrc<CR>
        " Source the vimrc file
        " nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
        nnoremap <silent> <leader>vrs :so $MYVIMRC<CR>

        " Open the current markdown file in MacDown
        nnoremap <silent> <leader>emd :!open -a MacDown %:p<CR>

        " Highlight conflict markers
        match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
        " Easily jump to conflict markers
        nnoremap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

        " Auto source this file when written.
        :au! BufWritePost $MYVIMRC source $MYVIMRC

        " Create non-existing parent directories on save.
        augroup BWCCreateDir
            autocmd!
            autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
        augroup END

        " Start scrolling slightly before the cursor reaches an edge
        set scrolloff=3
        set sidescrolloff=5

        " Scroll sideways a character at a time, rather than a screen at a time
        set sidescroll=1

        "Allow motions and back-spacing over line-endings etc
        set backspace=indent,eol,start
        set whichwrap=h,l,b,<,>,~,[,]

    " }}}
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Files, Backups and Undo {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Allow filetype settings
    filetype plugin on

    syntax enable " Syntax highlighting is the shiz

    " Remember where my cursor was last time I was in this file
    if !has('nvim')
        set viminfo='10,\"1000,:20,%,n~/.viminfo
    endif
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Set Filetypes based on extension
    autocmd BufRead * silent! set ff=unix " Seriously, filetype is unix...
    autocmd BufNewFile,BufRead *.less,*.scss,*.sass set filetype=css
    autocmd BufNewFile,BufRead *.tpl,*.pug set filetype=html
    autocmd BufNewFile,BufRead *.txt set filetype=text
    autocmd BufNewFile,BufRead Dockerfile* set filetype=Dockerfile

    " Set omnifunc autocompletion
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

    " Always expand tabs for python
    autocmd FileType py setlocal expandtab

    " Prevent `crontab: temp file must be edited in place` error on osx
    autocmd filetype crontab setlocal nobackup nowritebackup

    """ markdown {{{
    " TODO: Large amount of texts in a markdown file take are CPU intensive and make
    " editing a real pain in the toosh. Turning off these things help a bit, but not
    " enough. I need to figure out how to live a happy life with large markdown files.
    " What plugins/settings are causing problems.
    " Ale, folding, syntax highlighting all contribute.

    " Allow markdown folding (disabled because it significantly slows markdown file opening/editing)
    " let g:markdown_folding = 1

    " Show folding levels in a column
    " autocmd filetype markdown setlocal foldcolumn=2

    " Start all folds level ##+ closed
    " autocmd filetype markdown setlocal foldlevel=1

    " Exec markdown-toc against a markdown file when saving
    augroup markdowntoc
        autocmd!
        autocmd FileType markdown set autoread
        autocmd BufWritePost *.md silent !markdown-toc -i %:p
    augroup END
    """ }}}

    " Enable persistent undo and keep them together in Home
    if has("persistent_undo")
        if has('nvim')
            set undodir=~/.undodir-nvim/
        else
            set undodir=~/.undodir/
        endif
        set undofile
    endif
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Text and Whitespace {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Larger font size for MacVim
    set guifont=Noto\ Mono\ for\ Powerline:h18
    if has('nvim')
        " set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:ver1-CocCursorTransparent/lCursor
        set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
    else
        " # TODO
    endif

    " Allow wrapping on word boundries
    set linebreak

    " Show trailing whitespace, but don't be annoying about it
    " Actually, don't show it because I clear it on save anyway
    " highlight ExtraWhitespace ctermbg=red guibg=red
    " autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    " match ExtraWhitespace /\s\+$/
    " autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    " autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    " autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    " autocmd BufWinLeave * call clearmatches()

    " Hilight debugger blocks
    highlight jweir ctermfg=168 guifg=#d33682
    autocmd ColorScheme * highlight jweir ctermfg=168 guifg=#d33682
    " Note: added todo because TODO isn't being highlighted in markdown files
    2match jweir /@\?jweir\|TODO/
    autocmd BufWinEnter,InsertEnter,InsertLeave * 2match jweir /@\?jweir\|TODO/
    autocmd BufWinLeave * call clearmatches()

    " Change paste without overriding the default buffer. (cp{motion})
    nmap <silent> cp :set opfunc=ChangePaste<CR>g@
    function! ChangePaste(type, ...)
        silent exe "normal! `[v`]\"_c"
        silent exe "normal! p"
    endfunction

    " Text expansion
    ab dbpr /* TODO: @jweir Remove this dbpr block */echo("<pre style='border: 1px solid skyblue; padding: 10px; margin 10px;'>");print_r(    $this);echo("</pre>\n");exit();/* */<esc>v3k<kwwv3l
    ab kl /* */ Lib_Script::debug(array( // TODO: @jweir remove this<cr>$this,<cr>), true, false); /* */<esc>k>>wv2l
    ab smdb {* TODO: @jweir Remove this dbpr block *}<pre style='border: 1px solid skyblue; padding: 10px; margin 10px;'>{$thingy\|@print_r}</pre>{* *}<esc>2kbvw2h
    ab elog /* TODO: @jweir Remove this elog block */error_log('jweir: '.__METHOD__.'::'.__LINE__ . ' ' . $var);<esc>2bvwh
    ab dbel /* TODO: @jweir Remove this dbel block */error_log('jweir: '.   var_export($this, true));/* */<esc>vk<k3wvwh
    ab elt error_log('jweir: '.__METHOD__.'   ·   ' . __FILE__.' +'.__LINE__); // TODO: @jweir remove this debug trace<esc>
    ab trycatch try{  EngineName::methodName();}catch(Exception $e){  Sat_Lib_ResponseMessage::getInstance()->addError($e->getMessage());}<esc>v<v2k<k6wvwh
    ab pdb import bpdb  # Do you have pdbpp installed?bpdb.set_trace()<esc>
    ab vpdb import pdb  # Do you have pdbpp installed?pdb.set_trace()<esc>
    autocmd FileType ruby,rb ab pdb binding.pry<esc>
    ab TODO: TODO @jweir:

    " Expand iff
    autocmd FileType python     :iabbrev <buffer> iff if:<left>
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>

    " python change true => True, false => False
    autocmd FileType python     :iabbrev <buffer> true True
    autocmd FileType python     :iabbrev <buffer> false False

    " js/ruby change True => true, False => false
    autocmd FileType javascript,ruby :iabbrev <buffer> True true
    autocmd FileType javascript,ruby :iabbrev <buffer> False false
    autocmd FileType javascript,ruby :iabbrev <buffer> cl console.log()<left>


    " ### Spell checking {{{

        " Turn On Spell Checking ONLY for specific filetypes
        setlocal spell spelllang=en_us
        set nospell
        autocmd FileType html,text,txt,smarty setlocal spell

        :iabbrev teh the
        :iabbrev seperate separate
    " }}}
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Movement, Tabs, Windows and Buffers {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " bbb to throw you into normal mode from insert mode
    inoremap bbb <esc>bbb
    " www to throw you into normal mode from insert mode
    inoremap www <esc>www
    " kk to throw you into normal mode from insert mode
    inoremap kk <esc>kk
    " jj to throw you into normal mode from insert mode
    inoremap jj <esc>jj
    " kk to throw you into normal mode from insert mode
    inoremap kk <esc>kk
    " jk or kj to throw you into normal mode from insert mode
    inoremap jk <esc>
    inoremap kj <esc>
    " ;w and :w save the file when in insert mode
    inoremap :w <esc>:w
    inoremap ;w <esc>:w

" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Status Line {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    set guioptions-=T " No toolbar for GUI

    " Show status bar
    set laststatus=2

" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Helper Functions (mappings below) {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Toggle mouse mode {{{
    function! ToggleMouse()
        " check if mouse is enabled
        if &mouse == 'a'
            " disable mouse
            set mouse=
        else
            " enable mouse everywhere
            set mouse=a
        endif
    endfunc
    " }}}

    " wrap :cnext/:cprevious and :lnext/:lprevious {{{
    function! WrapCommandNextPrev(direction, prefix)
        if a:direction == "up"
            try
                execute a:prefix . "previous"
            catch /^Vim\%((\a\+)\)\=:E553/
                execute a:prefix . "last"
            catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
            endtry
        elseif a:direction == "down"
            try
                execute a:prefix . "next"
            catch /^Vim\%((\a\+)\)\=:E553/
                execute a:prefix . "first"
            catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
            endtry
        endif
    endfunction
    " }}}

    " Pulse {{{
    function! PulseCursorLine()
        let current_window = winnr()

        windo set nocursorline
        execute current_window . 'wincmd w'

        setlocal cursorline

        redir => old_hi
            silent execute 'hi CursorLine'
        redir END
        let old_hi = split(old_hi, '\n')[0]
        let old_hi = substitute(old_hi, 'xxx', '', '')

        hi CursorLine guibg=#3a3a3a
        redraw
        sleep 20m

        hi CursorLine guibg=#4a4a4a
        redraw
        sleep 30m

        hi CursorLine guibg=#3a3a3a
        redraw
        sleep 30m

        hi CursorLine guibg=#2a2a2a
        redraw
        sleep 20m

        execute 'hi ' . old_hi

        windo set cursorline
        execute current_window . 'wincmd w'
        " TODO Currently this overwrites the end of file notification. That's not helpful
    endfunction
    " }}}
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Custom Mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Toggle Mouse mode
    nnoremap <silent> <F4> :call ToggleMouse()<cr>
    vnoremap <silent> <F4> :call ToggleMouse()<cr>

    " Toggle Comments
    xmap <leader><Space>  <Plug>Commentary
    nmap <leader><Space>  <Plug>CommentaryLine

    " Execute Tests (vim-test)
    nmap <silent> t<C-n> :TestNearest<CR>
    nmap <silent> t<C-f> :TestFile<CR>
    nmap <silent> t<C-s> :TestSuite<CR>
    nmap <silent> t<C-l> :TestLast<CR>
    nmap <silent> t<C-g> :TestVisit<CR>
    let test#strategy = "toggleterm"
    let test#python#pytest#options = '-s'

    " <Home> and <End> go up and down the quickfix list and wrap around
    "nnoremap <silent> <Home> :call WrapCommandNextPrev('up', 'c')<CR>
    "nnoremap <silent> E :call WrapCommandNextPrev('down', 'c')<CR>
    " <C-Home> and <C-End> go up and down the location list and wrap around
    "nnoremap <silent> e :call WrapCommandNextPrev('up', 'l')<CR>
    nnoremap <silent> E :call WrapCommandNextPrev('down', 'l')<CR>

    " Jump to matching pairs easily, with Tab
    nnoremap <Tab> %
    vnoremap <Tab> %

    " Easy window navigation
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

    " No holding shift for vim commands. WooHoo!
    nnoremap ; :
    nnoremap <leader>; ;

    " Remap j and k to act as expected when used on long, wrapped, lines
    nnoremap j gj
    nnoremap k gk

    " Toggle pasting
    set pastetoggle=<F2>

    " Toggle Tlist pane
    nnoremap <silent> <F3> :TlistToggle<CR>
    vnoremap <silent> <F3> :TlistToggle<CR>

    " Toggle undoTree
    nnoremap <F5> :UndotreeToggle<cr>
    nnoremap <F5> :UndotreeToggle<cr>

" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Plugin Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Point the taglist plugin to the ctags executable
    " let Tlist_Ctags_Cmd = '/usr/bin/ctags'
    let Tlist_WinWidth = 40
    let Tlist_Close_On_Select = 1
    let Tlist_Enable_Fold_Column = 1
    let Tlist_File_Fold_Auto_Close = 1
    let Tlist_GainFocus_On_ToggleOpen = 1
    map t :TlistToggle<CR>

    " Enable and configure plugins for vim
    if !has('nvim')
        " Start all my vim only plugins
        packadd YouCompleteMe

        " Set some YCM YouCompleteMe Symantic Triggers
        let g:ycm_semantic_triggers = {
            \   'css': [ 're!\s{4}', 're!:\s+', ],
            \   'html': [ '<', ' ' ],
            \ }
        let g:ycm_language_server =
            \ [
            \   {
            \     'name': 'ruby',
            \     'cmdline': [ '/Users/jason/.asdf/shims/solargraph', 'stdio' ],
            \     'filetypes': ['ruby', 'rb']
            \   }
            \ ]
        let g:ycm_autoclose_preview_window_after_completion = 1
        let g:ycm_autoclose_preview_window_after_insertion = 1
        map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR> " Goto definition
    " Enable and configure plugins for vim
    else
        packadd coc.nvim
        packadd toggleterm.nvim
        " packadd copilot.nvim # Conflicts with airline
        lua require("user.toggleterm")

        " =====================================================
        " Some servers have issues with backup files, see #649.
        set nobackup
        set nowritebackup

        " Give more space for displaying messages.
        set cmdheight=2

        " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
        " delays and poor user experience.
        set updatetime=300

        " Don't pass messages to |ins-completion-menu|.
        set shortmess+=c

        " Always show the signcolumn, otherwise it would shift the text each time
        " diagnostics appear/become resolved.
        if has("nvim-0.5.0") || has("patch-8.1.1564")
          " Recently vim can merge signcolumn and number column into one
          set signcolumn=number
        else
          set signcolumn=yes
        endif

        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ CheckBackspace() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        if has('nvim')
          inoremap <silent><expr> <c-space> coc#refresh()
        else
          inoremap <silent><expr> <c-@> coc#refresh()
        endif

        " Make <CR> auto-select the first completion item and notify coc.nvim to
        " format on enter, <cr> could be remapped by other vim plugin
        inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        " Use `[g` and `]g` to navigate diagnostics
        " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
        " TODO: this needs to be made to work with CTRL-j/k of ale
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <leader>g  <Plug>(coc-definition)
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call ShowDocumentation()<CR>

        function! ShowDocumentation()
          if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
          else
            call feedkeys('K', 'in')
          endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming.
        nmap <leader>rn <Plug>(coc-rename)

        " Formatting selected code.
        xmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)

        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder.
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Applying codeAction to the selected region.
        " Example: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap keys for applying codeAction to the current buffer.
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Apply AutoFix to problem on the current line.
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Run the Code Lens action on the current line.
        nmap <leader>cl  <Plug>(coc-codelens-action)

        " Map function and class text objects
        " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
        xmap if <Plug>(coc-funcobj-i)
        omap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap af <Plug>(coc-funcobj-a)
        xmap ic <Plug>(coc-classobj-i)
        omap ic <Plug>(coc-classobj-i)
        xmap ac <Plug>(coc-classobj-a)
        omap ac <Plug>(coc-classobj-a)

        " Remap <C-f> and <C-b> for scroll float windows/popups.
        if has('nvim-0.4.0') || has('patch-8.2.0750')
          nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
          inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
          inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
          vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        endif

        " Use CTRL-S for selections ranges.
        " Requires 'textDocument/selectionRange' support of language server.
        nmap <silent> <C-s> <Plug>(coc-range-select)
        xmap <silent> <C-s> <Plug>(coc-range-select)

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocActionAsync('format')

        " Add `:Fold` command to fold current buffer.
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " Add `:OR` command for organize imports of the current buffer.
        command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

        " TODO
        " Add (Neo)Vim's native statusline support.
        " NOTE: Please see `:h coc-status` for integrations with external plugins that
        " provide custom statusline: lightline.vim, vim-airline.
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

        " Mappings for CoCList
        " Show all diagnostics.
        nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions.
        nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
        " Show commands.
        nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document.
        nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols.
        nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list.
        nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
        " ============================================="=
        "
        if has("gui_running")
          nnoremap <S-D-{> :tabp<CR>
          vnoremap <S-D-{> :tabp<CR>
          inoremap <S-D-{> :tabp<CR>
          nnoremap <S-D-}> :tabn<CR>
          vnoremap <S-D-}> :tabn<CR>
          inoremap <S-D-}> :tabn<CR>
        endif
    endif

    "Remapping FZF to my muscle memory
    "TODO: add mapping for:
    "* GFiles
    "* GFiles?
    "* Lines
    "* Rg
    "* History
    noremap <C-p> :FZF<CR>
    noremap <leader>t :FZF<CR>
    noremap <leader>T :Buffers<CR>

    " Git files only please for the home directory
    if getcwd() == '/Users/jason'
        let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
    endif

    " Largefile settings
    let g:LargeFile = 10 " in megabytes

    " vim-jsx settings
    let g:jsx_ext_required = 0 " Allow JSX in normal JS files

    " ALE settings
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
    let g:ale_fix_on_save = 1
    let g:ale_fix_on_save = 1
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s (%code%) [%severity%]'
    let g:ale_writegood_options = '--no-adverb --no-tooWordy --no-passive --no-thereIs'
    let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
    \ 'typescript': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
    \ 'typescriptreact': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['black', 'isort'],
    \ 'ruby': ['rubocop', 'remove_trailing_lines', 'trim_whitespace'],
    \ }
    let g:ale_linters = {
    \ 'html': ['alex', 'angular', 'fecs', 'htmlhint', 'proselint', 'stylelint', 'tidy'],
    \ }
    " TODO: get isort working properly (due to `cwd` in cmd), then add as a fixer
    " isort will set the cwd to the basename of the file
    " https://github.com/dense-analysis/ale/blob/f0887d3e6178482255f11aa378124aef3699245f/autoload/ale/fixers/isort.vim#L30
    " I've removed the cwd and given `--src .` to the isort options, allowing
    " it to work, but this is very hacky and a short term solution.
    let g:ale_python_isort_options="--settings-path=/Users/jason/pyproject.toml --src ."
    let g:ale_python_black_options='--config=/Users/jason/pyproject.toml'
    let g:ale_python_pylint_options = '--rcfile=/Users/jason/pyproject.toml'
    let g:ale_python_pylint_change_directory=0
    let g:ale_yaml_yamllint_options='-c /Users/jason/.yamllint'
    let g:ale_python_mypy_options='--ignore-missing-imports'
    let g:ale_writegood_options='--no-passive'

    " vim-indent-guides settings
    let g:indent_guides_start_level = 2 "
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled = 1

    " Airline settings
    let g:airline_theme='simple'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    nnoremap <C-l> :bnext<CR>
    nnoremap <C-h> :bprevious<CR>

    " Modify the default "simple" airline theme. Change the visual mode yuck yellow to pretty pink
    function! AirlineThemePatch(palette)
        if g:airline_theme == 'simple'
            let s:V1 = [ '#1a1a18' , '#ab3e5d', 007, 161 ] " Custom colors: blackestgravel & raspberry
            let s:V2 = [ '#ff5f00' , '#1c1c1c', 202, 234 ] " Standard colors
            let s:V3 = [ '#767676' , '#080808', 243, 232 ] " Standard colors
            let a:palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
            let a:palette.visual_modified = copy(a:palette.visual)
        endif
    endfunction
    let g:airline_theme_patch_func = 'AirlineThemePatch'

    " Vim-Table-Mode settings {{{
    function! s:isAtStartOfLine(mapping)
        let text_before_cursor = getline('.')[0 : col('.')-1]
        let mapping_pattern = '\V' . escape(a:mapping, '\')
        let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
        return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
    endfunction

    " Markdown safe corners
    let g:table_mode_corner='|'

    " Easy enter table mode with ||| as first chars on a line
    inoreabbrev <expr> <bar><bar>
              \ <SID>isAtStartOfLine('\|\|\|') ?
              \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
    " }}}

    " CSV.vim settings
    let g:csv_highlight_column = 'y'
    hi link CSVColumnOdd MoreMsg
    hi link CSVColumnEven Question

    "" Minimap settings
    let g:minimap_toggle='<leader>mm'
    let g:minimap_highlight='VisualNOS'

    " vim-grepper settings
    map <leader>x  :GrepperGit <cword><CR> " Grep for the current word
    " Also search for the current word with \s, but that competes for time
    map <leader>s  :GrepperGit <cword><CR> " Grep for the current word

    " vimdiff settings
    " TODO: remap <C-j> and <C-k>
    if &diff
      nnoremap <expr> <C-J> ']c'
      nnoremap <expr> <C-K> '[c'
    endif

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Testing Section (should be empty at commit) {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
