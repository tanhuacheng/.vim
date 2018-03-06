Get Start
====================================================================================================

1. upgrade to **VIM8**

    http://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/

2. pull the latest development tree from my git repository

    ```sh
    cd && rm -rf .vim
    git clone https://github.com/tanhuacheng/.vim.git
    ```

3. install dependence software

    ```sh
    sudo apt install git exuberant-ctags cscope silversearcher-ag xdotool build-essential cmake \
    python python-dev python3 python3-dev wmctrl
    ```

4. install vimogen

    ```sh
    cd .vim && mkdir bundle && cd bundle
    git clone https://github.com/rkulla/vimogen.git
    mkdir ~/bin
    ln -s -f ~/.vim/bundle/vimogen/vimogen ~/bin/vimogen
    ```

5. apply config files

    ```sh
    ln -s -f ~/.vim/vimogen_repos ~/.vimogen_repos
    ln -s -f ~/.vim/swank.lisp ~/.swank.lisp
    ```
    If use **konsole**, cat default.keytab to ~/.local/share/konsole/default.keytab. otherwise you
    may need to modify the behavior of function `term_map_alt_key` in vimrc, or change your terminal
    keymap.

    ```sh
    cat ~/.vim/default.keytab >> ~/.local/share/konsole/default.keytab
    ```

6. install plugins

    ```sh
    vimogen # choose 1
    ```

7. install YouCompleteMe

    ```sh
    cd ~/.vim/bundle/YouCompleteMe
    git submodule update --init --recursive
    ./install.py --clang-completer
   ```

8. upgrade gdb to latest version for **Termdebug**

    https://www.gnu.org/software/gdb/
