export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache/"

export HISTFILE="$HOME/.config/zsh/.zsh_history"
export PYTHON_HISTORY="$HOME/.config/python/python_history"
export LESSHISTFILE="$HOME/.config/lesshst"
export DOCKER_CONFIG="$HOME/.config/docker"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
export npm_config_cache="$HOME/.cache/npm"
export NODE_REPL_HISTORY="$HOME/.local/share/node/node_repl_history"

# Path to your Oh My Zsh installation.
export ZSH="$XDG_DATA_HOME/.oh-my-zsh"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PATH="$CARGO_HOME/bin:$PATH"

export EDITOR="code --wait"

export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_DEFAULT_OPUS_MODEL="z-ai/glm-5.2"
export ANTHROPIC_DEFAULT_SONNET_MODEL="minimax/minimax-m3[1m]"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek/deepseek-v4-flash"
export CLAUDE_CODE_SUBAGENT_MODEL="minimax/minimax-m3"

load_secrets() {
	export OPENROUTER_API_KEY="$(rbw get 'OPENROUTER_API_KEY')"
	export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_API_KEY"
}

unload_secrets() {
	unset OPENROUTER_API_KEY
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gh eza zoxide uv rust colored-man-pages colorize brew macos fzf-tab zsh-autosuggestions fast-syntax-highlighting)

# Required BEFORE sourcing OhMyZsh - https://github.com/zsh-users/zsh-completions#oh-my-zsh
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# FZF defaults (file-based, sourced by fzf from: ~/.config/fzf/config)
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!.git'"

# FZF_CTRL_R_OPTS — history search via Ctrl+R.
export FZF_CTRL_R_OPTS='--bind "ctrl-e:execute-silent(echo -n )+abort" --header "Ctrl+E to copy"'

# FZF_CTRL_T_OPTS — file picker via Ctrl+T.
export FZF_CTRL_T_OPTS='--preview "bat --style=plain --color=always {} --number 1000 | head -30" --height=100% --bind "alt-a:select-all,alt-u:deselect-all,ctrl-/:transform-query:strupr"'

# FZF_ALT_C_OPTS — directory picker via Alt+C (fzf-tab handles this too, but this is the fallback).
export FZF_ALT_C_OPTS='--preview "eza --color=always -a --tree --icons --level=2 {}"'

# Source fzf shell bindings (completions, key bindings, etc.).
source <(fzf --zsh)

# fnm: Fast Node Manager
command -v fnm | eval "$(fnm env)"
