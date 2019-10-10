" GVim 配置文件
"
" 作者: 谭化成
" 邮箱: tanhc.gz@gmail.com


set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T

set guifont=Monospace\ Regular\ 11


set winaltkeys=no


noremap <silent> <f11> :call system('wmctrl -ir ' . v:windowid . ' -b toggle,fullscreen &')<cr>
