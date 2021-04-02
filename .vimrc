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

    " Full stack indenting
    augroup frontendspacing
        autocmd!
        autocmd FileType markdown,html,htmldjango,css,sass,javascript,js,jsx,json,typescript,ts,yaml set tabstop=2
        autocmd FileType markdown,html,htmldjango,css,sass,javascript,js,jsx,json,typescript,ts,yaml set softtabstop=2
        autocmd FileType markdown,html,htmldjango,css,sass,javascript,js,jsx,json,typescript,ts,yaml set shiftwidth=2
    augroup END

    " Lines should be less than 120 chars. Show a helpful column
    if exists('+colorcolumn')
      set colorcolumn=81
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
        command! -range=% Isort :<line1>,<line2>! isort --force-single-line-imports -lai 2 --lines 80 -

        " Backspace disables highlighting
        noremap <BS> :noh<CR>
        noremap ff $zf%<CR>

        " Strip all trailing whitespace from a file, using \w
        nnoremap <leader>w :retab<CR>:%s/\s\+$//<CR>:let @/=''<CR>

        " ALEFix all the things using \af
        nnoremap <leader>af :ALEFix<CR>

        " Edit the vimrc file
        nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
        " Source the vimrc file
        nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

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
    set viminfo='10,\"1000,:20,%,n~/.viminfo
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Set Filetypes based on extension
    autocmd BufRead * silent! set ff=unix " Seriously, filetype is unix...
    autocmd BufNewFile,BufRead *.less,*.scss,*.sass set filetype=css
    autocmd BufNewFile,BufRead *.tpl set filetype=html
    autocmd BufNewFile,BufRead *.txt set filetype=text
    autocmd BufNewFile,BufRead Dockerfile* set filetype=Dockerfile

    " Set omnifunc autocompletion
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

    " Always expand tabs for python
    autocmd FileType py setlocal expandtab

    " Prevent `crontab: temp file must be edited in place` error on osx
    autocmd filetype crontab setlocal nobackup nowritebackup

    """ markdown {{{
    " Allow markdown folding
    let g:markdown_folding = 1

    " Show folding levels in a column
    " autocmd filetype markdown setlocal foldcolumn=2

    " Start all folds level ##+ closed
    autocmd filetype markdown setlocal foldlevel=1

    " Exec markdown-toc against a markdown file when saving
    augroup markdowntoc
        autocmd!
        autocmd FileType markdown set autoread
        autocmd BufWritePost *.md silent !markdown-toc -i %:p
    augroup END
    """ }}}

    " Enable persistent undo and keep them together in home
    if has("persistent_undo")
        set undodir=~/.undodir/
        set undofile
    endif
" }}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Text and Whitespace {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Larger font size for MacVim
    set guifont=Noto\ Mono\ for\ Powerline:h18

    " Allow wrapping on word boundries
    set linebreak

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
    ab pdb import pdb; pdb.set_trace()<esc>

    " Expand iff
    autocmd FileType python     :iabbrev <buffer> iff if:<left>
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>

    " python change true => True, false => False
    autocmd FileType python     :iabbrev <buffer> true True
    autocmd FileType python     :iabbrev <buffer> false False

    " js change True => true, False => false
    autocmd FileType javascript :iabbrev <buffer> True true
    autocmd FileType javascript :iabbrev <buffer> False false
    autocmd FileType javascript :iabbrev <buffer> cl console.log()<left>


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


    " Comment map for blocks of code {{{
    let s:comment_map = {
        \   "ahk": ';',
        \   "bash_profile": '#',
        \   "bashrc": '#',
        \   "bat": 'REM',
        \   "c": '\/\/',
        \   "css": '\/\/',
        \   "conf": '#',
        \   "cpp": '\/\/',
        \   "dbml": '\/\/',
        \   "desktop": '#',
        \   "dockerfile": '#',
        \   "dosini": ';',
        \   "eml": '>',
        \   "fstab": '#',
        \   "go": '\/\/',
        \   "java": '\/\/',
        \   "javascript": '\/\/',
        \   "javascript.jsx": '\/\/',
        \   "js": '\/\/',
        \   "jsx": '\/\/',
        \   "mail": '>',
        \   "markdown": '\/\/',
        \   "php": '\/\/',
        \   "profile": '#',
        \   "python": '#',
        \   "ruby": '#',
        \   "scala": '\/\/',
        \   "sh": '#',
        \   "typescript": '\/\/',
        \   "ts": '\/\/',
        \   "terraform": '#',
        \   "tex": '%',
        \   "vim": '"',
        \   "yaml": '#',
        \   "zsh": '#',
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
            echo "No comment leader found for filetype:" &filetype
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

    " Execute Tests (vim-test)
    nmap <silent> t<C-n> :TestNearest<CR>
    nmap <silent> t<C-f> :TestFile<CR>
    nmap <silent> t<C-s> :TestSuite<CR>
    nmap <silent> t<C-l> :TestLast<CR>
    nmap <silent> t<C-g> :TestVisit<CR>

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

    " Set some YCM YouCompleteMe Symantic Triggers
    let g:ycm_semantic_triggers = {
        \   'css': [ 're!\s{4}', 're!:\s+', ],
        \   'html': [ '<', ' ' ],
        \ }
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_server_python_interpreter = '/usr/local/bin/python3' " Interpret YCM using default python (python 3)
    let g:ycm_python_binary_path = '/usr/local/bin/python3' " Autocomplete using default python (python 3)
    map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR> " Goto definition

    "Remapping CtrlP to my muscle memory
    noremap <leader>t :CtrlP<CR>
    noremap <leader>T :CtrlPBuffer<CR>
    noremap <leader><BS> :CtrlPClearCache<CR>

    " Sane Ignore For ctrlp
    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.\(git\|hg\|svn\)$\|\(tmp\|dist\|coverage\|node_modules\|build\|crux-crul\/lib\)$',
    \ 'file': '\.pyc$\|\.exe$\|\.so$\|\.dat$'
    \ }

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
    " let g:ale_fix_on_save = 0
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s (%code%) [%severity%]'
    let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint'],
    \ 'python': ['black'],
    \ }
    " TODO: get isort working properly (due to `cd` in cmd), then add as a fixer
    " \ 'python': ['black', 'isort'],
    let g:ale_python_black_options='--config=/Users/jweir/Sites/owlet/ci-kit/bin/python/configuration/pyproject.toml'
    let g:ale_python_pylint_change_directory=0
    let g:ale_yaml_yamllint_options='-d "{extends: default, rules: {line-length: {max: 88}}}"'
    let g:ale_python_mypy_options='--ignore-missing-imports'

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

" }}}
