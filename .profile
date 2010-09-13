export PATH=/opt/local/bin:/opt/local/sbin/:/Developer/SDKs/flex_sdk_3/bin:$HOME/sh/:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export SVN_EDITOR=vim
export LANG=ja_JP.UTF-8
# terminalの色設定
export LSCOLORS=gxfxcxdxbxegedabagacad


#Macportのアップデートコマンド
alias macportupdate='sudo port -d selfupdate ; sudo port -d sync'

PS1='\[\033[0;32m\][`date`]\n[`hostname`:$PWD]\[\033[0;37m\]\n[\u]$' ;
alias ll="ls -laG"
alias la="ls -laG"
alias cp="cp -p"
alias rm="rm -i"
alias mv="mv -i"
alias vi="vim"
alias ..="cd .."
alias cdpear="cd /opt/local/lib/php/"
alias cdapache="cd /opt/local/apache2/"
alias cdhtdocs="cd /opt/local/apache2/htdocs"
alias cdlab="cd /opt/local/apache2/htdocs/lab"
alias cdsymf="cd /opt/local/apache2/htdocs/lab/php/symfony"
alias terr="tail -f /opt/local/apache2/logs/error_log"
alias tacc="tail -f /opt/local/apache2/logs/access_log"
alias cdshare="cd /opt/local/lib/php"
alias mysql="mysql5"

# .DS_Storeファイルの削除コマンド
alias delDsF="sudo find . -type f -name '.DS_Store' -delete"

RHINO_HOME=$HOME/Src/javascript/rhino1_7R2
export CLASSPATH=$RHINO_HOME/js.jar

alias set-utf8='source ~/setting/lang-utf8'
HISTTIMEFORMAT='%Y-%m-%d %T '; export HISTTIMEFORMAT

# add android sdk
ANDROID_HOME=/Applications/android-sdk-mac_x86
export PATH=${ANDROID_HOME}/tools:$PATH

# MacPorts Installer addition on 2010-09-09_at_01:34:33: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

