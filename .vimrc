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

" source sql.vim if the file extension is .sql and sql.vim is available in
" either the current directory or in ~/.vim
autocmd BufNewFile,BufRead *.sql if filereadable(expand("~/.vim/sql.vim")) | source ~/.vim/sql.vim | endif


" source jessica.vim if jessica.vim is available in either the current
" directory or in ~/.vim
autocmd BufNewFile,BufRead * if filereadable(expand("~/.vim/jessica.vim")) | source ~/.vim/jessica.vim | endif
