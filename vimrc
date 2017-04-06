" Vim configuration file
"
" Author: tanhuacheng
"  Email: tanhc.gz@gmail.com
"
" 1. In a unix-like system, you may need to install "gvim"(vim-gnome, vim-gtk, etc) to use the
"    system clipboard(reg "+, "*, or "~)
" 2. In a unix-like system, you may want to use "Vimogen" to installs, updates or removes Vim
"    plugins. It can also keep your plugins synchronized across multiple Vim installs. See
"    https://github.com/rkulla/vimogen for more details
" 3. plugins
"    1) "pathogen" manage your 'runtimepath' with ease, https://github.com/tpope/vim-pathogen.git
"    2) "molokai" color scheme for vim, https://github.com/tomasr/molokai.git
"    3) "nerdtree" a tree explorer plugin for vim, https://github.com/scrooloose/nerdtree.git
"    4) "nerdtree-git-plugin" A plugin of NERDTree showing git status flags,
"       https://github.com/Xuyuanp/nerdtree-git-plugin.git
"    5) "tagbar" a class outline viewer for vim, https://github.com/majutsushi/tagbar.git
"    6) "undotree" the ultimate undo history visualizer for vim,
"       https://github.com/mbbill/undotree.git
"    7) "ctrlp" Fuzzy file, buffer, mru, tag, etc finder, https://github.com/kien/ctrlp.vim.git
"    8) "vim-surround" quoting/parenthesizing made simple, https://github.com/tpope/vim-surround.git
"    9) "delimitMate" provides automatic closing of quotes, parenthesis, brackets, etc.
"        https://github.com/Raimondi/delimitMate.git
"    10) "youcompleteme" A code-completion engine for Vim,
"        https://github.com/Valloric/YouCompleteMe.git
"    11) "ultisnips" ultimate solution for snippets in Vim. It has tons of features and is very fast,
"        https://github.com/SirVer/ultisnips.git
"    12) "vim-snippets" snippets files for various programming languages,
"        https://github.com/honza/vim-snippets.git
"    13) "vim-fugitive" a Git wrapper so awesome, https://github.com/tpope/vim-fugitive.git
"    14) "vim-airline" lean & mean status/tabline for vim that's light as air,
"        https://github.com/vim-airline/vim-airline.git
"    15) "vim-airline-clock" vim-airline clock extension - for people that easily loose the sense of
"        time in fullscreen vim sessions, https://github.com/enricobacis/vim-airline-clock.git
"    16) "vim-repeat" enable repeating supported plugin maps with ".",
"        https://github.com/tpope/vim-repeat.git
"    17) "vim-indent-guides" visually displaying indent levels in code,
"        https://github.com/nathanaelkane/vim-indent-guides.git
"    18) "a.vim" Alternate Files quickly (.c --> .h etc), https://github.com/vim-scripts/a.vim.git
"    19) "vim-gitgutter" Shows a git diff in the gutter (sign column) and stages/undoes hunks
"        https://github.com/airblade/vim-gitgutter.git
"    20) "vim-signature" Toggle, display and navigate marks,
"        https://github.com/kshenoy/vim-signature.git
"    21) "VisIncr" Produce increasing/decreasing columns of numbers, dates, or daynames,
"        https://github.com/vim-scripts/VisIncr.git
"    22) "vimwiki" Personal Wiki for Vim, https://github.com/vimwiki/vimwiki.git

set nocompatible

" vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set termencoding=utf-8 " If appears messy code, change this to your terminal encoding
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,gbk,big5,euc-jp,euc-kr,default,latin1

syntax enable

" Jump to the last position when reopening a file
" Load indentation rules and plugins according to the detected filetype
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
filetype plugin indent on

set t_Co=256
colorscheme molokai
set laststatus=2
set cursorline
hi CursorLine cterm=bold
set textwidth=100
set colorcolumn=+1 " highlight one column after 'textwidth'
set number
set foldmethod=syntax
set foldlevelstart=99

set backspace=indent,eol,start
set autoindent
set autowrite
set nobackup
set history=400
set ruler
set showcmd
set showmatch
set ignorecase
set smartcase " when search terms contain capital char, then do noignorecase
set incsearch
set hlsearch
set mousehide
set hidden
set completeopt=longest,menu
set path=.,/usr/include,/usr/local/include

set wildmode=longest:full,full
set wildmenu

map Q gq
packadd matchit

set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
retab " Do we really need to retab the whole file?

set updatetime=2000

" maps
imap <silent> <C-h> <Backspace>
imap <silent> <C-l> <Delete>
imap <silent> <C-b> <Left>
imap <silent> <C-f> <Right>

noremap <silent> <C-h> <C-w>h
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k
noremap <silent> <C-l> <C-w>l

noremap <silent> <C-F12> :!ctags --fields=+l -R .<CR>


" plugins

" nerdtree
let NERDTreeWinSize = 28
let NERDTreeAutoDeleteBuffer = 1
au vimenter * NERDTree | wincmd p
au bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
noremap <F5> :NERDTreeToggle<CR>

" tagbar
let g:tagbar_width = 32
let g:tagbar_sort = 0
au VimEnter * nested :call tagbar#autoopen(0)
noremap <F8> :TagbarToggle<CR>

" undotree
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 20
let g:undotree_DiffAutoOpen = 0
let g:undotree_HighlightChangedText = 0
noremap <F6> :UndotreeToggle<CR>

" youcompleteme
" -  'text' : 1,
let g:ycm_filetype_blacklist = {
    \ 'nerdtree' : 1,
    \ 'undotree' : 1,
    \ 'tagbar' : 1,
    \ 'qf' : 1,
    \ 'notes' : 1,
    \ 'markdown' : 1,
    \ 'unite' : 1,
    \ 'vimwiki' : 1,
    \ 'pandoc' : 1,
    \ 'infolog' : 1,
    \ 'mail' : 1
    \}
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1 " Ctags needs to be called with the --fields=+l
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
nnoremap yi :YcmCompleter GoToInclude<CR>
nnoremap yd :YcmCompleter GoToDeclaration<CR>
nnoremap yD :YcmCompleter GoToDefinition<CR>
nnoremap yf :YcmCompleter FixIt<CR>

" ultisnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" airline
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nnoremap <c-n> :bn<CR>
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = 'Ξ'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = ''

" airline-clock
let g:airline#extensions#clock#format = '%H:%M' " '%H:%M:%S'
let g:airline#extensions#clock#updatetime = 1000

" indent-guides
if !has('gui_running')
  let g:indent_guides_auto_colors = 0
  hi IndentGuidesOdd  ctermbg=235
  hi IndentGuidesEven ctermbg=235
endif
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1

" gitgutter
nnoremap gn :GitGutterNextHunk<CR>
nnoremap gp :GitGutterPrevHunk<CR>
nnoremap gs :GitGutterStageHunk<CR>
nnoremap gz :GitGutterUndoHunk<CR>
nnoremap gP :GitGutterPreviewHunk<CR>
nnoremap gc :pclose<CR>

" signature
let g:SignatureMarkTextHLDynamic = 1


" Source a private configuration file if available
if filereadable(".vimrc.private")
  source .vimrc.private
endif
