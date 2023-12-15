# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/juancamr/.oh-my-bash'
export PATH="$PATH:$HOME/bin"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="purity"

OMB_USE_SUDO=true

completions=(
	git
	composer
	ssh
)

aliases=(
	general
)

plugins=(
	git
	bashmarks
)

source "$OSH"/oh-my-bash.sh
source /usr/share/fzf/key-bindings.bash

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# code_nav() {
# 	local folder
# 	folder=$(find ~/Documents -mindepth 1 -type d -not -path '*/\.*' -not -path '*/node_modules*' -not -path '*/\.*' | fzf )
#
# 	if [ -n "$folder" ]; then
# 		if [ -d "$folder" ]; then
# 			code --reuse-window "$folder" || return 1
# 		fi
# 	else
# 		echo "You didn't select a folder."
# 	fi
# }

nav() {
    local folder
    folder=$(find ~ -maxdepth 4 -type d -not -path '*/node_modules*' -not -path '*/\.*' | fzf \
		--height=50% \
		--layout=reverse )

    if [ -n "$folder" ]; then
        cd "$folder" || return 1

        file_count=$(find "$folder" -maxdepth 1 -type f | wc -l)
        dir_count=$(find "$folder" -maxdepth 1 -type d | wc -l)
        dir_count=$((dir_count - 1))

        echo "--------------------------------"
        echo "$dir_count folder(s), $file_count file(s) "
        echo "--------------------------------"

    else
        echo "You didn't select a folder."
    fi
}

copy() {
	local command="$@"
	echo -n "$command" | xclip -selection clipboard
	echo "Copied!"
}

execute_script() {
	local script_path="$1"
	sh "$HOME/.config/qtile/assets/scripts/$script_path"
}

# git alias
alias gaa="git add ."
alias gic="git commit -m"
alias gst="git status"
alias glog="git log --oneline --decorate --graph --all"
alias g="git"

alias py="python"
alias vim="nvim"
alias ebash="nvim ~/.bashrc"
alias sbash="clear; source ~/.bashrc"

alias d="mkdir"
alias tree="tree -C -I 'node_modules'"

alias update="sudo pacman -Syu"
alias upgrade="sudo pamac upgrade"

# execute scripts
alias devorak="execute_script keyboard.sh"
alias backspace="execute_script typing_training.sh"
alias audio="execute_script audio.sh"
alias mouse="execute_script mouse.sh"

# logger shortcuts
alias log="cat /home/juancamr/.local/share/qtile/qtile.log"
alias restart="qtile cmd-obj -o cmd -f restart"

alias code_in_path="code_nav; exit"
alias codeh="code --reuse-window"
alias token="xclip -selection clipboard < $HOME/Documents/env/token_git.txt"

alias restart_font="fc-cache -f -v"
alias end="pkill"
alias evim="cd ~/.config/nvim; nvim ."
alias v="nvim"

alias windir="cd /mnt/windir/Users/51986"
alias usbpath="cd /mnt/usb"
alias config="cd ~/.config"

alias mountc="sudo mount /dev/sda3 /mnt/windir"
alias umountc="sudo umount /mnt/windir"
