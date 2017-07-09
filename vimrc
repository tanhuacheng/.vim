" Vim configuration file
"
" Author: tanhuacheng
"  Email: tanhc.gz@gmail.com
"
" plugins
" 1) "pathogen" manage your 'runtimepath' with ease, https://github.com/tpope/vim-pathogen.git
" 2) "vimogen" Vim Plugin Manager, https://github.com/rkulla/vimogen.git
" 3) "molokai" color scheme for vim, https://github.com/tomasr/molokai.git
" 4) "nerdtree" a tree explorer plugin for vim, https://github.com/scrooloose/nerdtree.git
" 5) "nerdtree-git-plugin" A plugin of NERDTree showing git status flags,
"    https://github.com/Xuyuanp/nerdtree-git-plugin.git
" 6) "tagbar" a class outline viewer for vim, https://github.com/majutsushi/tagbar.git
" 7) "undotree" the ultimate undo history visualizer for vim,
"    https://github.com/mbbill/undotree.git
" 8) "ctrlp" Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder.
"    http://ctrlpvim.github.com/ctrlp.vim, https://github.com/ctrlpvim/ctrlp.vim.git
" 9) "vim-surround" quoting/parenthesizing made simple, https://github.com/tpope/vim-surround.git
" 10) "delimitMate" provides automatic closing of quotes, parenthesis, brackets, etc.
"     https://github.com/Raimondi/delimitMate.git
" 11) "youcompleteme" A code-completion engine for Vim,
"     https://github.com/Valloric/YouCompleteMe.git
" 12) "ultisnips" ultimate solution for snippets in Vim. It has tons of features and is very fast,
"     https://github.com/SirVer/ultisnips.git
" 13) "vim-snippets" snippets files for various programming languages,
"     https://github.com/honza/vim-snippets.git
" 14) "vim-fugitive" a Git wrapper so awesome, https://github.com/tpope/vim-fugitive.git
" 15) "vim-airline" lean & mean status/tabline for vim that's light as air,
"     https://github.com/vim-airline/vim-airline.git
" 16) "vim-airline-clock" vim-airline clock extension - for people that easily loose the sense of
"     time in fullscreen vim sessions, https://github.com/enricobacis/vim-airline-clock.git
" 17) "vim-repeat" enable repeating supported plugin maps with ".",
"     https://github.com/tpope/vim-repeat.git
" 18) "vim-indent-guides" visually displaying indent levels in code,
"     https://github.com/nathanaelkane/vim-indent-guides.git
" 19) "a.vim" Alternate Files quickly (.c --> .h etc), https://github.com/vim-scripts/a.vim.git
" 20) "vim-gitgutter" Shows a git diff in the gutter (sign column) and stages/undoes hunks
"     https://github.com/airblade/vim-gitgutter.git
" 21) "vim-signature" Toggle, display and navigate marks,
"     https://github.com/kshenoy/vim-signature.git
" 22) "VisIncr" Produce increasing/decreasing columns of numbers, dates, or daynames,
"     https://github.com/vim-scripts/VisIncr.git
" 23) "vim-gitwildignore" Append files listed in .gitignore into wildignore,
"     https://github.com/mikewadsten/vim-gitwildignore.git
" 24) "nerdcommenter" Vim plugin for intensely orgasmic commenting,
"     https://github.com/scrooloose/nerdcommenter.git
" 25) "vim-easymotion" Vim motions on speed!, https://github.com/easymotion/vim-easymotion.git
" 26) "vim-markdown" Markdown Vim Mode http://plasticboy.com/markdown-vim-mode/,
"     https://github.com/plasticboy/vim-markdown.git
" 27) "vim-better-whitespace" Better whitespace highlighting for Vim,
"     https://github.com/ntpeters/vim-better-whitespace.git
" 28) "slimv" Superior Lisp Interaction Mode for Vim ("SLIME for Vim"),
"     https://github.com/kovisoft/slimv.git
" 29) "fcitx" keep and restore fcitx state when leaving/re-entering insert mode,
"     https://github.com/lilydjwg/fcitx.vim.git
" 30) "ack" Run your favorite search tool from Vim, with an enhanced results list,
"     https://github.com/mileszs/ack.vim.git
" 31) "vim-airline-themes" A collection of themes for vim-airline,
"     https://github.com/vim-airline/vim-airline-themes.git


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
hi Visual                   ctermbg=236
hi ColorColumn              ctermbg=235
hi LineNr       ctermfg=239 ctermbg=235
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
set clipboard=unnamedplus,autoselect

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
let g:NERDTreeWinSize = 28
let g:tagbar_width = 32

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
let g:undotree_SplitWidth = 26
let g:undotree_DiffAutoOpen = 0
let g:undotree_HighlightChangedText = 0

