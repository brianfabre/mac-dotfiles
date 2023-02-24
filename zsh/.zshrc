# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# zsh-autocomplete
source ~/.zsh_plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 1
# zstyle ':autocomplete:history-incremental-search-*:*' list-lines 5

# history size
HISTSIZE=10000
export HISTCONTROL=ignoredups:erasedups

# zoxide
eval "$(zoxide init zsh)"


# auto ls when cd
# function cd {
#     if [ -z "$1" ]; then
#         builtin cd
#     else
#         builtin cd "$1"
#     fi
#     if [ $? -eq 0 ]; then
#         ls
#     fi
# }

# vim mode
# bindkey -v
# KEYTIMEOUT=20
# bindkey -M viins 'jk' vi-cmd-mode

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# lf cd function
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^o' '^ulfcd\n'


# source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# alias
alias nv='nvim'
alias pip='pip3'
alias python='python3'
alias lg='lazygit'
alias cd='z'
alias n='lf'
# alias n='lfcd'
# alias ls='exa -l --icons -h --no-time'
alias rm='rm -i'
alias mv='mv -i'
alias ls='ls --color=auto'


# export
export EDITOR="nvim"
export VISUAL="nvim"
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export MACASAHI=/Volumes/MacAsahi/
# export FZF_DEFAULT_OPTS="--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"


source ~/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

