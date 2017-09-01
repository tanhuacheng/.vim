" Vim configuration file
"
" Author: tanhuacheng
"  Email: tanhc.gz@gmail.com
"
" plugins
" 1) "pathogen" manage your 'runtimepath' with ease, https://github.com/tpope/vim-pathogen.git
" 2) "vimogen" Vim Plugin Manager, https://github.com/rkulla/vimogen
" 3) "molokai" color scheme for vim, https://github.com/tomasr/molokai.git
" 4) "nerdtree" a tree explorer plugin for vim, https://github.com/scrooloose/nerdtree.git
" 5) "nerdtree-git-plugin" A plugin of NERDTree showing git status flags,
"    https://github.com/Xuyuanp/nerdtree-git-plugin.git
" 6) "tagbar" a class outline viewer for vim, https://github.com/majutsushi/tagbar.git
" 7) "undotree" the ultimate undo history visualizer for vim,
"    https://github.com/mbbill/undotree.git
" 8) "ctrlp" Fuzzy file, buffer, mru, tag, etc finder, https://github.com/kien/ctrlp.vim.git
" 9) "vim-surround" quoting/parenthesizing made simple, https://github.com/tpope/vim-surround.git
" 10) "delimitMate" provides automatic closing of quotes, parenthesis, brackets, etc.
"     https://github.com/Raimondi/delimitMate.git
" 11) "vim-fugitive" a Git wrapper so awesome, https://github.com/tpope/vim-fugitive.git
" 12) "vim-airline" lean & mean status/tabline for vim that's light as air,
"     https://github.com/vim-airline/vim-airline.git
" 13) "vim-airline-clock" vim-airline clock extension - for people that easily loose the sense of
"     time in fullscreen vim sessions, https://github.com/enricobacis/vim-airline-clock.git
" 14) "vim-repeat" enable repeating supported plugin maps with ".",
"     https://github.com/tpope/vim-repeat.git
" 15) "vim-indent-guides" visually displaying indent levels in code,
"     https://github.com/nathanaelkane/vim-indent-guides.git
" 16) "a.vim" Alternate Files quickly (.c --> .h etc), https://github.com/vim-scripts/a.vim.git
" 17) "vim-gitgutter" Shows a git diff in the gutter (sign column) and stages/undoes hunks
"     https://github.com/airblade/vim-gitgutter.git
" 18) "vim-signature" Toggle, display and navigate marks,
"     https://github.com/kshenoy/vim-signature.git
" 19) "VisIncr" Produce increasing/decreasing columns of numbers, dates, or daynames,
"     https://github.com/vim-scripts/VisIncr.git
" 20) "vimwiki" Personal Wiki for Vim, https://github.com/vimwiki/vimwiki.git
" 21) "vim-gitwildignore" Append files listed in .gitignore into wildignore,
"     https://github.com/mikewadsten/vim-gitwildignore.git
" 22) "nerdcommenter" Vim plugin for intensely orgasmic commenting,
"     https://github.com/scrooloose/nerdcommenter.git
" 23) "vim-easymotion" Vim motions on speed!, https://github.com/easymotion/vim-easymotion.git


set nocompatible

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax enable
filetype plugin indent on

" coding
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set termencoding=utf-8 " If appears messy code, change this to your terminal encoding
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,gbk,big5,euc-jp,euc-kr,default,latin1

" Prevent that the langmap option applies to characters that result from a mapping.
" If set (default), this may break plugins (but it's backward compatible).
set nolangremap

" Jump to the last position when reopening a file
" Load indentation rules and plugins according to the detected filetype
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" UI
set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set t_Co=256
colorscheme molokai

hi Visual                           ctermbg=236
hi ColorColumn                      ctermbg=235
hi LineNr           ctermfg=239     ctermbg=235

if !has('gui_running') && &termguicolors
    hi Error        guifg=#FFAFFF   guibg=#8F005F
    hi SpellBad                     guibg=#5F0000
    hi SpellCap                     guibg=#00005F
    hi SpellLocal                   guibg=#00005F
    hi SpellRare                                    cterm=reverse
endif

set cursorline
set textwidth=100
set colorcolumn=+1 " highlight one column after 'textwidth'
set number
set showmatch
set ruler
set showcmd
set laststatus=2
set mousehide
set mouse=a
set completeopt=longest,menu
set wildmode=longest:full,full
set wildmenu
set foldmethod=syntax
set foldlevelstart=99
set display=truncate
set splitright
let c_comment_strings = 1

" tab
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" others
set backspace=indent,eol,start
set autoindent
set nrformats-=octal
set ignorecase
set smartcase " when search terms contain capital char, then do noignorecase
set incsearch
set hlsearch
set autowrite
set nobackup
set hidden
set history=1000
set undodir=~/.vim/.undodir
set undofile
set ttimeout
set ttimeoutlen=400
set updatetime=1000
set path=.,/usr/include,/usr/local/include
" set clipboard=unnamedplus,autoselect

" cscope
if has("cscope")
    set cscopetag                   " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set csto=0                      " check cscope for definition of a symbol before checking ctags

    if filereadable("cscope.out")   " add any cscope database in current directory
        cs add cscope.out
    elseif $CSCOPE_DB != ""         " else add the database pointed to by environment variable
        cs add $CSCOPE_DB
    endif

    set cscopeverbose               " show msg when any other cscope db added
    set csqf=s-,d-,c-,t-,e-,i-      " use quickfix window to show cscope results
endif

