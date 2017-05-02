1. cd ~
   rm -rf .vim
   git clone https://github.com/tanhuacheng/.vim.git

2. cd .vim && mkdir bundle

3. cd bundle/
   git clone https://github.com/rkulla/vimogen.git

4. ln -s ~/.vim/bundle/vimogen/vimogen ~/bin/vimogen
   ln -s ~/.vim/vimogen_repos ~/.vimogen_repos

5. vimogen
   根据提示选择 install

6. 下载以下程序到 ~/bin
   ctags.exe cscope.exe sort.exe
