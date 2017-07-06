" Gvim configuration file
"
" Author: tanhuacheng
"  Email: tanhc.gz@gmail.com
"

set gcr=a:block-blinkon0

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T

set guifont=YaHei\ Consolas\ Hybrid\ Powerline\ 12

set winaltkeys=no

map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen &")<CR>
nmap <silent> <leader><C-Space> :call system("~/.vim/capmap.sh restart 96 &")<CR>
