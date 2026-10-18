### zinit bootstrap
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

### zsh-vi-mode plugin loaded first
ZVM_INIT_MODE=sourcing
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

### Plugins (turbo mode), order matters here btw
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light Aloxaf/fzf-tab

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light hlissner/zsh-autopair

zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# Must load after syntax highlighting.
zinit ice wait lucid atload'
    bindkey "^[[A" history-substring-search-up
    bindkey "^[[B" history-substring-search-down
    bindkey -M vicmd "k" history-substring-search-up
    bindkey -M vicmd "j" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search

### Environment
export EDITOR="nvim"
export VISUAL="$EDITOR"
export MANPAGER='nvim +Man!'
export BAT_THEME="TwoDark"   # Atom One Dark

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

typeset -U path
path=("$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/go/bin" "$HOME/.opencode/bin" $path)
export PATH

if [[ -z "$LS_COLORS" ]] && (( $+commands[dircolors] )); then
    eval "$(dircolors -b)"
fi

autoload -Uz colors && colors

### Completion
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' \
    'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:messages' format '%F{blue}%d%f'
zstyle ':completion:*:warnings' format '%F{red}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/compcache"
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

### fzf-tab
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' prefix ''

zstyle ':fzf-tab:*' group-colors \
    $'\033[38;2;97;175;239m' \
    $'\033[38;2;198;120;221m' \
    $'\033[38;2;86;182;194m' \
    $'\033[38;2;229;192;123m' \
    $'\033[38;2;224;108;117m' \
    $'\033[38;2;152;195;121m'
zstyle ':fzf-tab:*' switch-group '<' '>'

# Previews: directories via eza, files via bat.
zstyle ':fzf-tab:complete:(cd|z|zi|pushd|eza|ls):*' \
    fzf-preview 'eza -1 --color=always --group-directories-first $realpath'
zstyle ':fzf-tab:complete:(cat|bat|nvim|vim|less):*' \
    fzf-preview '[[ -d $realpath ]] && eza -1 --color=always $realpath || bat --color=always --style=numbers --line-range=:200 $realpath'
zstyle ':fzf-tab:complete:kill:argument-rest' \
    fzf-preview '[[ $group == "[process ID]" ]] && ps -o pid,user,%cpu,%mem,cmd -p $word'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $word'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --oneline --color=always $word'

### Keybindings

# bindkey calls below apply to insert mode.
autoload -Uz edit-command-line
zle -N edit-command-line

# Up/Down are bound by zsh-history-substring-search (see plugins).
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey '^ ' autosuggest-accept
bindkey '^X^E' edit-command-line

# Make word motions/kills stop at / . - = so Ctrl+Backspace deletes one path segment.
WORDCHARS='*?_[]~&;!#$%^(){}<>'

### FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
# One Dark palette, green borders to match zellij.
export FZF_DEFAULT_OPTS='
--height=50%
--layout=reverse
--border=rounded
--info=inline-right
--prompt="> "
--pointer=">"
--marker="+"
--scrollbar="|"
--color=fg:#abb2bf,bg:-1,hl:#98c379
--color=fg+:#dcdfe4,bg+:#2c313a,hl+:#98c379:bold
--color=border:#98c379,label:#98c379,preview-border:#98c379
--color=prompt:#61afef,query:#dcdfe4,pointer:#98c379,marker:#e5c07b
--color=info:#5c6370,spinner:#c678dd,header:#61afef
--color=gutter:-1,scrollbar:#3e4451,separator:#3e4451
--bind=ctrl-j:down,ctrl-k:up
'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:300 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {}'"

(( $+commands[fzf] )) && source <(fzf --zsh)

### atuin: Ctrl+R, loaded after fzf, replaces its functionality here...Up arrow for nav
(( $+commands[atuin] )) && eval "$(atuin init zsh --disable-up-arrow)"

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bold,fg=magenta'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bold,fg=red'

YSU_MESSAGE_POSITION='after'

### Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

### History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

### Shell options
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt NULL_GLOB
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt NO_CLOBBER             # use >| to overwrite on purpose
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

### Aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

### Prompt
# PROMPT='%B%F{green}%n@%m%f%b:%B%F{green}%~%f%b$ '
(( $+commands[starship] )) && eval "$(starship init zsh)"

### direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

### zoxide
(( $+commands[zoxide] )) && eval "$(zoxide init zsh --cmd cd)"
