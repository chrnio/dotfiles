skip_global_compinit=1

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "%F{105}bootstrapping zinit...%f"
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# completions database — load early so other plugins can use it
zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

# fzf-tab — replaces the default completion menu with fzf
# must come before syntax-highlighting
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# autosuggestions
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# autopair — auto-close brackets, quotes, backticks
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# you-should-use — nudges you toward your own aliases
zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use

# fast-syntax-highlighting — must be sourced last among plugins
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

# only generate these if the command exists and zinit doesn't already have the snippet
function _zinit_snip_if() {
    local id="$1"; shift
    [[ ! -f "${ZINIT[SNIPPETS_DIR]}/$id" ]] && command -v "${1%% *}" &>/dev/null && "$@"
}



zstyle ':completion:*' menu no                 # hand off to fzf-tab
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{105}-- %d --%f'
zstyle ':completion:*:warnings'     format '%F{203}  no matches%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/compcache"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=34=0'
zstyle ':completion:*:*:*:*:processes'   command "ps -u $USER -o pid,user,comm -w"

# FZF-TAB (Tokyo Night Night)

zstyle ':fzf-tab:*' fzf-flags \
  '--height=40%' \
  '--layout=reverse' \
  '--color=bg:#1a1b26,bg+:#283457' \
  '--color=fg:#c0caf5,fg+:#c0caf5' \
  '--color=hl:#7dcfff,hl+:#7dcfff' \
  '--color=prompt:#7aa2f7' \
  '--color=pointer:#bb9af7' \
  '--color=marker:#9ece6a' \
  '--color=border:#27a1b9' \
  '--color=header:#e0af68' \
  '--color=info:#73daca' \
  '--color=spinner:#f7768e'

# previews per context
zstyle ':fzf-tab:complete:*' fzf-preview \
    'if [[ -d $realpath ]]; then eza --icons --tree --level=2 --color=always $realpath 2>/dev/null; elif [[ -f $realpath ]]; then bat --color=always --line-range :60 $realpath 2>/dev/null; fi'
zstyle ':fzf-tab:complete:(cd|z|zi|zoxide):*' fzf-preview \
    'eza --icons --tree --level=2 --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:(nvim|v|vi|vim|bat|cat):*' fzf-preview \
    'bat --color=always --line-range :60 $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview \
    'ps --pid=$word -o cmd --no-header -w 2>/dev/null'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
    'git diff $word 2>/dev/null | bat --color=always -l diff'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
    'git log --oneline --color=always $word 2>/dev/null'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
    'case "$group" in
        "modified file") git diff $word 2>/dev/null | bat -l diff --color=always ;;
        "recent commit object name") git show --color=always $word 2>/dev/null | bat --color=always ;;
        *) git log --oneline --color=always $word 2>/dev/null ;;
     esac'
zstyle ':fzf-tab:complete:paru:*' fzf-preview \
    'paru -Si $word 2>/dev/null | bat --color=always -l yaml'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview \
    'SYSTEMD_COLORS=1 systemctl status $word 2>/dev/null | bat --color=always -l ini'


# SHELL OPTIONS

setopt AUTO_CD CDABLE_VARS AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt EXTENDED_GLOB GLOB_DOTS NULL_GLOB
setopt INTERACTIVE_COMMENTS NO_BEEP
setopt CORRECT


# HISTORY

HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000

setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_VERIFY
setopt SHARE_HISTORY INC_APPEND_HISTORY


# ENVIRONMENT
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=Fusion
export QT_QUICK_CONTROLS_STYLE=Fusion

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat --paging=always"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export BAT_THEME="Catppuccin Mocha"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export GOMODCACHE="$HOME/.cache/go/mod"
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PNPM_HOME="$HOME/.local/share/pnpm"

typeset -U path
path=(
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.cargo/bin"
    "$PNPM_HOME"
    /usr/local/bin
    $path
)
export PATH


# KEY BINDINGS

bindkey -e                                        # emacs line editing

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A'    up-line-or-beginning-search     # up: prefix-aware history search
bindkey '^[[B'    down-line-or-beginning-search
bindkey '^[[1;5C' forward-word                    # Ctrl-Right
bindkey '^[[1;5D' backward-word                   # Ctrl-Left
bindkey '^H'      backward-kill-word              # Ctrl-Backspace
bindkey '^[[3;5~' kill-word                       # Ctrl-Delete
bindkey '^ '      autosuggest-accept              # Ctrl-Space: accept suggestion
bindkey '^[^M'    autosuggest-execute             # Alt-Enter: accept + run

