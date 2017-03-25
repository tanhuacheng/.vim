1. mkdir bundle

2. cd bundle/
   git clone https://github.com/rkulla/vimogen

3. ln -s ~/.vim/bundle/vimogen/vimogen ~/bin/vimogen
   ln -s ~/.vim/vimogen_repos ~/.vimogen_repos
   ln -s ~/.vim/ycm_extra_conf.py ~/.ycm_extra_conf.py

4. vimogen
   根据提示选择 install

5. cd bundle/YouCompleteMe/
   git submodule update --init --recursive
   搭建 YouCompleteMe 所需环境
   ./install.py --clang-completer --enable-coverage
