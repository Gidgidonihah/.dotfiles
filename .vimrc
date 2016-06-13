"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Gidgidonihah's .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Maintainer:
"       Jason Weir
"       https://github.com/Gidgidonihah
"       @gidgidonihah
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Help {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   Here's a list of common commands from my plugins:
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
"   Python.vim:
"       https://github.com/vim-scripts/python.vim
"   General:
"       <f4> - Toggle mousemode
"       See tips and tricks section
"
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Setup {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " First, remove ALL autocommands so they aren't defined multiple times when .vimrc is sourced again upon save
    autocmd!

    " Install bundles via Pathagen.
    " ctrlp.vim  editorconfig-vim  LargeFile  syntastic  YouCompleteMe and any other installed bundles
    " Disabling this line disables the above packages
    execute pathogen#infect()

" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## General Style Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    syntax enable " Syntax highlighting is the shiz
    colorscheme solarized " Give me a nice color scheme.
    set background=dark " Dark background, please.
    set nowrap          " Don't wrap by default. That's icky.
    set ai              " Auto Indent
    set wildmode=list:longest " Autocomplete like you would expect
    set ruler           " show the ruler
    set number          " show line numbers
    set tabstop=4       " tabs are 4 spaces
    set expandtab       " tabs are spaces
    set shiftwidth=4	" shifting moves 4 spaces
    set softtabstop=4	" treat spaces like tabs
    set hidden			" hide buffers instead of closing them when you switch
    set showmatch		" Show matching parens
    set title			" change the terminal's title

    " Lines should be less than 120 chars. Show a helpful column
    if exists('+colorcolumn')
      set colorcolumn=121
    endif

    " ### Searching
    set hlsearch " Hilight the found searches
    set incsearch " Incremental Searching
    set ignorecase " ignore case in searching
    set smartcase " Smart case (case insensitive when until an uppercase letter is typed)
    set fileformat=unix

    " Keep search matches in the middle of the window and pulse the line when moving to them.
    nnoremap n n:call PulseCursorLine()<cr>
    nnoremap N N:call PulseCursorLine()<cr>

    " store swap files in one of these directories (in case swapfile is ever turned on)
    " set directory=~/.vim/.tmp,~/tmp,/tmp
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Tips and Tricks {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " ### Tips to Remember {{{
        " See also the helper functions below
        "
        " Git grep for the word under cursor
        nnoremap <leader>a :!gg<Space><c-r><c-W>

        " Yank/paste to the OS clipboard with <leader>y and <leader>p
        nnoremap <leader>y "+y
        nnoremap <leader>Y "+yy
        nnoremap <leader>p "+p
        nnoremap <leader>P "+P

        " Use <leader>d (or <leader>dd or <leader>dj or 20<leader>dd) to delete a line without adding it to the yanked stack
        nnoremap <silent> <leader>d "_d
        " Also in visual mode
        vnoremap <silent> <leader>d "_d

        " Forget to sudo? Worry no more!
        cmap w!! w !sudo tee % >/dev/null

        " Format json using python
        map =j !python -m json.tool

        " Quick regex to add quotes around HTML attributes
        cabbrev quotize %s/\([^&^?]\)\(\<[[:alnum:]-]\{-}\)=\([[:alnum:]-#%]\+\)/\1\2="\3"/g

        " View Documentation
        noremap <silent> gd :!open dash://<cword><CR>

        " Easier fold managing
        noremap <leader>f :set foldmethod=manual<CR>zR<CR> " Open all folds
        noremap <leader>F :set foldmethod=syntax<CR>zM<CR> " Close all folds

        " Run a shell script while editing
        :command! Sh let f=expand("%")|vnew|execute '.!/bin/sh "' . f . '"'
    " }}}
    " ### Tips to Forget (or muscle memorized) {{{
        " sort python imports according to pep8
        command! -range=% Isort :<line1>,<line2>! isort --force_single_line_imports --lines 120 -

        " Backspace disables highlighting
        noremap <BS> :noh<CR>
        noremap ff $zf%<CR>

        " Strip all trailing whitespace from a file, using \w
        nnoremap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>

        " Edit the vimrc file
        nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
        " Source the vimrc file
        nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

        " Highlight conflict markers
        match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
        " Easily jump to conflict markers
        nnoremap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

        " Auto source this file when written.
        :au! BufWritePost $MYVIMRC source $MYVIMRC

        " Create non-existing parent directories on save.
        augroup BWCCreateDir
            au!
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

    " Remember where my cursor was last time I was in this file
    set viminfo='10,\"1000,:20,%,n~/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Set Filetypes based on extension
    autocmd BufRead * silent! set ff=unix " Seriously, filetype is unix...
    autocmd BufNewFile,BufRead *.less,*.scss,*.sass set filetype=css
    autocmd BufNewFile,BufRead *.tpl set filetype=html
    autocmd BufNewFile,BufRead *.txt set filetype=text

    " Set omnifunc autocompletion
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

    " Always expand tabs for python
    autocmd FileType py setlocal expandtab

" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Text and Whitespace {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Show trailing whitespace, but don't be annoying about it
    highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()

    " Hilight debugger blocks
    highlight jweir ctermfg=168 guifg=#d33682
    autocmd ColorScheme * highlight jweir ctermfg=168 guifg=#d33682
    2match jweir /@\?jweir/
    autocmd BufWinEnter,InsertEnter,InsertLeave * 2match jweir /@\?jweir/
    autocmd BufWinLeave * call clearmatches()

    " Change paste without overriding the default buffer. (cp{motion})
    nmap <silent> cp :set opfunc=ChangePaste<CR>g@
    function! ChangePaste(type, ...)
        silent exe "normal! `[v`]\"_c"
        silent exe "normal! p"
    endfunction

    " Text expansion
    ab dbpr /* TODO: @jweir Remove this dbpr block */echo("<pre style='border: 1px solid skyblue; padding: 10px; margin 10px;'>");print_r(	$this);echo("</pre>\n");exit();/* */<esc>v3k<kwwv3l
    ab kl /* */ Lib_Script::debug(array( // TODO: @jweir remove this<cr>$this,<cr>), true, false); /* */<esc>k>>wv2l
    ab smdb {* TODO: @jweir Remove this dbpr block *}<pre style='border: 1px solid skyblue; padding: 10px; margin 10px;'>{$thingy\|@print_r}</pre>{* *}<esc>2kbvw2h
    ab elog /* TODO: @jweir Remove this elog block */error_log('jweir: '.__METHOD__.'::'.__LINE__ . ' ' . $var);<esc>2bvwh
    ab dbel /* TODO: @jweir Remove this dbel block */error_log('jweir: '.	var_export($this, true));/* */<esc>vk<k3wvwh
    ab elt error_log('jweir: '.__METHOD__.'   ·   ' . __FILE__.' +'.__LINE__); // TODO: @jweir remove this debug trace<esc>
    ab trycatch try{	EngineName::methodName();}catch(Exception $e){	Sat_Lib_ResponseMessage::getInstance()->addError($e->getMessage());}<esc>v<v2k<k6wvwh
    ab addmsg Sat_Lib_ResponseMessage::getInstance()->addError($e->getMessage());<esc>k5wvwh

    " ### Spell checking {{{

        " Turn On Spell Checking ONLY for specific filetypes
        setlocal spell spelllang=en_us
        set nospell
        autocmd FileType html,text,txt,smarty setlocal spell

    " }}}
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Movement, Tabs, Windows and Buffers {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " kk to throw you into normal mode from insert mode
    inoremap kk <esc>kk
    " jj to throw you into normal mode from insert mode
    inoremap jj <esc>jj
    " kk to throw you into normal mode from insert mode
    inoremap kk <esc>kk
    " jk to throw you into normal mode from insert mode
    inoremap jk <esc>
    " ;w and :w save the file when in insert mode
    inoremap :w <esc>:w
    inoremap ;w <esc>:w

" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Status Line {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    set guioptions-=T " No toolbar for GUI

    " Show status bar when in the terminal
    if has("gui_running")
       set laststatus=1
    else
       set laststatus=2
    endif

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
    endfunction
    " }}}


    " Comment map for blocks of code {{{
    let s:comment_map = {
        \   "c": '\/\/',
        \   "cpp": '\/\/',
        \   "go": '\/\/',
        \   "java": '\/\/',
        \   "javascript": '\/\/',
        \   "scala": '\/\/',
        \   "php": '\/\/',
        \   "python": '#',
        \   "ruby": '#',
        \   "sh": '#',
        \   "desktop": '#',
        \   "fstab": '#',
        \   "conf": '#',
        \   "profile": '#',
        \   "bashrc": '#',
        \   "bash_profile": '#',
        \   "mail": '>',
        \   "eml": '>',
        \   "bat": 'REM',
        \   "ahk": ';',
        \   "vim": '"',
        \   "tex": '%',
        \ }

    " Toggle comments on a block of code {
    function! ToggleComment()
        if has_key(s:comment_map, &filetype)
            let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " "
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
        else
            echo "No comment leader found for filetype"
        end
    endfunction
    " } }}}

" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Custom Mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Toggle Mouse mode
    nnoremap <silent> <F4> :call ToggleMouse()<cr>
    vnoremap <silent> <F4> :call ToggleMouse()<cr>

    " Toggle Comments
    nnoremap <leader><Space> :call ToggleComment()<cr>
    vnoremap <leader><Space> :call ToggleComment()<cr>

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
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Plugin Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Point the taglist plugin to the ctags executable
    " let Tlist_Ctags_Cmd = '/usr/bin/ctags'

    " Set some YCM YouCompleteMe Symantic Triggers
    let g:ycm_semantic_triggers = {
        \   'css': [ 're!^\s{4}', 're!:\s+' ],
        \   'html': [ '<', ' ' ],
        \ }
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_server_python_interpreter = '/usr/bin/python' " Interpret YCM using Python2.7
    let g:ycm_python_binary_path = '/usr/local/bin/python' " Autocomplete using Python3

    "Remapping CtrlP to my muscle memory
    noremap <leader>t :CtrlP<CR>
    noremap <leader>T :CtrlPBuffer<CR>
    noremap <leader><BS> :CtrlPClearCache<CR>

    " Sane Ignore For ctrlp
    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|tmp$\|node_modules$',
    \ 'file': '\.pyc$\|\.exe$\|\.so$\|\.dat$'
    \ }

    " Largefile settings
    let g:LargeFile = 10 " in megabytes

    " Syntastic Recommended settings
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_python_checkers = ['flake8', 'pylint']

" }}}
