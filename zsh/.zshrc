# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export MACASAHI=/Volumes/MacAsahi/

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

# # Add colors to Terminal
# export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad

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

# export
export EDITOR="nvim"
export VISUAL="nvim"
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# export FZF_DEFAULT_OPTS="--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"


source ~/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# lf_icons {{{
export LF_ICONS="\
ln=:\
or=:\
tw=t:\
ow=:\
st=t:\
di=:\
pi=p:\
so=s:\
bd=b:\
cd=c:\
su=u:\
sg=g:\
ex=:\
fi=:\
*.styl=:\
*.sass=:\
*.scss=:\
*.htm=:\
*.html=:\
*.slim=:\
*.haml=:\
*.ejs=:\
*.css=:\
*.less=:\
*.md=:\
*.mdx=:\
*.markdown=:\
*.rmd=:\
*.json=:\
*.webmanifest=:\
*.js=:\
*.mjs=:\
*.jsx=:\
*.rb=:\
*.gemspec=:\
*.rake=:\
*.php=:\
*.py=:\
*.pyc=:\
*.pyo=:\
*.pyd=:\
*.coffee=:\
*.mustache=:\
*.hbs=:\
*.conf=:\
*.ini=:\
*.yml=:\
*.yaml=:\
*.toml=:\
*.bat=:\
*.mk=:\
*.jpg=:\
*.jpeg=:\
*.bmp=:\
*.png=:\
*.webp=:\
*.gif=:\
*.ico=:\
*.twig=:\
*.cpp=:\
*.c++=:\
*.cxx=:\
*.cc=:\
*.cp=:\
*.c=:\
*.cs=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hxx=:\
*.hs=:\
*.lhs=:\
*.nix=:\
*.lua=:\
*.java=:\
*.sh=:\
*.fish=:\
*.bash=:\
*.zsh=:\
*.ksh=:\
*.csh=:\
*.awk=:\
*.ps1=:\
*.ml=λ:\
*.mli=λ:\
*.diff=:\
*.db=:\
*.sql=:\
*.dump=:\
*.clj=:\
*.cljc=:\
*.cljs=:\
*.edn=:\
*.scala=:\
*.go=:\
*.dart=:\
*.xul=:\
*.sln=:\
*.suo=:\
*.pl=:\
*.pm=:\
*.t=:\
*.rss=:\
'*.f#'=:\
*.fsscript=:\
*.fsx=:\
*.fs=:\
*.fsi=:\
*.rs=:\
*.rlib=:\
*.d=:\
*.erl=:\
*.hrl=:\
*.ex=:\
*.exs=:\
*.eex=:\
*.leex=:\
*.heex=:\
*.vim=:\
*.ai=:\
*.psd=:\
*.psb=:\
*.ts=:\
*.tsx=:\
*.jl=:\
*.pp=:\
*.vue=﵂:\
*.elm=:\
*.swift=:\
*.xcplayground=:\
*.tex=ﭨ:\
*.r=ﳒ:\
*.rproj=鉶:\
*.sol=ﲹ:\
*.pem=:\
*gruntfile.coffee=:\
*gruntfile.js=:\
*gruntfile.ls=:\
*gulpfile.coffee=:\
*gulpfile.js=:\
*gulpfile.ls=:\
*mix.lock=:\
*dropbox=:\
*.ds_store=:\
*.gitconfig=:\
*.gitignore=:\
*.gitattributes=:\
*.gitlab-ci.yml=:\
*.bashrc=:\
*.zshrc=:\
*.zshenv=:\
*.zprofile=:\
*.vimrc=:\
*.gvimrc=:\
*_vimrc=:\
*_gvimrc=:\
*.bashprofile=:\
*favicon.ico=:\
*license=:\
*node_modules=:\
*react.jsx=:\
*procfile=:\
*dockerfile=:\
*docker-compose.yml=:\
*rakefile=:\
*config.ru=:\
*gemfile=:\
*makefile=:\
*cmakelists.txt=:\
*robots.txt=ﮧ:\
*Gruntfile.coffee=:\
*Gruntfile.js=:\
*Gruntfile.ls=:\
*Gulpfile.coffee=:\
*Gulpfile.js=:\
*Gulpfile.ls=:\
*Dropbox=:\
*.DS_Store=:\
*LICENSE=:\
*React.jsx=:\
*Procfile=:\
*Dockerfile=:\
*Docker-compose.yml=:\
*Rakefile=:\
*Gemfile=:\
*Makefile=:\
*CMakeLists.txt=:\
*jquery.min.js=:\
*angular.min.js=:\
*backbone.min.js=:\
*require.min.js=:\
*materialize.min.js=:\
*materialize.min.css=:\
*mootools.min.js=:\
*vimrc=:\
Vagrantfile=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
"

# }}}

