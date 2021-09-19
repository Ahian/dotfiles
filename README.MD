yadm
```sh
brew install yadm

yadm clone git@github.com:Ahian/dotfiles.git
yadm status

yadm init
yadm add <important file>
yadm commit


yadm remote add origin git@github.com:Ahian/dotfiles.git
yadm push -u origin master
```

`~/.config/<software name>/<config file>`
`~/.config/nvim/init.vim`

tmux指定使用.config 下的配置文件（有其他好的方式吗）
`alias tmux="tmux -f ~/.config/tmux/tmux.conf"`
