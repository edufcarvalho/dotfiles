# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# add bin and cargo files to path
export PATH='/bin:/usr/bin:/usr/local/bin:/sbin:/Users/eduardo.carvalho/.cargo/bin:$PATH'

# enable homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# editor and gpg
export EDITOR='nvim'
export VISUAL='nvim'

# asdf setup
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

autoload -Uz compinit && compinit
setopt rm_star_silent

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# enable shell plugins
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load < ~/.zsh_plugins.txt > /dev/null 2>&1

function mkcd {
	dir="$*";
	mkdir $dir && cd $dir
}

# ls aliases
alias ls="exa"
alias ll="ls -l"
alias lt="ls --tree"
alias la="ls -a"
alias lla="ls -la"
alias lta="lt -a"

# yay aliases
alias install="brew install"
alias update="brew update && brew upgrade"
alias remove="brew uninstall"

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
alias merge="git merge"

# misc aliases
alias \$=" "
alias clear_history="truncate -s 0 .zsh_history"
alias youtube-dl="yt-dlp"
alias rr="rm -rf"
alias cat="bat --theme=TwoDark"
alias grep="rg"

# configure histfiles
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTFILE="${HOME}/.zsh_history"
export SAVEHIST=10000000

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
