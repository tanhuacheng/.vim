1. mkdir bundle

2. cd bundle/
   git clone https://github.com/rkulla/vimogen

3. cd bundle/vimogen/
   ln -s vimogen ~/bin/

4. vimogen
   根据提示选择 install

5. cd bundle/YouCompleteMe/
   git submodule update --init --recursive
   搭建 YouCompleteMe 所需环境
   ./install.py --clang-completer --enable-coverage
