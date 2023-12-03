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

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
	git
	composer
	ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
	general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh
source /usr/share/fzf/key-bindings.bash

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

#--preview="ls -1F --group-directories {}" \
#--border \
code_nav() {
	local folder
	#folder=$(find ~ -type d 2>/dev/null | grep -Ev '/(\.git|node_modules)/' | fzf \
	#folder=$(find ~ -mindepth 1 -type d -not -path '*/\.git*' -not -path '*/node_modules*' | fzf \
	folder=$(find ~ -mindepth 1 -type d -not -path '*/\.git*' -not -path '*/node_modules*' -not -path '*/\.*' | fzf \
		--height=100% \
		--layout=reverse \
		--ansi \
		--preview="tree -C {}" \
		--preview-window=right:40% \
		--bind="ctrl-p:toggle-preview,ctrl-d:half-page-down")

	if [ -n "$folder" ]; then
		if [ -d "$folder" ]; then
			code --reuse-window "$folder" || return 1
		fi
	else
		echo "You didn't select a folder."
	fi
}

nav() {
	local folder
	#folder=$(find ~ -type d 2>/dev/null | grep -Ev '/(\.git|node_modules)/' | fzf \
	#--ansi \
	folder=$(find ~ -mindepth 1 -not -path '*/\.git*' -not -path '*/node_modules*' | fzf \
		--height=50% \
		--layout=reverse \
		--preview="eval \$(~/preview_script.sh {})" \
		--preview-window=right:50% \
		--bind="ctrl-p:toggle-preview,ctrl-d:half-page-down")

	if [ -n "$folder" ]; then
		echo "You are in: $folder"
		echo "$folder" | xclip -selection c

		if [ -d "$folder" ]; then
			cd "$folder" || return 1
		elif [ -f "$folder" ]; then
			nvim "$folder"
		fi
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

alias gaa="git add ."
alias gic="git commit -m"
alias gst="git status"

alias v="nvim"
alias ebash="v ~/.bashrc"
alias sbash="clear; source ~/.bashrc"

alias d="mkdir"
alias e="exit"
alias %="touch"
alias tree="tree -C -I 'node_modules'"
alias t="tree"

alias home="cd ~"
alias update="sudo pacman -Syu"
alias upgrade="sudo pamac upgrade"

alias dev="execute_script keyboard.sh"
alias audio="execute_script audio.sh"
alias mouse="execute_script mouse.sh"

alias log="cat /home/juancamr/.local/share/qtile/qtile.log"
alias windir="cd /run/media/juancamr/D224938F24937567/Users/51986/"
alias restart="qtile cmd-obj -o cmd -f restart"

alias msg="firefox --new-tab https://messenger.com"
alias code_in_path="code_nav; exit"
