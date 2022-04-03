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
set updatetime=300
set shortmess+=c
set hidden

if has('nvim-0.5.0') || has('patch-8.1.1564')
    set signcolumn=number
else
    set signcolumn=yes
endif

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
set nowritebackup
set noswapfile  " 禁止产生交换文件
set nowrap

" Auto command
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Automatic install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir, '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
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
" Use tab for trigger completion with characters and navigate
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-N>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

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
