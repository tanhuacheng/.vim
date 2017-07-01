Get Start
====================================================================================================

Note that some configurations work on vim8 only, see
http://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/ for how to upgrade it.


1. pull the latest development tree from my git repository

    ```sh
    cd && rm -rf .vim
    git clone https://github.com/tanhuacheng/.vim.git
    ```

2. install dependence software

    ```sh
    sudo apt install git exuberant-ctags cscope silversearcher-ag xdotool build-essential cmake \
    python python-dev python3 python3-dev wmctrl
    ```

3. install vimogen

    ```sh
    cd .vim && mkdir bundle && cd bundle
    git clone https://github.com/rkulla/vimogen.git
    mkdir ~/bin
    ln -s -f ~/.vim/bundle/vimogen/vimogen ~/bin/vimogen
    ```

4. apply config files

    ```sh
    ln -s -f ~/.vim/vimogen_repos ~/.vimogen_repos
    ln -s -f ~/.vim/swank.lisp ~/.swank.lisp
    ```

5. install plugins

    ```sh
    vimogen # choose 1
    ```

6. install YouCompleteMe

    ```sh
    cd ~/.vim/bundle/YouCompleteMe
    git submodule update --init --recursive
    ./install.py --clang-completer --enable-coverage
   ```
