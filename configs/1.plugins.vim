" Neovim 配置文件 - 插件
"
" 作者: 谭化成
" 邮箱: huacheng.tan@foxmail.com


" molokai {{{
" let g:molokai_original = 1
"
" colorscheme molokai
" }}}


" gruvbox {{{
set background=dark " dark, light

let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'medium' " soft, medium, hard
" let g:gruvbox_contrast_light = 'medium'

colorscheme gruvbox
" }}}


" airline {{{
let g:airline_powerline_fonts = 1
let g:airline_symbols = {}
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

" airline#tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s '
" }}}


" airline-clock {{{
let g:airline#extensions#clock#format = '%H:%M'
let g:airline#extensions#clock#updatetime = 1000
" }}}


" tagbar {{{
let s:win_reserved = 7      " space for number and sign

let g:tagbar_left = 1
let g:tagbar_width = 34
let g:tagbar_zoomwidth = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 1

function! GetTagbarType(type)
    return {
    \ 'ctagstype': a:type,
    \ 'ctagsbin': g:cfg_root . '/bin/to_ctags.py',
    \ 'ctagsargs': '-f -' . ' -t ' . a:type . ' --sort=yes',
    \ 'kinds': [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro': '|',
    \ 'kind2scope': {
        \ 's': 'section',
    \ },
    \ 'sort': 0,
    \ }
endfunction

let g:tagbar_type_markdown = GetTagbarType('markdown')
let g:tagbar_type_rfc      = GetTagbarType('rfc')

if ((&textwidth + s:win_reserved + g:tagbar_width + 1) <= winwidth(0) && !&diff)
    au VimEnter * nested :call tagbar#autoopen(0)
endif
" }}}


" nerdtree {{{
" let g:loaded_nerd_tree = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeWinSize = 30
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1

au bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}


" nerdtree-git-plugin {{{
" 设置了 NERDTreeRespectWildIgnore, 且使用了 wildignore 插件, 忽略了的文件不会在 nerdtree 中列出
" let g:NERDTreeShowIgnoredStatus = 1 " a heavy feature may cost much more time
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : '✹',
    \ "Staged"    : '✚',
    \ "Untracked" : '✭',
    \ "Renamed"   : '➜',
    \ "Unmerged"  : '═',
    \ "Deleted"   : '✖',
    \ "Dirty"     : '✗',
    \ "Clean"     : '✔︎',
    \ 'Ignored'   : '☒',
    \ "Unknown"   : '?'
    \ }
" }}}


" undotree {{{
let g:undotree_CustomUndotreeCmd  = 'topleft vertical 24 new'
let g:undotree_CustomDiffpanelCmd = 'botright 10 new'
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_HelpLine = 0

au WinEnter undotree_* vertical resize 24
" }}}


" ctrlp {{{
" let g:loaded_ctrlp = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
" }}}


" indent-guides {{{
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'markdown', 'rfc']
" }}}


" signature {{{
let g:SignatureMarkTextHLDynamic = 1
let g:SignatureMarkerTextHLDynamic = 1
" }}}


" better-whitespace {{{
let g:show_spaces_that_precede_tabs = 1

func CheckBetterWhitespace()
    if &readonly || !&modifiable | exe 'DisableWhitespace' | else | exe 'EnableWhitespace' | endif
endf

au WinEnter,BufWinEnter,TermEnter * call CheckBetterWhitespace()
au VimEnter * ++once au OptionSet readonly,modifiable call CheckBetterWhitespace()
" }}}


" ack {{{
let g:ackprg = 'ag --vimgrep'
let g:ack_qhandler = 'belowright copen'
let g:ack_lhandler = 'belowright lopen'
let g:ackhighlight = 1
" }}}


" delimitMate {{{
" let g:loaded_delimitMate = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
" let g:delimitMate_balance_matchpairs = 1

au FileType rust     let b:delimitMate_matchpairs = '(:),{:},[:]'
au FileType python   let b:delimitMate_nesting_quotes = ['"', "'"]
au FileType markdown let b:delimitMate_nesting_quotes = ['`']
au FileType markdown let b:delimitMate_expand_space = 0
" }}}


" nerdcommenter {{{
" let g:loaded_nerd_comments = 1
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_c = 1
" }}}


" gitwildignore {{{
" 启用该选项, &wildignore 中将包含 `git ls-files -oi --exclude-standard --directory` 列出的文件. 如
" 果文件太多, 可以禁用该选项, 但是插件不能处理 'negated ignores'(.gitignore 中前置 ! 的项)
" let g:gitwildignore_use_ls_files = 0
" }}}


" coc {{{
let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-vimlsp',
            \ 'coc-json',
            \ 'coc-python',
            \ 'coc-rls',
            \ ]
" }}}


" vim: foldmethod=marker
