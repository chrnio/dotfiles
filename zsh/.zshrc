# zinit
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light Aloxaf/fzf-tab

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# completion
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"

# fzf-tab — Tokyo Night
zstyle ':fzf-tab:*' fzf-flags \
    '--height=50%' \
    '--layout=reverse' \
    '--border=sharp' \
    '--border=rounded' \
    '--color=bg:#1a1b26,bg+:#292e42,fg:#c0caf5,fg+:#c0caf5'
    
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:down,ctrl-k:up'

# Tokyo Night purple / blue accents
zstyle ':fzf-tab:*' fzf-flags \
    '--height=50%' \
    '--layout=reverse' \
    '--border=sharp' \
    '--color=bg:#1a1b26,bg+:#292e42,fg:#a9b1d6,fg+:#c0caf5,hl:#bb9af7,hl+:#bb9af7,border:#bb9af7,pointer:#bb9af7,marker:#bb9af7,prompt:#bb9af7,info:#7aa2f7,spinner:#7aa2f7,header:#7aa2f7'

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# shell options
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt EXTENDED_GLOB GLOB_DOTS NULL_GLOB
setopt INTERACTIVE_COMMENTS NO_BEEP

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_VERIFY
setopt SHARE_HISTORY INC_APPEND_HISTORY

# environment
export EDITOR="nvim"
export VISUAL="$EDITOR"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

typeset -U path
path=("$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/go/bin" $path)
export PATH

# key bindings
bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A'    up-line-or-beginning-search
bindkey '^[[B'    down-line-or-beginning-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H'      backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey '^ '      autosuggest-accept

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height=50% --layout=reverse --border=rounded'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# prompt
PROMPT='%F{green}%n@%m%f %~$ '
