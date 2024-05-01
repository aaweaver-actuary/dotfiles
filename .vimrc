" Andy's .vimrc
" Author: Andy Weaver
" Date: 2024-05-01
" Source: https://github.com/andy-weaver/dotfiles or https://github.com/andy-weaver/.vimrc

" enable syntax highlighting
syntax on

" show the line number + relative line number
set number
set relativenumber

" enable mouse support
set mouse=a

" enable line wrapping
set wrap

" keep indentation levels from previous line
set autoindent

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" remap the leader key to space
let mapleader = " "

" source sql.vim if the file extension is .sql and sql.vim is available in either the current directory or in ~/.vim
autocmd BufNewFile,BufRead *.sql if filereadable(expand("~/.vim/sql.vim")) | source ~/.vim/sql.vim | endif
autocmd BufNewFile,BufRead *.sql if filereadable(expand("~/sql.vim")) | source ~/sql.vim | endif
" source jessica.vim if jessica.vim is available in either the current directory or in ~/.vim
autocmd BufNewFile,BufRead * if filereadable(expand("~/.vim/jessica.vim")) | source ~/.vim/jessica.vim | endif
autocmd BufNewFile,BufRead * if filereadable(expand("~/jessica.vim")) | source ~/jessica.vim | endif

" source python.vim if the file extension is .py and python.vim is available in either the current directory or in ~/.vim
autocmd BufNewFile,BufRead *.py if filereadable(expand("~/.vim/python.vim")) | source ~/.vim/python.vim | endif
autocmd BufNewFile,BufRead *.py if filereadable(expand("~/python.vim")) | source ~/python.vim | endif

" source sh.vim if there is a sh or bash shebang in the first 10 lines, and sh.vim is available in either the current directory or in ~/.vim
autocmd BufNewFile,BufRead * if getline(1) =~ "^#!" && getline(2) =~ "sh" && filereadable(expand("~/.vim/sh.vim")) | source ~/.vim/sh.vim | endif
autocmd BufNewFile,BufRead * if getline(1) =~ "^#!" && getline(2) =~ "sh" && filereadable(expand("~/sh.vim")) | source ~/sh.vim | endif

autocmd BufNewFile,BufRead * if getline(1) =~ "^#!" && getline(2) =~ "bash" && filereadable(expand("~/.vim/sh.vim")) | source ~/.vim/sh.vim | endif
autocmd BufNewFile,BufRead * if getline(1) =~ "^#!" && getline(2) =~ "bash" && filereadable(expand("~/sh.vim")) | source ~/sh.vim | endif

" ensure tabs are two spaces when editing a yaml file
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" ensure tabs are four spaces when editing a sql, python, rust, or vim file
autocmd FileType sql,python,rust,vim setlocal ts=4 sts=4 sw=4 expandtab

