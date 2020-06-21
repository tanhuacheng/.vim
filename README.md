说明（基于 *Ubuntu 20.04*）
====================================================================================================

### 同步插件

```sh
bin/sync.py
```

### 安装依赖

* *bin/capmap.sh*

  ```sh
  sudo apt install xdotool
  ```

* **ctags** & **cscope**

  ```sh
  sudo apt install universal-ctags cscope
  ```

* **vim-airline**

  ```sh
  sudo apt install powerline
  ```

* **ack.vim**

  ```sh
  sudo apt install silversearcher-ag
  ```

* **coc.nvim**

  ```sh
  sudo apt install curl
  curl -sL install-node.now.sh/lts | sudo bash
  ```

  * ccls - C/C++/Objective-C language server

    ```sh
    sudo apt install ccls
    ```

* **provider-clipboard**

  ```sh
  sudo apt install xsel
  ```

* **provider-python**

  ```sh
  sudo apt install python3-pip
  python3 -m pip install --user --upgrade pynvim
  ```

* **provider-nodejs**

  ```sh
  sudo npm install -g neovim
  ```

### 其它

* 安装字体

  ```sh
  sudo apt install fonts-inconsolata
  ```

* 设置 **Terminal**::**Preferences**::**Profile**::**Text**

  * **Custom font**: `Inconsolata Medium 12`
  * **Cell spacing**::**x width**: `1.15`
