打开 vim，输入`:echo $VIMRUNTIME` 

./runtime/syntax/

然后修改 `markdown.vim` 

参考教程 [Creating your own syntax files](https://vim.fandom.com/wiki/Creating_your_own_syntax_files) 

现在已经把 markdown.vim 和 gruvbox.vim 放在 .dotfile 里

分别软连接到 

/usr/local/Cellar/neovim/0.6.1/share/nvim/runtime/syntax # macos

/squashfs-root/usr/share/nvim/runtime/syntax             # ubuntu

~/.config/nvim/plugged/gruvbox/colors                    # gruvbox 配色文件
