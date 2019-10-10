" Vim 配置文件 - 映射
"
" 作者: 谭化成
" 邮箱: tanhc.gz@gmail.com


" Fix meta-keys {{{
let c = 'a'
while c <= 'z'
    exe 'set <m-' . c . ">=\e" . c
    let c = nr2char(char2nr(c) + 1)
endw
" }}}


" mapleader {{{
let mapleader = '`' " 开单引号, ASCII 码: 96

" 把 '大写锁定键(Caps Lock)' 映射到 '开单引号(`)'. 在所有 Vim 窗口退出前, '大写锁定键' 将不可用
au VimEnter * call job_start([g:cfg_root . '/bin/capmap.sh', 'enter', '96'])
au VimLeave * call system(g:cfg_root . '/bin/capmap.sh exit')

" 切换大小写
nnoremap <silent> <leader><space>
            \ :call job_start([g:cfg_root . '/bin/capmap.sh', 'toggle'])<cr>

" 当映射失效时, 重新开始映射
nmap <leader><nul> <leader><c-space>
nnoremap <silent> <leader><c-space>
            \ :call job_start([g:cfg_root . '/bin/capmap.sh', 'restart', '96'])<cr>
" }}}


" 修改一些不常用的默认功能 {{{
nnoremap Y y$
nnoremap U <c-r>
nnoremap <silent> Q :q<cr>
" }}}


" 类似于 Readline 的 Emacs 模式的行编辑 {{{
imap <c-f> <right>
imap <c-b> <left>

inoremap <m-f> <c-o>e<right>
inoremap <m-b> <c-o>b

imap <c-n> <down>
imap <c-p> <up>

imap <c-e> <end>
imap <c-a> <home>

imap <c-d> <del>
" inoremap <c-h>

inoremap <m-d> <c-o>de
" inoremap <c-w>

inoremap <c-k> <c-o>d$
inoremap <c-u> <c-g>u<c-u>

inoremap <c-l> <c-o>zz
" }}}


" 移动文本 {{{
nnoremap <silent> <m-j> :m .+1<cr>==
nnoremap <silent> <m-k> :m .-2<cr>==

inoremap <silent> <m-j> <esc>:m .+1<cr>==gi
inoremap <silent> <m-k> <esc>:m .-2<cr>==gi

vnoremap <silent> <m-j> :m '>+1<cr>gv=gv
vnoremap <silent> <m-k> :m '<-2<cr>gv=gv
" }}}


" 在窗口中移动 {{{
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" }}}


" location 和 quickfix {{{
nnoremap <silent> <m-n> :lnext<cr>
nnoremap <silent> <m-p> :lprev<cr>
nnoremap <silent> <m-o> :lopen<cr>
nnoremap <silent> <m-i> :lclos<cr>
nnoremap <silent> <m-l> :ll<cr>

nnoremap <silent> <space>n :cnext<cr>
nnoremap <silent> <space>p :cprev<cr>
nnoremap <silent> <space>o :copen<cr>
nnoremap <silent> <space>i :cclos<cr>
nnoremap <silent> <space>l :cc<cr>
" }}}


" tag 和 cscope {{{
nnoremap <silent> <c-f12> :echo "'ctags --fields=+l -R .':" . system('ctags --fields=+l -R .')<cr>
nnoremap <silent> <s-f12> :echo "'cscope -Rbq':" . system('cscope -Rbq')<cr>

