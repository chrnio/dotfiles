# theme
THEME_NAME="tokyonight_night"
THEME_BG="#1a1b26"       THEME_BG_SEL="#283457"
THEME_FG="#c0caf5"       THEME_HL="#7dcfff"
THEME_PROMPT="#7aa2f7"   THEME_POINTER="#bb9af7"
THEME_MARKER="#9ece6a"   THEME_BORDER="#27a1b9"
THEME_HEADER="#e0af68"   THEME_INFO="#73daca"
THEME_SPINNER="#f7768e"  THEME_AUTOSUGGEST="fg=#565f89,italic"
THEME_POINTER="#7dcfff"

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light hlissner/zsh-autopair

zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light MichaelAquilina/zsh-you-should-use

# completion
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:warnings'     format '%F{203}  no matches%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/compcache"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=34=0'
zstyle ':completion:*:*:*:*:processes'   command "ps -u $USER -o pid,user,comm -w"

# fzf-tab, kept separate from FZF_DEFAULT_OPTS so the borders don't clash
zstyle ':fzf-tab:*' use-fzf-default-opts no
zstyle ':fzf-tab:*' fzf-flags \
    '--height=50%' \
    '--layout=reverse' \
    '--border=rounded' \
    '--padding=0,1' \
    '--prompt= ' \
    '--pointer=›' \
    '--marker=◆' \
    "--color=bg:$THEME_BG,bg+:$THEME_BG_SEL" \
    "--color=fg:$THEME_FG,fg+:$THEME_FG" \
    "--color=hl:$THEME_POINTER,hl+:$THEME_MARKER" \
    "--color=prompt:$THEME_POINTER" \
    "--color=pointer:$THEME_POINTER" \
    "--color=marker:$THEME_POINTER" \
    "--color=border:$THEME_POINTER" \
    "--color=header:$THEME_POINTER" \
    "--color=info:$THEME_INFO" \
    "--color=spinner:$THEME_SPINNER"

zstyle ':fzf-tab:complete:*' fzf-preview \
    'if [[ -d $realpath ]]; then ls -la --color=always $realpath 2>/dev/null; elif [[ -f $realpath ]]; then bat --color=always --line-range :60 $realpath 2>/dev/null; fi'
zstyle ':fzf-tab:complete:(cd|z|zi|zoxide):*' fzf-preview \
    'ls -la --color=always $realpath 2>/dev/null'
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
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview \
    'SYSTEMD_COLORS=1 systemctl status $word 2>/dev/null | bat --color=always -l ini'

# shell options
setopt AUTO_CD CDABLE_VARS AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt EXTENDED_GLOB GLOB_DOTS NULL_GLOB
setopt INTERACTIVE_COMMENTS NO_BEEP CORRECT

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_VERIFY
setopt SHARE_HISTORY INC_APPEND_HISTORY

# environment
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=Fusion
export QT_QUICK_CONTROLS_STYLE=Fusion

export EDITOR="nvim"
export VISUAL="neovide"
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
export PATH="$HOME/.config/emacs/bin:$PATH" # doom emacs

typeset -U path
path=("$HOME/.local/bin" "$HOME/go/bin" "$HOME/.cargo/bin" "$PNPM_HOME" /usr/local/bin $path)
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
bindkey '^[^M'    autosuggest-execute

# fzf
source <(fzf --zsh)

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS="
  --height=50% --layout=reverse --border=rounded
  --prompt='  ' --pointer='>' --marker='*'
  --color=bg:$THEME_BG,bg+:$THEME_BG_SEL
  --color=fg:$THEME_FG,fg+:$THEME_FG
  --color=hl:$THEME_HL,hl+:$THEME_HL
  --color=border:$THEME_BG_SEL,gutter:$THEME_BG
  --color=spinner:$THEME_SPINNER,info:$THEME_INFO
  --color=header:$THEME_INFO,prompt:$THEME_HEADER
  --color=pointer:$THEME_POINTER,marker:$THEME_MARKER
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-u:preview-page-up'
  --bind='ctrl-d:preview-page-down'
  --bind='ctrl-y:execute-silent(echo -n {} | wl-copy)+abort'
"

export FZF_CTRL_T_OPTS="--preview='bat --color=always --line-range :80 {}' --preview-window='right:55%:wrap'"
export FZF_ALT_C_OPTS="--preview='ls -la --color=always {}'"
export FZF_CTRL_R_OPTS="
  --preview='echo {}' --preview-window='down:3:hidden:wrap'
  --bind='ctrl-/:toggle-preview'
  --header='Ctrl-Y to copy  |  Ctrl-/ to preview'
"

eval "$(zoxide init zsh --cmd cd)"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="$THEME_AUTOSUGGEST"

# aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias ls='eza'
alias lsa='eza -lah'

alias lg='lazygit'
alias tmux='tmux -u'
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
alias torr='transmission-cli -w ~/Downloads/torrents -f'

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

alias zrc='nvim ~/.zshrc'
alias szrc='source ~/.zshrc'
alias ff='fastfetch'
alias hylua='nvim ~/.config/hypr/hyprland.lua'
alias hymod='nvim ~/.config/hypr/modules/'
alias swayconf='nvim ~/.config/sway/config'
alias kconf='nvim ~/.config/kitty/kitty.conf'
alias aconf='nvim ~/.config/alacritty/alacritty.toml'

eval "$(starship init zsh)"
