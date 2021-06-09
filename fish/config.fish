set fish_greeting

# source ~/.config/fish/alias.fish
# source ~/.config/fish/path.fish
# source ~/.config/fish/func.fish

# ---path.fish 环境变量
# set PATH $PATH /opt/homebrew/bin
set -U fish_user_paths $fish_user_paths /opt/homebrew/bin
set -U fish_user_paths $fish_user_paths /usr/local/bin
set PROJECT_DIR ~/prj
set -x HOMEBREW_NO_AUTO_UPDATE true
# 也可以fish_add_path /usr/local/bin

# set co2 '/Applications/Visual\ Studio\ Code.app/contents/Resources/app/bin/code' # 设置变量，替代 name=czl

# ---alia.fish
# 通用
alias l='ls -la'
alias f open
alias cdp 'cd $PROJECT_DIR'
alias c "/Applications/Visual\ Studio\ Code.app/contents/Resources/app/bin/code"

# git # 展开更好，用于记住命令、便于分享
abbr -a ga  git add
abbr -a gs  git status -sb
abbr -a gc  git commit
abbr -a gcm git commit -m
abbr -a gca git commit --amend
abbr -a gcl git clone
abbr -a gco git checkout
abbr -a gp  git push
abbr -a gpl git pull
abbr -a gl  git l
abbr -a gd  git diff
abbr -a gds git diff --staged
abbr -a gr  git rebase -i HEAD~15
abbr -a gf  git fetch
abbr -a gfc git findcommit
abbr -a gfm git findmessage
abbr -a glg "git log --graph --pretty=format:'%Cred%h%Crest -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# npm
abbr --add ns npm start
abbr --add ni npm install
abbr --add nb npm run build
abbr --add nig npm install -g
abbr --add nt npm test


# -- func.fish
# 话费时间
function show_command_duration --on-event fish_postexec
    if test $CMD_DURATION -gt 0
        set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
        echo "🚀 $duration"
        set CMD_DURATION 0
    end
end
# 快速提交代码，使用方法：
# 可以添加一个参数作为 git commit 的注释
# 如果不添加参数会将当前时间作为 git commit 的注释
function push
	echo "+++++git pull ++++++++++++++"
	git pull
	echo "+++++git add .++++++++++++++"
	git add .
	echo "+++++git commit ++++++++++++"
	if test -d $argv
		git commit -m (date +%Y-%m-%d_%H:%M:%S)
	else
		git commit -m $argv
	end
	echo "+++++git push +++++++++++++++"
	git push
	echo "++++++Finish+++++++++++++++++"
end

# starship
starship init fish | source


