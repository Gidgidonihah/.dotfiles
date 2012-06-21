syntax enable " Syntax highlighting is the shiz
colorscheme desert " Give me a nice color scheme.
set nowrap " Don't wrap by default. That's icky.
set ai " Auto Indent

" Highlight my todos *NOT WORKING* why?
syn match myTodo "\<\l\{2\}TODO\>"
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
set shiftwidth=4 " shifting moves 4 spaces

" Use filetype plugins, e.g. for PHP
filetype plugin on

" Turn On Spell Checking for specific filetypes
setlocal spell spelllang=en_us
set nospell
autocmd FileType html,text,txt,smarty set spell

" Set Filetypes
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.txt set filetype=text

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
ab trycatch try{	EngineName::methodName();}catch(Exception $e){	Site_Lib_ResponseMessage::getInstance()->addError($e->getMessage());}<esc>v<v2k<k6wvwh
ab addmsg Site_Lib_ResponseMessage::getInstance()->addError($e->getMessage());}<esc>k5wvwh

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
noremap <leader>T :CommandTBuffer<CR>
noremap <leader><BS> :CommandTFlush<CR>

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
