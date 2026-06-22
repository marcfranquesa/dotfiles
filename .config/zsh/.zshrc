# Set up zsh directories.
mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

HISTFILE="$XDG_STATE_HOME/zsh/history"

typeset -U path

# Configure shell options.
setopt autocd
setopt nomatch
setopt interactive_comments
unsetopt PROMPT_SP
[[ -t 0 ]] && stty stop undef
zle_highlight=('paste:none')

# Configure history.
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# Load local config.
[ -f "$ZDOTDIR/prompt" ] && source "$ZDOTDIR/prompt"
[ -f "$XDG_CONFIG_HOME/shell/aliases" ] && source "$XDG_CONFIG_HOME/shell/aliases"
[ -f "$XDG_CONFIG_HOME/shell/functions" ] && source "$XDG_CONFIG_HOME/shell/functions"

# Configure completion.
fpath=($fpath "$XDG_CONFIG_HOME/zsh/completions")
autoload -U compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

# Configure vi mode and cursor.
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

typeset -U precmd_functions
function _set_cursor() { printf '\e[%s q' "$1" }
function _set_block_cursor() { _set_cursor 2 }
function _set_beam_cursor() { _set_cursor 5 }

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        _set_block_cursor
    else
        _set_beam_cursor
    fi
}
zle -N zle-keymap-select
precmd_functions+=(_set_beam_cursor)
zle-line-init() { zle -K viins; _set_beam_cursor }
zle -N zle-line-init

# Configure key bindings.
bindkey '^R' history-incremental-search-backward
command -v tmux-sessionizer > /dev/null && bindkey -s '^F' "tmux-sessionizer^M"

# Load external completions.
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
