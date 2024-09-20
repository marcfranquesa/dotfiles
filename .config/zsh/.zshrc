# saner defaults
setopt autocd # auto cd into directory.
setopt nomatch # output error if file doesn't match
setopt interactive_comments # comments in interactive shells
stty stop undef # disable ctrl-s to freeze terminal.
zle_highlight=('paste:none') # don't highlight paste

# history in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$XDG_CACHE_HOME/zsh/history"

# load prompt and functions
[ -f "$ZDOTDIR/prompt" ] && source "$ZDOTDIR/prompt"
[ -f "$ZDOTDIR/functions" ] && source "$ZDOTDIR/functions"

# basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zsh/compdump"
_comp_options+=(globdots) # include hidden files

# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# search
bindkey '^R' history-incremental-search-backward