# FZF

source <(fzf --zsh)    # Ctrl-T, Alt-C, Ctrl-R

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS="
  --height=50%
  --layout=reverse
  --border=rounded
  --prompt='  '
  --pointer='>'
  --marker='*'

  --color=bg:#16181a
  --color=bg+:#3c4048

  --color=fg:#ffffff
  --color=fg+:#ffffff

  --color=hl:#5ea1ff
  --color=hl+:#5ef1ff

  --color=border:#3c4048
  --color=gutter:#16181a

  --color=spinner:#bd5eff
  --color=info:#a0a8cd
  --color=header:#a0a8cd

  --color=prompt:#ffbd5e
  --color=pointer:#bd5eff
  --color=marker:#5eff6c

  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-u:preview-page-up'
  --bind='ctrl-d:preview-page-down'
  --bind='ctrl-y:execute-silent(echo -n {} | wl-copy)+abort'
"

export FZF_CTRL_T_OPTS="
  --preview='bat --color=always --line-range :80 {}'
  --preview-window='right:55%:wrap'
"

export FZF_ALT_C_OPTS="
  --preview='eza --icons --tree --level=2 --color=always {}'
"

export FZF_CTRL_R_OPTS="
  --preview='echo {}'
  --preview-window='down:3:hidden:wrap'
  --bind='ctrl-/:toggle-preview'
  --header='Ctrl-Y to copy  |  Ctrl-/ to preview'
"

# ZOXIDE

eval "$(zoxide init zsh --cmd cd)"


# AUTOSUGGESTIONS

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585b70,italic"   # Mocha surface2


# ALIASES — navigation

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'


alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index


# ALIASES — eza

alias ls='eza --icons=always --group-directories-first --color=always -l --git --git-repos'
alias lsa='eza --icons=always --group-directories-first --color=always -la --git --git-repos'

# ALIASES — editors / core tools

alias v='nvim'
# alias vi='nvim'
# alias vim='nvim'
# alias nv='nvim .'
alias lg='lazygit'
alias tmux='tmux -u'
# alias ta='tmux attach || tmux new-session -s main'
# alias tn='tmux new-session -s'

alias cat='bat --paging=never'
alias less='bat --paging=always'
alias grep='rg'
alias top='btop'
alias df='df -h'
alias du='du -sh'
alias free='free -h'
alias mkdir='mkdir -p'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias clip='wl-copy'
alias paste='wl-paste'
alias dl='aria2c -x16 -s16 -k1M'


# ALIASES — paru

alias psi='paru -S --needed'
alias psi!='paru -S --needed --noconfirm'
alias psr='paru -Rns'
alias psu='paru -Syu'
alias pss='paru -Ss'
alias pqi='paru -Qi'
alias pql='paru -Ql'
alias orphans='paru -Qtdq | paru -Rns -'


# ALIASES — git

alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch -vv'
alias gco='git checkout'
alias gsw='git switch'
alias gst='git stash'
alias gstp='git stash pop'
alias gcp='git cherry-pick'
alias gbl='git blame -w'


# ALIASES — python / uv

alias py='python'
alias py3='python3'
alias venv='uv venv'
alias uvr='uv run'
alias uva='source .venv/bin/activate'
alias uvd='deactivate'
alias pipi='uv pip install'
alias pipu='uv pip install --upgrade'
alias pipl='uv pip list'


# ALIASES — node / pnpm

alias ni='pnpm install'
alias na='pnpm add'
alias nr='pnpm run'
alias nx='pnpm exec'
alias nrd='pnpm run dev'
alias nrb='pnpm run build'
alias nrt='pnpm run test'
alias nrl='pnpm run lint'
alias nrp='pnpm run preview'


# ALIASES — rust

alias cb='cargo build'
alias cbr='cargo build --release'
alias cr='cargo run'
alias crr='cargo run --release'
alias ct='cargo test'
alias cc='cargo check'
alias cf='cargo fmt'
alias ccl='cargo clippy -- -D warnings'
alias cad='cargo add'


# ALIASES — go
alias gor='go run .'
alias gob='go build .'
alias got='go test ./...'
alias gom='go mod tidy'


