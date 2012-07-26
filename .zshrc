PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### ===== VISUAL ===== ###
autoload -Uz colors
colors

setopt prompt_subst


case ${UID} in
  0)
  PROMPT="%{$fg_bold[green]%}%m%{$fg_bold[red]%}#%{$reset_color%} "
  PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
  ;;
  *)
  PROMPT="%{$fg_bold[cyan]%}%m%{$fg_bold[white]%}%%%{$reset_color%} "
  PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
  ;;
esac


RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%}"

SPROMPT="%{$fg_bold[red]%}correct%{$reset_color%}: %R -> %r ? "
### ===== /VISUAL ===== ###


### ===== Complement ===== ###
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

setopt auto_cd
setopt auto_pushd
setopt correct

setopt list_packed
setopt complete_aliases


zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
			     /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select
### ===== /Complement ===== ###

### ===== HISTORY ===== ###
HISTFILE=~/.zsh_histfile
SAVEHIST=10000

# 履歴を複数端末間で共有
setopt hist_ignore_all_dups
# 直前のコマンドと同じ場合履歴に追加しない
setopt hist_ignore_dups
# 重複するコマンドが記憶されるとき、古い方を削除する
setopt hist_save_no_dups
### ===== /HISTORY ===== ###


### ===== COLOR ===== ###
# 'dircolors -p'で出力されるものに手を加えて保存したものを読み込む
if [ -f ~/.dir_colors ]; then
  eval `dircolors -b ~/.dir_colors`
fi
### ===== /COLOR ===== ###


### ===== KEY BIND ===== ###
# vim風のkey bind
bindkey -v
# 矢印キーの変わりにhjklを
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
### ===== /KEY BIND ===== ###

### ===== FUNCTION ===== ###
# cdの後にlsを
function cd() {builtin cd $@ && ls -v -F }
# google search
function google() {
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt
}

function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup
### ===== /FUNCTION ===== ###


### ===== ALIAS ===== ###
alias ls='ls -v -F '
alias ll='ls -l'
alias la='ls -A'
alias lal="ls -l -A"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias locate="locate -i"
alias lv="lv -c -T8192"
### ===== /ALIAS ===== ###