" s: Find this C symbol
" g: Find this definition
" d: Find functions called by this function
" c: Find functions calling this function
" t: Find this text string
" e: Find this egrep pattern
" f: Find this file
" i: Find files #including this file
nnoremap <silent> <space>cs :cs find s <c-r>=expand('<cword>')<cr><cr>
nnoremap <silent> <space>cg :cs find g <c-r>=expand('<cword>')<cr><cr>
nnoremap <silent> <space>cd :cs find d <c-r>=expand('<cword>')<cr><cr>
nnoremap <silent> <space>cc :cs find c <c-r>=expand('<cword>')<cr><cr>
nnoremap <silent> <space>ct :cs find t <c-r>=expand('<cword>')<cr><cr>
nnoremap <silent> <space>ce :cs find e <c-r>=expand('<cword>')<cr><cr>
nnoremap <silent> <space>cf :cs find f <c-r>=expand('<cfile>')<cr><cr>
nnoremap <silent> <space>ci :cs find i <c-r>=expand('<cfile>')<cr><cr>
" }}}


" 翻译光标处或选中的文本 {{{
let s:youdao_term_name = '__youdao__'

func OnYoudaoExit(timer_id)
    if expand('%') == s:youdao_term_name
        exe 'normal! gg'
    endif
endf

func YoudaoTranslate(sentence)
    belowright call term_start([g:cfg_root . '/bin/youdao.py', a:sentence], {
                \ 'term_name': s:youdao_term_name,
                \ 'term_rows': '10',
                \ 'exit_cb': { -> timer_start(20, 'OnYoudaoExit') },
                \ })
endf

nnoremap <silent> gy :call YoudaoTranslate(expand('<cword>'))<cr>
vnoremap <silent> gy :<c-u>call YoudaoTranslate(@*)<cr>

au TerminalOpen __youdao__ setlocal noswapfile nobuflisted textwidth=0 winfixheight
" }}}


" 导航 {{{
nmap <c-n> <Plug>AirlineSelectNextTab
nmap <c-p> <Plug>AirlineSelectPrevTab

nnoremap <silent> <f5> :TagbarToggle<cr>
nnoremap <silent> <f6> :UndotreeToggle<cr>
nnoremap <silent> <f8> :NERDTreeToggle<cr>

let g:ctrlp_map = '<m-m>'
" }}}


" gitgutter {{{
let g:gitgutter_map_keys = 0

nnoremap <silent> gQ :GitGutterQuickFix<cr>:bel copen<cr>
nnoremap <silent> gM :GitGutterFold<cr>

nmap gP <Plug>(GitGutterPreviewHunk)
nmap gs <Plug>(GitGutterStageHunk)
nmap gz <Plug>(GitGutterUndoHunk)

nmap gp <Plug>(GitGutterPrevHunk)
nmap gn <Plug>(GitGutterNextHunk)

" 类似于 iw(inner word, 选中当前的词), 下面映射中的 ic 选中当前的 Git Hunk
omap ic <Plug>(GitGutterTextObjectInnerPending)
omap ac <Plug>(GitGutterTextObjectOuterPending)
xmap ic <Plug>(GitGutterTextObjectInnerVisual)
xmap ac <Plug>(GitGutterTextObjectOuterVisual)
" }}}


" better-whitespace {{{
let g:better_whitespace_operator = '<leader>ss'
" }}}


" easymotion {{{
map <silent> <leader><leader>. <Plug>(easymotion-repeat)
" }}}


" ack {{{
nnoremap <silent> <leader>ff :Ack!<cr>
nnoremap <leader>fi :Ack!<space>
" }}}


" coc {{{
"
" <c-n>     : 切换到下一个匹配
" <c-p>     : 切换到上一个匹配
"
" <c-j>     : snippet 的下一个位置
" <c-k>     : snippet 的上一个位置

imap <nul> <c-space>
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<tab>"

nmap <silent> <leader>jj <Plug>(coc-diagnostic-next)
nmap <silent> <leader>kk <Plug>(coc-diagnostic-prev)

nmap <silent> <leader>jo <Plug>(coc-openlink)
nmap <silent> <leader>jD <Plug>(coc-declaration)
nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> <leader>jr <Plug>(coc-references)
nmap <silent> <leader>jf <Plug>(coc-fix-current)

nmap <silent> <leader>rr <Plug>(coc-refactor)
" }}}


" vim: foldmethod=marker
