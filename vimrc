" Vim 配置文件
"
" 作者: 谭化成
" 邮箱: tanhc.gz@gmail.com


let g:cfg_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')


set nocompatible


" langmenu 选项必须在 syntax 和 filetype 打开前设置. Vim 可能在本文件前 source 其它配置文件, 须确保
" 它们没有在这些配置文件中(例如: /etc/vim/vimrc)被打开过
set langmenu=zh_cn.utf-8
language message zh_CN.UTF-8

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,gbk,big5,euc-jp,euc-kr,default,latin1
set fileformat=unix
set fileformats=unix,dos,mac


syntax on
filetype plugin indent on


set termguicolors

if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set nonumber
set cursorline
set textwidth=100
set colorcolumn=+1

set display=truncate

set laststatus=2
set ruler
set showcmd
set showmatch

set foldmethod=syntax
set foldlevelstart=99

set splitright
set noequalalways

set mouse=a
set mousehide

set diffopt+=iwhite

let c_no_curly_error = 1
let c_comment_strings = 1

set updatetime=200
set lazyredraw


set ttimeout
set ttimeoutlen=20

set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set shiftround

set autoindent
set backspace=indent,eol,start

set completeopt=longest,menu
set wildmenu
set wildmode=longest:full,full

set clipboard=unnamedplus,autoselect

set nrformats-=octal

set ignorecase
set smartcase
set incsearch
set hlsearch

set autoread
set autowrite
set nobackup
set hidden

set history=200

exe 'set' 'undodir=' . g:cfg_root . '/.undodir'
set undofile

set path=.,/usr/include,/usr/local/include


" 打开时光标跳转到文件最后关闭时的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
au BufLeave * call AutoSaveWinView()
au BufEnter * call AutoRestoreWinView()


" cscope
set cscopetag                   " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set csto=0                      " check cscope for definition of a symbol before checking ctags

if filereadable("cscope.out")   " add any cscope database in current directory
    cs add cscope.out
elseif $CSCOPE_DB != ""         " else add the database pointed to by environment variable
    cs add $CSCOPE_DB
endif

set cscopeverbose               " show msg when any other cscope db added
set csqf=s-,d-,c-,t-,e-,i-      " use quickfix window to show cscope results


au BufRead,BufNewFile *.rfc set filetype=rfc

au FileType qf,diff,git set nobuflisted


" source 'configs' 目录下的配置文件
for fname in split(globpath(g:cfg_root . '/configs', '*.vim'))
    exe 'source' fname
endfor


" source 工作目录下项目相关的配置文件
if filereadable(".vimrc.private")
    source .vimrc.private
endif
