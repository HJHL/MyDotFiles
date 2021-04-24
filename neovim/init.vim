set t_Co=256
colo molokai
let mapleader = ','
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

" Auto command
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Plugin List
call plug#begin(stdpath('data') . 'plugged')
    " coc.nvim
    " need lastest node.js installed
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " LeaderF
    " need install python3 dev and python3 support for neovim
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
call plug#end()

" coc.nvim
"nmap <silent> <M-j> <Plug>(coc-definition)
"nmap <silent> <C-,> <Plug>(coc-references)
"nn <silent> K :call CocActionAsync('doHover')<cr>

" LeaderF
let g:Lf_ShortcutF = "<leader>f"
let g:Lf_WindowPosition = 'popup' " 开启浮动窗口模式
let g:Lf_PreviewInPopup = 1 " 在浮动窗口中显示结果
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
" 以下需要安装global
" 查找引用
noremap <leader>gr : <C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" 查找定义
noremap <leader>gd : <C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" 调转到下一项
noremap <leader>gn : <C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" 调转到上一项
noremap <leader>gp : <C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