" set filetype c to cpp
" avoid the annoyed highlight for c99 compound literal: foo(&(char){0}), the '{' is highlighted red
" TODO: the following au should be delete if anyone find a ideal solution
au BufRead,BufNewFile *.c set filetype=cpp

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


" plugins

" matchit
packadd matchit

" ctrlp
nmap <C-@> <C-Space>
let g:ctrlp_map ='<C-Space><C-p>'

" nerdtree & tagbar
let g:NERDTreeWinSize = 31
let g:tagbar_width = 40

let s:win_reserved = 7
let s:nerdtree_open = 0
let s:tagbar_open = 0

if ((&textwidth + s:win_reserved + g:NERDTreeWinSize + 1) <= winwidth(0))
    let s:nerdtree_open = 1
    if ((&textwidth + s:win_reserved + g:NERDTreeWinSize + 1 + g:tagbar_width + 1) <= winwidth(0))
        let s:tagbar_open = 1
    endif
else
    if ((&textwidth + s:win_reserved + g:tagbar_width + 1) <= winwidth(0))
        let s:tagbar_open = 1
    endif
endif

" nerdtree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
if (s:nerdtree_open && !&diff)
    au vimenter * NERDTree | wincmd p
endif
au bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdtree-git-plugin
let g:NERDTreeShowIgnoredStatus = 1
let g:NERDTreeIndicatorMapCustom = {
    \ 'Modified'  : 'ο',
    \ 'Staged'    : '●',
    \ 'Untracked' : '□',
    \ 'Renamed'   : '»',
    \ 'Unmerged'  : '⑂',
    \ 'Deleted'   : '–',
    \ 'Dirty'     : 'ѳ',
    \ 'Clean'     : '≡',
    \ 'Ignored'   : 'х',
    \ 'Unknown'   : '?',
    \ }
au VimEnter * hi NERDTreeGitStatusIgnored ctermbg=bg guibg=bg

" tagbar
let g:tagbar_zoomwidth = 0
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 1
let g:tagbar_iconchars = ['▸', '▾']
if (s:tagbar_open && !&diff)
    au VimEnter * nested :call tagbar#autoopen(0)
endif

" undotree
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 29
let g:undotree_DiffAutoOpen = 0
let g:undotree_HighlightChangedText = 0

" airline
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

au VimEnter * AirlineRefresh

" airline-clock
let g:airline#extensions#clock#format = '%H:%M' " '%H:%M:%S'
let g:airline#extensions#clock#updatetime = 2147483647

" indent-guides
if !has('gui_running') && &termguicolors != 1
    let g:indent_guides_auto_colors = 0
    hi IndentGuidesOdd  ctermbg=235
    hi IndentGuidesEven ctermbg=235
endif
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'markdown']

" signature
let g:SignatureMarkTextHLDynamic = 1

" vimwiki
let g:vimwiki_folding = 'list'

" nerdcommenter
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'

" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_balance_matchpairs = 1
au FileType lisp        let b:loaded_delimitMate = 1
au FileType python      let b:delimitMate_nesting_quotes = ['"', "'"]
au FileType markdown    let b:delimitMate_nesting_quotes = ['`']
au FileType markdown    let b:delimitMate_expand_space = 0


" iabbrevs
iabbrev ture true


" maps

" "`" is not "'"
let mapleader = "`"

" the "Q" command starts Ex mode, but you will not need it
map Q gq

imap <C-h> <Backspace>
imap <C-l> <Delete>
imap <C-j> <Left>
imap <C-k> <Right>

imap <expr> <CR> pumvisible() ? "\<C-Y>" : "<Plug>delimitMateCR"

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <leader><C-x> <C-w>x

nmap Y y$

let g:switch_buffer_blacklist = {
    \ 'nerdtree' : 1,
    \ 'undotree' : 1,
    \}
function! SwitchBuffer(dir)
    if (get(g:switch_buffer_blacklist, &filetype))
        return
    endif
    if (!a:dir)
        bn
    else
        bp
    endif
endfunc
nmap <silent> <C-n> :call SwitchBuffer(0)<CR>
nmap <silent> <C-p> :call SwitchBuffer(1)<CR>

nmap <silent> <C-F12> :echo "'ctags --fields=+l -R .' " . system("ctags --fields=+l -R .")<CR>
nmap <silent> <S-F12> :echo "'cscope -Rbq' " . system("cscope -Rbq")<CR>

nmap <silent> <F5> :NERDTreeToggle<CR>
nmap <silent> <F6> :UndotreeToggle<CR>
nmap <silent> <F8> :TagbarToggle<CR>

nmap <silent> gn :GitGutterNextHunk<CR>
nmap <silent> gp :GitGutterPrevHunk<CR>
nmap <silent> gs :GitGutterStageHunk<CR>
nmap <silent> gz :GitGutterUndoHunk<CR>
nmap <silent> gP :GitGutterPreviewHunk<CR>

nmap <silent> gc :pclose<CR>

" "s" Find this C symbol
" "g" Find this definition
" "d" Find functions called by this function
" "c" Find functions calling this function
" "t" Find this text string
" "e" Find this egrep pattern
" "f" Find this file
" "i" Find files #including this file
nmap <silent> <Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <silent> <Space>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

nmap <silent> <Space>n :cn<CR>
nmap <silent> <Space>p :cp<CR>
nmap <silent> <Space>o :botright copen<CR>
nmap <silent> <Space><Space> :ccl<CR>

" easymotion map
map <silent> <leader><leader>. <Plug>(easymotion-repeat)


" Source a private configuration file if available
if filereadable(".vimrc.private")
    source .vimrc.private
endif
