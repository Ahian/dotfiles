# p10k 的 Instant Prompt 。在其他插件的加载过程中提供一个精简的 prompt 供使用，相当于后台加载。
# https://github.com/romkatv/powerlevel10k#instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 自动安装zinit、启动{{{
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  mkdir ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# }}}

# 主题不是性能瓶颈，相差0.06s
: ${THEME:=p10k}
case $THEME in
  pure)
    PROMPT=$'\n%F{cyan}❯ %f'
    RPROMPT=""
    zstyle ':prompt:pure:prompt:success' color cyan
    zinit ice lucid wait"!0" pick="async.zsh" src="pure.zsh" atload="prompt_pure_precmd"
    zinit light sindresorhus/pure
    ;;
  p10k)
    # 加载 p10k 主题; depth:只克隆最后一次提交
    zinit ice depth=1; zinit light romkatv/powerlevel10k
    # 配置`p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    ;;
esac

# Zinit {{{

# 批量安装
zinit  wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  atload"zicompinit; zicdreplay" blockf \
    zsh-users/zsh-completions \
  fzf \
  skywind3000/z.lua \
  djui/alias-tips \


zinit light zinit-zsh/z-a-meta-plugins
zinit for annexes  zdharma fuzzy 

# console-tools
# ext-git
# zsh-users+fast

# 等于安装了：
# annexes	zinit-zsh/z-a-unscope, zinit-zsh/z-a-as-monitor, zinit-zsh/z-a-patch-dl, zinit-zsh/z-a-rust, zinit-zsh/z-a-submods, zinit-zsh/z-a-bin-gem-node
# zsh-users+fast: zdharma/fast-syntax-highlighting, zsh-users/zsh-autosuggestions, zsh-users/zsh-completions
# zdharma	zdharma/fast-syntax-highlighting, zdharma/history-search-multi-word, zdharma/zsh-diff-so-fancy
# console-tools	dircolors-material (package), sharkdp (meta-plugin), ogham/exa, BurntSushi/ripgrep, jonas/tig
# sharkdp	sharkdp/fd, sharkdp/bat, sharkdp/hexyl, sharkdp/hyperfine, sharkdp/vivid
# fuzzy	fzf (package), fzy (package), lotabout/skim, peco/peco
# fuzzy-src	fzf-go, fzy (package), skim-cargo, peco-go
# ext-git	Fakerr/git-recall, paulirish/git-open, paulirish/git-recent, davidosomething/git-my, arzzen/git-quick-stats, iwata/git-now, tj/git-extras, wfxr/forgit



# z.lua, https://v2ex.com/t/532304
#   djui/alias-tips \
zinit light-mode wait"1" lucid for \
  Aloxaf/fzf-tab \
  Aloxaf/gencomp \
  hchbaw/zce.zsh \
  MichaelAquilina/zsh-you-should-use \
  voronkovich/gitignore.plugin.zsh \
  as="program" atclone="rm -f ^(rgg|agv)" \
    lilydjwg/search-and-view \
  atclone="dircolors -b LS_COLORS > c.zsh" atpull='%atclone' pick='c.zsh' \
    trapd00r/LS_COLORS \
  atload"alias zi='zinit'" \
    ajeetdsouza/zoxide \
  as"command" from"gh-r" bpick"$PICK" mv"fd* -> fd" pick"fd/fd" \
    sharkdp/fd \
  as"program" from"gh-r" mv"exa* -> exa" pick"exa/exa" lucid atload"alias ls='exa --icons'" \
    ogham/exa \
  as"program" pick"bin/git-dsf" \
    zdharma/zsh-diff-so-fancy \
# agkozak/zsh-z \

# zinit ice wait="1" lucid
# zinit light matthieusb/zsh-sdkman


# OMZ
# sudo插件，两次esc 插入sudo

# zplugin ice svn multisrc"*.zsh" as"null"
# zplugin snippet  OMZ::lib

zinit wait lucid for \
  OMZ::lib/git.zsh \
  OMZ::lib/completion.zsh \
  OMZ::lib/history.zsh \
  OMZ::lib/clipboard.zsh \
  OMZ::lib/key-bindings.zsh \
  OMZ::lib/theme-and-appearance.zsh \
  OMZ::plugins/fzf/fzf.plugin.zsh \
  OMZ::plugins/git/git.plugin.zsh \
  OMZ::plugins/git-flow/git-flow.plugin.zsh \
  OMZ::plugins/sudo/sudo.plugin.zsh \
  OMZ::plugins/systemd/systemd.plugin.zsh \
  blockf \
    OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
    OMZ::plugins/command-not-found/command-not-found.plugin.zsh \
  as="completion" \
    OMZ::plugins/fd/_fd \

#  OMZ::plugins/common-aliases/common-aliases.plugin.zsh \

# Gitignore plugin – commands gii and gi


zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false

zstyle ":completion:*:git-checkout:*" sort false

# fzf配置 {
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# }

# }}}

# 自动更新path中可执行程序
zstyle ':completion:*' rehash true

# sbin 是z-a-bin-gem-node 附件添加的一个ice，它在不改变$PATH 的情况下将命令提供给命令行
# zinit as"null" wait"2" lucid from"gh-r" for \
#     mv"exa* -> exa" sbin       ogham/exa \
#     mv"fd* -> fd" sbin"fd/fd"  @sharkdp/fd \
#     sbin"fzf"  junegunn/fzf-bin


# zinit times

# is-snippet 加载本地snippet
# zinit is-snippet for \
#   if'[[ -r $HOME/.alias.sh ]]'     $HOME/.alias.sh \
#   if'[[ -r $HOME/.zsh_local ]]'     $HOME/.zsh_local \
#   if'[[ -r $HOME/.zsh_functions ]]' $HOME/.zsh_functions \
  # if'[[ -r $HOME/.vim.sh ]]'     $HOME/.vim.zsh \
  # if'[[ -r $HOME/.dev.sh ]]'     $HOME/.dev.zsh \

# cht补全 {{

zinit ice mv=":cht.sh -> cht.sh" atclone="chmod +x cht.sh" as="program"
zinit snippet https://cht.sh/:cht.sh

zinit ice mv=":zsh -> _cht" as="completion"
zinit snippet https://cheat.sh/:zsh

# }}


[[ -r ~/.config/.env.sh ]] && source ~/.config/.env.sh
[[ -r ~/.config/.alias.sh ]] && source ~/.config/.alias.sh
[[ -r ~/.config/.fun.sh ]] && source ~/.config/.fun.sh
# [[ -r ~/.config/.alternative.sh     ]] && source ~/.config/.alternative.sh
# [[ -r $HOME/.zsh_local     ]] && zinit snippet $HOME/.zsh_local
# [[ -r $HOME/.zsh_functions ]] && zinit snippet $HOME/.zsh_functions
[[ -r ~/.fzf.zsh ]] && source ~/.fzf.zsh


# 执行zsh-com­ple­tions 自动补全
# autoload 这是个fpath函数。-U 表示将函数  标记为自动加载并抑制别名扩展。 -z 表示使用 zsh（而不是 ksh）样式
# 只在末尾调用一次
# autoload -Uz compinit && compinit
# zinit cdreplay -q # <- execute compdefs provided by rest of plugins
# zinit cdlist # look at gathered compdefs

# 每天只一次compinit
# autoload -Uz compinit
# if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
#   compinit
# else
#   compinit -C
# fi


