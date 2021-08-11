# Create by newuser for 5.8
echo -n -e "\033]0;$USER@$HOST\007"
source <(antibody init)
eval "$(starship init zsh)"
antibody bundle < ~/.plugins.txt
export GPG_TTY=$(tty)
export PYTHONSTARTUP=~/.pythonrc

mkcd () {
	mkdir -p -- "$1" &&
	cd -P -- "$1"
}

alias trim="sudo fstrim /"
alias reboot="systemctl reboot -i"
alias shutdown="shutdown -h now"
alias sed="sd"
alias rr="rm -r"
alias pacman="sudo pacman"
alias install="yay -S"
alias search="yay -Ss"
alias update="yay"
alias remove="yay -Rsn"
alias home="cd /home/eduardo"
alias swapoff="sudo swapoff -a"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias cat="bat --theme=OneHalfDark"
alias py="python"
alias grep="rg"
alias music="youtube-dl -x --audio-format mp3 "
alias copy="xclip -selection c"
alias rm="sudo rm"
alias clean_history="rm ~/.histfile && touch ~/.histfile"
alias fdisk="sudo fdisk"
alias clean_cache="yay -Scc"
alias prunning="yay -Qdt"
alias governor="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias max_performance="echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias myip="curl http://ipecho.net/plain; echo"
alias ls="exa"
alias clone="git clone"
alias status="git status"
alias add="git add"
alias commit="git commit"
alias amend="commit --amend"
alias fetch="git fetch"
alias force="git push --force"
alias push="git push"
alias pull="git pull"
alias checkout="git checkout"
alias branch="git branch"
alias la="ls -a"
alias ll="ls -l"
alias lla="ll -a"
alias lt="ls --tree"
alias lta="lt -a"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
