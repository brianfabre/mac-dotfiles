# zsh-autocomplete
#source ~/.zsh_plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#zstyle ':autocomplete:*' fzf-completion yes
#zstyle ':autocomplete:*' widget-style menu-select
#zstyle ':autocomplete:*' min-input 1

# history size
HISTSIZE=10000
export HISTCONTROL=ignoredups:erasedups

# zoxide
#eval "$(zoxide init zsh)"

# vim mode
# bindkey -v
# KEYTIMEOUT=20
# bindkey -M viins 'jk' vi-cmd-mode

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# fd - cd to selected directory
fd () {
  local dir
  dir=$(find ${1:-.} -path '*/Library*' -prune \
                  -o -path '*/Music' -prune \
                  -o -path '*/.git' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
                  # -o -path '*/venv' -prune \
                  # -o -path '*/Repos/*/*' -prune \
                  # -o -path '*/\.*' -prune \

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

# bindkey -s '^o' '^ulfcd\n'
alias lf="lfcd"


# source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# alias
alias nv='nvim'
alias pip='pip3'
alias python='python3'
alias lg='lazygit'
alias lz='NVIM_APPNAME=lazyvim nvim'
alias av='NVIM_APPNAME=astrovim nvim'
alias nc='NVIM_APPNAME=nvchad nvim'
# alias cd='z'
alias n='lf'
# alias ls='exa -l --icons -h --no-time'
alias rm='rm -i'
alias mv='mv -i'
alias ls='ls --color=auto'
alias neofetch='macchina'


# export
export EDITOR="nvim"
export VISUAL="nvim"
export LC_ALL=en_US.UTF-8
export PATH=/usr/local/bin:$PATH
# export FZF_DEFAULT_OPTS="--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
