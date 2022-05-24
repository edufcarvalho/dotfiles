export GPG_TTY=$(tty)
export EDITOR='nvim'
export VISUAL='nvim'

autoload -Uz compinit 
setopt rm_star_silent

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

eval "$(starship init zsh)"
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

function mkcd {
	dir="$*";
	mkdir $dir && cd $dir
}

function xinput_manager {
	xinput --list --short
	echo -n "Which device you want to show props? "
	read device
	xinput list-props $device
	echo -n "Which value id you want to change? "
	read id
	echo -n "To what? "
	read value
	xinput set-prop $device $id $value
}

# ls aliases
alias ls="exa"
alias ll="ls -l"
alias lt="ls --tree"
alias la="ls -a"
alias lla="ls -la"
alias lta="lt -a"

# yay aliases
alias install="yay -S"
alias update="yay -Syuu"
alias remove="yay -Rsc"

# git aliases
alias commit="git commit -S"
alias clone="git clone"
alias push="git push"
alias pull="git pull"
alias fetch="git fetch"
alias branch="git branch"
alias status="git status"
alias add="git add"
alias init="git init"
alias amend="commit --amend"
alias force="push --force"
alias checkout="git checkout"

# misc aliases
alias \$=" "
alias clear_history="truncate -s 0 .zsh_history"
alias youtube-dl="yt-dlp"
alias rr="rm -rf"
alias cat="bat --theme=TwoDark"
alias grep="rg"
alias unlock="sudo rm /var/lib/pacman/db.lck"

# configure histfiles
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTFILE="${HOME}/.zsh_history"
export SAVEHIST=10000000

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
