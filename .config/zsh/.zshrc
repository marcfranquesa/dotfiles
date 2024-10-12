typeset -U path # declare $PATH as a unique array

# saner defaults
setopt autocd # auto cd into directory.
setopt nomatch # output error if file doesn't match
setopt interactive_comments # comments in interactive shells
unsetopt PROMPT_SP # disable preservation of trailing spaces in prompt
stty stop undef # disable ctrl-s to freeze terminal.
zle_highlight=('paste:none') # don't highlight paste

# history in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$XDG_CACHE_HOME/zsh/history"
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# load prompt and aliases
[ -f "$ZDOTDIR/prompt" ] && source "$ZDOTDIR/prompt"
[ -f "$XDG_CONFIG_HOME/shell/aliases" ] && source "$XDG_CONFIG_HOME/shell/aliases"

# basic auto/tab complete
fpath=($fpath "$XDG_CONFIG_HOME/zsh/completions") # custom completions
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

# key binds
bindkey '^R' history-incremental-search-backward
[ -x "$(command -v tmux-sessionizer)" ] && bindkey -s '^F' "tmux-sessionizer^M"

