## 开始(基于 Ubuntu 18.04)


* 安装依赖

    ```sh
    sudo apt install exuberant-ctags cscope silversearcher-ag xdotool python3-pip curl

    curl -sL install-node.now.sh/lts | sudo bash
    ```

* 安装和更新插件

    ```sh
    bin/sync.py
    ```

* 安装 c, c++, oc 等语言的 **Language server** - [ccls](https://github.com/MaskRay/ccls/wiki/Build)

* 其它

    * 设置 **GNOME Terminal**. *字体*: `Inconsolata Medium 12`, *Cell spacing*: `1.15 x width`
