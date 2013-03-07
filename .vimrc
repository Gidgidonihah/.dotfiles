syntax enable " Syntax highlighting is the shiz
"colorscheme desert " Give me a nice color scheme.
colorscheme solarized " Give me a nice color scheme.
set background=dark "Dark background, please.
set nowrap " Don't wrap by default. That's icky.
set ai " Auto Indent

" Highlight my todos *NOT WORKING* why?
syn match myTodo "\<\l\{2\}TODO\>"
syn match myTodo "\<\l\{2\}todo\>"
hi def link myTodo Todo

" Searching
set hlsearch " Hilight the found searches
set incsearch " Incremental Searching
set ignorecase " ignore case in searching
set smartcase " Smart case (case insensitive when until an uppercase letter is typed)
set fileformat=unix

set wildmode=list:longest " Autocomplete like you would expect
set ruler " show the ruler
set number " show line numbers
set tabstop=4 " tabs are 4 spaces
set noexpandtab " tabs are tabs
set shiftwidth=4	" shifting moves 4 spaces
set hidden			" hide buffers instead of closing them when you switch
set showmatch		" Show matching parens
set title			" change the terminal's title

set pastetoggle=<F2> " Toggle pasting

" Use filetype plugins, e.g. for PHP
filetype plugin on

" PHP Code folding
let php_folding=1
au FileType php set foldmethod=syntax

" Turn On Spell Checking for specific filetypes
setlocal spell spelllang=en_us
set nospell
autocmd FileType html,text,txt,smarty set spell

" Set Filetypes
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.txt set filetype=text

" For CodeKit
set nobackup
set nowritebackup
set noswapfile
set directory=~/.vim/.tmp,~/tmp,/tmp " store swap files in one of these directories (in case swapfile is ever turned on)

"au BufNewFile,BufRead *.less set nobackup
"au BufNewFile,BufRead *.js set nobackup
"au BufNewFile,BufRead *.less set nowritebackup
"au BufNewFile,BufRead *.js set nowritebackup
"au BufNewFile,BufRead *.less set noswapfile
"au BufNewFile,BufRead *.js set noswapfile

" Seriously, filetype is unix...
autocmd BufRead * silent! set ff=unix

" No toolbar
set guioptions-=T

" Autocomplete php functions
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Text expansion
ab dbpr /* jwtodo: Remove this dbpr block */echo("<pre style='border: 1px solid skyblue; padding: 10px; margin 10px;'>");print_r(	$this);echo("</pre>\n");exit();/* */<esc>v3k<kwwv3l
ab smdb {* jwtodo: Remove this dbpr block *}<pre style='border: 1px solid skyblue; padding: 10px; margin 10px;'>{$thingy\|@print_r}</pre>{* *}<esc>2kbvwh
ab elog /* jwtodo: Remove this elog block */error_log(__METHOD__.'::'.__LINE__ . ' ' . $var);<esc>2bvwh
ab dbel /* jwtodo: Remove this dbel block */error_log(	var_export($this, true));/* */<esc>vk<k3wvwh
ab scss {literal}<style><cr>#asdf{<cr><cr>}<cr></style>{/literal}<esc>kki
ab tmpcss {* jwtodo: Remove this fakecss dbpr block *}<link rel="stylesheet" href="http://static.jason.dev.dropship.com/style/tmp.css" type="text/css">
ab trycatch try{	EngineName::methodName();}catch(Exception $e){	Site_Lib_ResponseMessage::getInstance()->addError($e->getMessage());}<esc>v<v2k<k6wvwh
ab addmsg Site_Lib_ResponseMessage::getInstance()->addError($e->getMessage());}<esc>k5wvwh
ab todojw todo && jwtodo: <esc>I// <esc>A
ab ufc Lib_Utility_Functions::log_error(3, SITE_NAME . ' '.$this->view->section, 'Unhandled Fault Code: WHATAREWEDOING. ' . 'File: ' . __FILE__ . ' \|\| Line: ' . __LINE__);<esc>

" Quick regex to add quotes around HTML attributes
cabbrev quotize %s/\([^&^?]\)\(\<[[:alnum:]-]\{-}\)=\([[:alnum:]-#%]\+\)/\1\2="\3"/g

" Remember where my cursor was last time I was in this file
set viminfo='10,\"1000,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"Change paste without overriding the default buffer. (cp{motion})
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

"Backspace disables highlighting
noremap <BS> :noh<CR>
noremap ff $zf%<CR>

"Remapping CtrlP to my muscle memory
noremap <leader>t :CtrlP<CR>
noremap <leader>T :CtrlPBuffer<CR>
noremap <leader><BS> :CtrlPClearCache<CR>

" View Documentation
"noremap <silent> gd :!lynx http://php.net/<cword><CR>
noremap <silent> gd :!open dash://<cword><CR>

" CD into /Volumes/build by default
if isdirectory('/Volumes/build/dropship.com')
	cd /Volumes/build/dropship.com
endif

" Point the taglist plugin to the ctags executable
let Tlist_Ctags_Cmd = '/usr/bin/ctags'

" Creates non-existing parent directories on save.
augroup BWCCreateDir
    au!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

" Auto source this file when written.
:au! BufWritePost $MYVIMRC source $MYVIMRC

" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

" Show trailing whitespace, but don't be annoying about it
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Hilight debugger blocks
highlight jwtodo ctermfg=168 guifg=#d33682
autocmd ColorScheme * highlight jwtodo ctermfg=168 guifg=#d33682
2match jwtodo /jwtodo/
autocmd BufWinEnter * 2match jwtodo /jwtodo/
autocmd InsertEnter * 2match jwtodo /jwtodo/
autocmd InsertLeave * 2match jwtodo /jwtodo/
autocmd BufWinLeave * call clearmatches()

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" No holding shift for vim commands. WooHoo!
nnoremap ; :
nnoremap <leader>; ;

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Forget to sudo? Worry no more!
cmap w!! w !sudo tee % >/dev/null

" Show status bar when in the terminal {{{
if has("gui_running")
   set laststatus=1
else
   set laststatus=2
endif
" }}}

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Yank/paste to the OS clipboard with ,y and ,p
nnoremap <leader>y "+y
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" Edit the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n n:call PulseCursorLine()<cr>
nnoremap N N:call PulseCursorLine()<cr>

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Strip all trailing whitespace from a file, using \w
nnoremap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>

" git grep for the word under cursor
nnoremap <leader>a :!gg<Space><c-r><c-W>


" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
nnoremap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR> " shortcut to jump to next conflict marker
" }}}

" Pulse ------------------------------------------------------------------- {{{
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
