set t_Co=256
colo molokai
" Basic
set noerrorbells
set nu
set cursorline
set ruler
syntax on
set showmode
set showcmd
set cmdheight=2

" File
"set autochdir   " 自动切换工作目录

" Indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Search
set hlsearch    " 高亮搜索命中结果
set showmatch
set incsearch
set ignorecase  " 搜索忽略大小写
set smartcase   " 配合ignorecase使用

" Backup
"set undofile " 保留撤销历史
"set backupdir=~/.config/nvim/.backup//  " 备份文件位置
"set directory=~/.config/nvim/.swp//     " 交换文件位置
"set undodir=~/.config/nvim/.undo//      " 操作历史文件位置

" Other
set nobackup " 禁止产生备份文件
set noswapfile  " 禁止产生交换文件
set nowrap

call plug#begin(stdpath('data') . 'plugged')
call plug#end()