" youcompleteme
let g:ycm_filetype_blacklist = {
    \ 'nerdtree' : 1,
    \ 'undotree' : 1,
    \ 'tagbar' : 1,
    \ 'qf' : 1,
    \ 'notes' : 1,
    \ 'unite' : 1,
    \ 'vimwiki' : 1,
    \ 'pandoc' : 1,
    \ 'infolog' : 1,
    \ 'mail' : 1
    \}
let g:ycm_open_loclist_on_ycm_diags = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1 " Ctags needs to be called with the --fields=+l
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

" ultisnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<TAB>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" airline
let g:airline_theme =
    \ (has('gui_running') || &termguicolors == 1) ? 'molokai' : 'distinguished'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.crypt = 'λ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" airline#tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
" airline#ycm
let g:airline#extensions#ycm#enabled = 1

au VimEnter * AirlineRefresh

" airline-clock
let g:airline#extensions#clock#format = '%H:%M'
let g:airline#extensions#clock#updatetime = 2147483647

" indent-guides
if !has('gui_running') && &termguicolors != 1
    let g:indent_guides_auto_colors = 0
    hi IndentGuidesOdd  ctermbg=236
    hi IndentGuidesEven ctermbg=235
endif
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'markdown']

" signature
let g:SignatureMarkTextHLDynamic = 1

" nerdcommenter
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'

" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
au FileType lisp        let b:loaded_delimitMate = 1
au FileType python      let b:delimitMate_nesting_quotes = ['"', "'"]
au FileType markdown    let b:delimitMate_nesting_quotes = ['`']
au FileType markdown    let b:delimitMate_expand_space = 0

" slimv
let g:slimv_repl_split = 4
let g:slimv_unmap_cr = 1
let g:paredit_electric_return = 0

" ack
let g:ackprg = 'ag --vimgrep'
" let g:ack_autofold_results = 1
cnoreabbrev ack Ack!


" iabbrevs
iabbrev ture true


" maps

function s:term_map_alt_key(key)
    if !has('gui_running')
        exec "set <M-" . a:key . ">=\e]{0}" . a:key . "~"
    endif
endfunction

" not "'" but "`"
let mapleader = "`"

" use "Caps_Lock" key as "`"(ascii code is 96)
au VimEnter * call system("~/.vim/capmap.sh enter 96 &")
au VimLeave * call system("~/.vim/capmap.sh exit")
nmap <silent> <leader><Space> :call system("~/.vim/capmap.sh toggle &")<CR>
nmap <silent> <leader><C-@> :call system("~/.vim/capmap.sh restart 96 &")<CR>

" the "Q" command starts Ex mode, but you will not need it
map Q gq

inoremap <C-U> <C-G>u<C-U>

call s:term_map_alt_key('h')
call s:term_map_alt_key('l')
imap <expr> <M-h> "<Left>"
imap <expr> <M-l> delimitMate#ShouldJump() ? "<Plug>delimitMateS-Tab" : "<Right>"
imap <expr> <C-h> "<Backspace>"
imap <expr> <C-l> "<Delete>"

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <leader><C-x> <C-w>x

call s:term_map_alt_key('j')
call s:term_map_alt_key('k')
nnoremap <silent> <M-j> :m .+1<CR>==
nnoremap <silent> <M-k> :m .-2<CR>==
inoremap <silent> <M-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <M-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <M-j> :m '>+1<CR>gv=gv
vnoremap <silent> <M-k> :m '<-2<CR>gv=gv

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

nmap <silent> <leader>yi :YcmCompleter GoToInclude<CR>
nmap <silent> <leader>yd :YcmCompleter GoToDeclaration<CR>
nmap <silent> <leader>yD :YcmCompleter GoToDefinition<CR>
nmap <silent> <leader>yf :YcmCompleter FixIt<CR>
nmap <silent> <leader>yl :YcmDiags<CR>

nmap <silent> gn :GitGutterNextHunk<CR>
nmap <silent> gp :GitGutterPrevHunk<CR>
nmap <silent> gs :GitGutterStageHunk<CR>
nmap <silent> gz :GitGutterUndoHunk<CR>
nmap <silent> gP :GitGutterPreviewHunk<CR>

nmap <silent> gy :echo system("~/.vim/youdao.py " . expand("<cword>"))<CR>

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

" quickfix location and preview
nmap <silent> <Space>n :cnext<CR>
nmap <silent> <Space>p :cprev<CR>
nmap <silent> <Space>o :botright copen<CR>
nmap <silent> <Space><Space> :cclose<CR>

call s:term_map_alt_key('n')
call s:term_map_alt_key('p')
call s:term_map_alt_key('o')
call s:term_map_alt_key('i')
nmap <silent> <M-n> :lnext<CR>
nmap <silent> <M-p> :lprev<CR>
nmap <silent> <M-o> :lopen<CR>
nmap <silent> <M-i> :lclos<CR>

nmap <silent> gc :pclose<CR>

" easymotion map
map <silent> <leader><leader>. <Plug>(easymotion-repeat)


" Source a private configuration file if available
if filereadable(".vimrc.private")
    source .vimrc.private
endif
