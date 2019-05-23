# VIM notes

Generic vim has none of the nicieties, but with all the power. For example, opening HUGE files isn't a problem.
If you have a vimrc set up, you can start fresh by providing a differnt vimrc file:
```
vim -u ~/.vimrc-empty
```

<!-- toc -->

- [Resources](#resources)
- [Vim as Language](#vim-as-language)
- [Basics](#basics)
  * [Searching](#searching)
    + [Replacing](#replacing)
  * [Moving](#moving)
    + [By word](#by-word)
    + [Page movement](#page-movement)
  * [Deleting](#deleting)
  * [Undo and Redo](#undo-and-redo)
  * [Repeating](#repeating)
  * [Copy and Paste](#copy-and-paste)
- [Buffers are awesome](#buffers-are-awesome)
  * [Open multiple files (in buffers) at once](#open-multiple-files-in-buffers-at-once)
  * [They act like tabs.](#they-act-like-tabs)
  * [You can run a vim command against multiple buffers at once](#you-can-run-a-vim-command-against-multiple-buffers-at-once)
  * [You can switch between them easily](#you-can-switch-between-them-easily)
- [Plugins](#plugins)
  * [Pathogen](#pathogen)
  * [General Usage Plugins](#general-usage-plugins)
    + [ctrlp.vim](#ctrlpvim)
    + [YouCompleteMe](#youcompleteme)
    + [ale](#ale)
    + [vim-airline](#vim-airline)
    + [vim-airline-themes](#vim-airline-themes)
    + [vim-indent-guides](#vim-indent-guides)
    + [FastFold](#fastfold)
    + [LargeFile](#largefile)
    + [dracula-theme](#dracula-theme)
    + [editorconfig-vim](#editorconfig-vim)
    + [loremipsum](#loremipsum)
    + [shuffle.vim](#shufflevim)
    + [taglist.vim](#taglistvim)
    + [undotree](#undotree)
    + [vim-colors-solarized](#vim-colors-solarized)
    + [vim-repeat](#vim-repeat)
    + [vim-surround](#vim-surround)
  * [Domain Specific Plugins](#domain-specific-plugins)
    + [csscomplete.vim](#csscompletevim)
    + [csv.vim](#csvvim)
    + [html5.vim](#html5vim)
    + [phpcomplete.vim](#phpcompletevim)
    + [python.vim](#pythonvim)
    + [salt-vim](#salt-vim)
    + [SimpylFold](#simpylfold)
    + [typescript-vim](#typescript-vim)
    + [vim-fugitive](#vim-fugitive)
    + [vim-gdscript3](#vim-gdscript3)
    + [vim-javascript](#vim-javascript)
    + [vim-jsx](#vim-jsx)
    + [vim-sort-imports](#vim-sort-imports)
    + [vim-table-mode](#vim-table-mode)
- [Other topics to cover](#other-topics-to-cover)
- [My Vim Config](#my-vim-config)

<!-- tocstop -->

## Resources
* https://danielmiessler.com/study/vim/
* https://www.labnol.org/internet/learning-vim-for-beginners/28820/
* https://statico.github.io/vim2.html

## Vim as Language
See  https://danielmiessler.com/study/vim/#language

## Basics
* `J`: join lines
* `vi file`: open your file in vim
* `:w`: write your changes to the file
* `:q!`: get out of vim (quit), but without saving your changes (!)
* `:wq`: write your changes and exit vim
* `:saveas ~/some/path/`: save your file to that location
* `ZZ`: a faster way to do :wq
* `v`: enter visual mode
* `Ctrl-v`: enter visual block mode

### Searching
`/yoursearchterm`: Basic search
`n`: Next match
`N`: Previous match
`*`: Search for the word under the cursor

#### Replacing
* `:s /foo/bar/g` Change "foo" to "bar" on the CURRENT line
* `:%s /foo/bar/g` Change "foo" to "bar" on EVERY line

### Moving
* `j`: move down one line
* `k`: move up one line
* `h`: move left one character
* `l`: move right one character
* `0`: move to the beginning of the line
* `$`: move to the end of the line
* `^`: move to the first non-blank character in the line

#### By word
* `w`: move forward one word
* `b`: move back one word
* `e`: move to the end of your word
* `W`: move forward one big word
* `B`: move back one big word

#### Page movement
* `H`: move to the top of the screen
* `M`: move to the middle of the screen
* `L`: move to the bottom of the screen
* `123g`: move to line 123
* `gg`: go to the top of the file
* `G`: go to the bottom of the file
* `Ctrl-U`: move up half a screen
* `Ctrl-D`: move down half a screen
* `Ctrl-F`: page down
* `Ctrl-B`: page up

### Deleting
* `x`: exterminate (delete) the character under the cursor
* `X`: exterminate (delete) the character before the cursor
* `dm`: delete whatever you define as a movement, e.g. a word, or a sentence, or a paragraph.
* `dd`: delete the current line
* `dt.`: delete delete from where you are to the period
* `D`: delete to the end of the line

### Undo and Redo
* `u`: undo your last action.
* `Ctrl-r`: redo the last action

### Repeating
`.` allows you to repeat the last command
`dw`: deletes a word
`5.`: delete 5 more words

### Copy and Paste
* `y`: yank (copy) whatever's selected
* `yy`: yank the current line
* `p`: paste the copied (or deleted) text after the current cursor position
* `P`: paste the copied (or deleted) text before the current cursor position



## Buffers are awesome

### Open multiple files (in buffers) at once
```
vi <path to file 1> <path to file 2> …
```

### They act like tabs.
If you use my setup (plugin: vim-airline), they actually show up AS tabs.
They can be FuzzyFound with ctrlp. `:ls` will show open buffers.
With the right settings you can switch between them without saving and they keep a history.
`:e <path to file>`
`:b3`
`:bd 4 5 6`

### You can run a vim command against multiple buffers at once
```
:bufdo %s/searchterm/replacement/ge #(G= global, e=no error if no match)
:bufdo w
```

Can also be done in one command:
```
:bufdo %s/searchterm/replacement/g | update
```
There are of course different tools for this.
`sed` might be better for a search/replace across multiple files.

### You can switch between them easily
* `:bnext`
* `:bprevious`

## Plugins

### Pathogen
All other plugins are installed with [pathogen](https://github.com/tpope/vim-pathogen).
Makes installation of plugins SUPER easy. Just stick it in the autoload folder (~/.vim/autoload/)
and infect your .vimrc:
```
execute pathogen#infect()
```

### General Usage Plugins

If I had to pick my 5 favorite plugins, they would be:
* ctrlp
* YouCompleteMe
* ale
* vim-airline
* as a distant 5th, vim-indent-guides

#### [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) (general)
The best vim plugin out there IMO. Fuzzy find files in your CWD or your open buffers.
Basically, it works like this:
1. Open vim
2. Remember that your file is somewhere inside a directory called include
3. Remember that the file you want is called something like `doodad.py`
4. Invoke CtrlP
5. Type `incddoda` and hit enter
6. Your file will be opened

You can also fuzzy find open buffers by invoking `CtrlPBuffer`.
Will parse your entire tree from the CWD. Can be set to parse the tree from the nearest ancestor that contains
source code revision directories (.git, .gh, .svn). In other words navigate to anywhere within your repo and use
CtrlP to fuzzy find any other file within your repo.

#### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) (general)
THE completion engine for Vim. A _real_ *PITA* to install, but *totally* worth it.
![YouCompleteMe in action](https://camo.githubusercontent.com/1f3f922431d5363224b20e99467ff28b04e810e2/687474703a2f2f692e696d6775722e636f6d2f304f50346f6f642e676966)

#### [ale](https://github.com/w0rp/ale) (general)
Asynchronous linting and syntax checking.
Lints your file and checks syntax without getting in your way.
I used to use syntastic, but it's synchronous and gets in your way.
Ale is better!
![ALE](https://raw.githubusercontent.com/w0rp/ale/master/img/example.gif)

#### [vim-airline](https://github.com/vim-airline/vim-airline) (general)
Awesome little status and tabline.
Adds a status bar at the bottom. Easily configured to show the information you want.
![airline demo](https://github.com/vim-airline/vim-airline/wiki/screenshots/demo.gif)

Adds a tab bar at the top of vim when working with buffers.
![tabline](https://f.cloud.github.com/assets/306502/1072623/44c292a0-1495-11e3-9ce6-dcada3f1c536.gif)

Setup includes also installing `vim-airline-themes` as well as
[installing a patched powerline font](https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts).

#### [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes) (general)
Themes for the airline plugin. I use `simple`

#### [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides) (general)
Shows indentation levels.
Can be toggled on/off. By default: `<leader>ig`
![Indentation Guides](http://i.imgur.com/ONgoj.png)

#### [FastFold](https://github.com/Konfekt/FastFold) (general)
Makes computing folds faster.

#### [LargeFile](https://github.com/vim-scripts/LargeFile) (general)
Makes working with large files in vim supposedly faster.

#### [dracula-theme](https://github.com/dracula/vim) (general)
A dark theme for Vim.
![Screenshot](https://draculatheme.com/assets/img/screenshots/vim.png)

#### [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) (general)
Reads and respects [EditorConfig](https://editorconfig.org) files.
EditorConfig helps maintain consistent coding styles for multiple developers
working on the same project across various editors and IDEs.

#### [loremipsum](https://github.com/vim-scripts/loremipsum) (general)
A dummy text generator.

#### [shuffle.vim](https://github.com/vim-scripts/shuffle.vim) (general)
Do a random shuffle of lines.

#### [taglist.vim](https://github.com/vim-scripts/taglist.vim) (general)
Source code brower.
![taglist](http://vim-taglist.sourceforge.net/images/taglist_php.gif)

#### [undotree](https://github.com/mbbill/undotree) (general)
Visual tree for undo history. Because vim keeps your undo/redo history as a tree,
you can redo things after you've undone them and gone down a different branch.

![UndoTree Screenshot](https://camo.githubusercontent.com/56430626a5444ea2f0249d71f9288775277c7f5d/68747470733a2f2f73697465732e676f6f676c652e636f6d2f736974652f6d6262696c6c2f756e646f747265655f6e65772e706e67)

#### [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) (general)
A Solarized colorscheme for Vim

#### [vim-repeat](https://github.com/tpope/vim-repeat) (general)
Allows repeating plugin maps with `.`.
I installed it for use with vim-surround.

#### [vim-surround](https://github.com/tpope/vim-surround) (general)
Makes changing surrounding characters easy. Quickly change a `'` to a `"` surrounding a word or sentace with 3 keypresses.
Or braces to brackets. Spaces or no spaces. Even wrap html tags around things.


### Domain Specific Plugins

#### [csscomplete.vim](https://github.com/othree/csscomplete.vim) (css)
Up to date CSS completion.

#### [csv.vim](https://github.com/chrisbra/csv.vim) (csv)
Makes working with CSVs a touch nicer:
![Screenshot](http://www.256bit.org/~chrisbra/csv.gif)

#### [html5.vim](https://github.com/othree/html5.vim) (html)
HTML5 and inline SVG omnicomplete function, indent and syntax for Vim

#### [phpcomplete.vim](https://github.com/shawncplus/phpcomplete.vim) (php)
Improves PHP Completion.

#### [python.vim](https://github.com/vim-scripts/python.vim) (python)
Adds a few nicities for python dev.

#### [salt-vim](https://github.com/saltstack/salt-vim) (salt)
Adds syntax highlighting for YAML + Jinja files and
other nicities in sls files.

#### [SimpylFold](https://github.com/tmhedberg/SimpylFold) (python)
Makes folding in python, super easy.

#### [typescript-vim](https://github.com/leafgarland/typescript-vim) (typescript)
Adds Typescript syntax highlighting.

#### [vim-fugitive](https://github.com/tpope/vim-fugitive) (git)
Work with git from within vim.

#### [vim-gdscript3](https://github.com/calviken/vim-gdscript3) (godot game developement)
Adds syntax highlighting and completion for GDScript.

#### [vim-javascript](https://github.com/pangloss/vim-javascript) (javascript)
Improved javascript indentation and syntax support.

#### [vim-jsx](https://github.com/mxw/vim-jsx) (javascript)
Adds syntax highlighting for JSX.

#### [vim-sort-imports](https://github.com/ruanyl/vim-sort-imports) (javascript)
Uses import-sort to sort javascript imports. Similar to iSort.

#### [vim-table-mode](https://github.com/dhruvasagar/vim-table-mode) (markdown)
Makes dealing with markdown tables super simple and NOT a nightmare.

## Other topics to cover

* `cd` & `lcd`
* visual block mode
  * visual block search/replace
* Leveraging GitHub for backup and portability
* :read <filename>
* j to join lines with a space
* Block editing
* ~ will change case
* My personal vim config
* Piping into vim

## My Vim Config

Let's walk through my vimrc and explain what they do.
And you can ask any questions about what you see.
