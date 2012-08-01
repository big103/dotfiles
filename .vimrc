syntax on
set nocompatible
set number
filetype on
autocmd FileType c,cpp,perl,rb,php,html,erl set cindent
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
set autoindent
set shiftwidth=4
set backup
set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,euc-jp,cp932
set backspace=indent,eol,start
hi Comment ctermfg=lightblue

set rtp+=~/vimfiles/vundle.git/        #vundleのディレクトリ
call vundle#rc()
Bundle 'Shougo/neocomplcache'        #Bundle...は使用するプラグインを書く。詳細はguthubのREADMEが詳しい。
Bundle 'Shougo/unite.vim'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
filetype plugin indent on     " required!

