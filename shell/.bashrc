### XDG directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

### Editor
export EDITOR="nvim"
export VISUAL="$EDITOR"
export MANPAGER='nvim +Man!'

### PATH
for dir in "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/go/bin" "$HOME/.opencode/bin"; do
    case ":$PATH:" in
        *":$dir:"*) ;;
        *) PATH="$dir:$PATH" ;;
    esac
done
export PATH

### History
HISTFILE="$HOME/.bash_history"
HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s cmdhist
shopt -s checkwinsize

### Interactive behavior
shopt -s autocd
shopt -s cdspell
shopt -s dirspell 2>/dev/null || true
set -o noclobber

# Ctrl+Left/Right move by word; Ctrl+Backspace deletes the previous word.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
bind '"\C-H": backward-kill-word'
bind '"\e[3;5~": kill-word'

### FZF
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

export FZF_DEFAULT_OPTS='
--height=50%
--layout=reverse
--border=rounded
--color=bg:-1,bg+:-1
--color=fg:-1,fg+:-1
--color=hl:magenta,hl+:magenta
--color=pointer:magenta,marker:magenta
--color=prompt:magenta
--color=info:blue,spinner:blue,header:blue
'

if command -v fzf >/dev/null 2>&1; then
    if fzf --bash >/dev/null 2>&1; then
        eval "$(fzf --bash)"
    elif [[ -r /usr/share/fzf/key-bindings.bash ]]; then
        source /usr/share/fzf/key-bindings.bash
        [[ -r /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash
    fi
fi

### Aliases
[[ -r "$HOME/.aliases" ]] && source "$HOME/.aliases"

### zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

### Prompt
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;32m\]\w\[\e[0m\]\$ '

### Bash completion
if ! shopt -oq posix; then
    if [[ -r /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    elif [[ -r /etc/bash_completion ]]; then
        source /etc/bash_completion
    fi
fi

### Bash functions
# Go to git repo's root
croot() {
    cd "$(git rev-parse --show-toplevel 2>/dev/null)" || return
}

### SDKMAN
export SDKMAN_DIR="${SDKMAN_DIR:-$HOME/.sdkman}"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
