1. cd ~
   rm -rf .vim
   git clone https://github.com/tanhuacheng/.vim.git

2. cd .vim && mkdir bundle

3. cd bundle/
   git clone https://github.com/rkulla/vimogen.git

4. ln -s ~/.vim/bundle/vimogen/vimogen ~/bin/vimogen
   ln -s ~/.vim/vimogen_repos ~/.vimogen_repos
   ln -s ~/.vim/ycm_extra_conf.py ~/.ycm_extra_conf.py

5. vimogen
   根据提示选择 install

6. cd YouCompleteMe/
   git submodule update --init --recursive
   搭建 YouCompleteMe 所需环境
   ./install.py --clang-completer --enable-coverage