# ALIASES — config
alias zrc='nvim ~/.zshrc'
alias ff='fastfetch'
alias hylua='nvim ~/.config/hypr/hyprland.lua'
alias hymod='nvim ~/.config/hypr/modules/'
alias swayconf='nvim ~/.config/sway/config'
alias kconf='nvim ~/.config/kitty/kitty.conf'
alias aconf='nvim ~/.config/alacritty/alacritty.toml'
alias zelconf='nvim ~/.config/zellij/config.kdl'
alias fdfont='fc-list | grep'
alias szrc='source ~/.zshrc'
alias nrc='nvim ~/.config/nvim/'
alias src='nvim ~/.config/starship.toml'
alias bt='bluetui'
alias vclr='v ~/.config/nvim/lua/plugins/theme.lua'

alias torr='transmission-cli -w ~/Downloads/torrents -f'

# FUNCTIONS
# yazi — cd on exit (official wrapper)
function y() {
    local tmp cwd
    tmp="$(mktemp -t yazi-cwd.XXXXXX)"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# fzf fuzzy cd into any dir
function fcd() {
    local dir
    dir=$(fd --type d --hidden --follow --exclude .git . "${1:-$HOME}" | \
          fzf --preview 'eza --icons --tree --level=2 --color=always {}') \
    && cd "$dir"
}

# fzf pick files, open in nvim
function fv() {
    local files
    files=$(fzf --multi \
        --preview 'bat --color=always --line-range :80 {}' \
        --preview-window 'right:55%:wrap') \
    && nvim $files
}

# fzf + rg live search, open at matching line in nvim
function frg() {
    local result file line
    result=$(rg --color=always --line-number --no-heading --smart-case "${*:-}" | \
             fzf --ansi --delimiter ':' \
                 --preview 'bat --color=always {1} --highlight-line {2}' \
                 --preview-window 'right:55%,+{2}+3/3,wrap')
    [[ -z "$result" ]] && return
    file=$(echo "$result" | cut -d: -f1)
    line=$(echo "$result" | cut -d: -f2)
    nvim "+$line" "$file"
}

# fzf interactive git branch checkout
function gfco() {
    local branch
    branch=$(git branch -a --color=always | grep -v HEAD | \
             fzf --ansi \
                 --preview 'git log --oneline --color=always $(echo {} | sed "s/remotes\/origin\///")' | \
             sed 's/remotes\/origin\///' | xargs)
    [[ -n "$branch" ]] && git switch "$branch"
}

# fzf process kill
function fkill() {
    local pid
    pid=$(ps -u "$USER" -o pid,ppid,%cpu,%mem,comm --no-header | \
          fzf --multi --header='PID  PPID  %CPU  %MEM  CMD' | awk '{print $1}')
    [[ -n "$pid" ]] && kill -9 $pid
}

# tmux fzf session picker; Ctrl-N creates new
function ts() {
    local session
    session=$(tmux list-sessions -F '#{session_name}' 2>/dev/null | \
              fzf --prompt='session  ' \
                  --header='Ctrl-N: new session' \
                  --bind "ctrl-n:execute(tmux new-session -ds {q} 2>/dev/null)+reload(tmux list-sessions -F '#{session_name}')") \
    && (tmux switch-client -t "$session" 2>/dev/null || tmux attach -t "$session")
}

# mkdir and cd
function mkcd() { mkdir -p "$1" && cd "$1"; }

# extract any archive
function ex() {
    case "$1" in
        *.tar.bz2|*.tbz2)  tar xjf "$1"          ;;
        *.tar.gz|*.tgz)    tar xzf "$1"          ;;
        *.tar.xz|*.txz)    tar xJf "$1"          ;;
        *.tar.zst)          tar --zstd -xf "$1"  ;;
        *.tar)              tar xf "$1"           ;;
        *.bz2)              bunzip2 "$1"          ;;
        *.gz)               gunzip "$1"           ;;
        *.zip)              unzip "$1"            ;;
        *.7z)               7z x "$1"             ;;
        *.rar)              unrar x "$1"          ;;
        *.zst)              zstd -d "$1"          ;;
        *)                  echo "unknown: $1"    ;;
    esac
}

# quick markdown note, defaults to today
function note() {
    local dir="$HOME/notes"
    mkdir -p "$dir"
    nvim "$dir/${1:-$(date +%Y-%m-%d)}.md"
}

# serve cwd over HTTP
function serve() { python3 -m http.server "${1:-8000}"; }

# top 10 most-used commands
function topcmds() {
    history 1 | awk '{print $2}' | sort | uniq -c | sort -rn | head 10
}

command -v starship &>/dev/null && eval "$(starship init zsh)"
