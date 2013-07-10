export LANG=ja_JP.UTF-8
## terminalの色設定
export LSCOLORS=gxfxcxdxbxegedabagacad

ME=`whoami`

PS1='\[\033[0;32m\][`date`]\n[`hostname`:$PWD]\[\033[0;37m\]\n[\u]$(__git_ps1 "(%s)")\$ ' ;
alias ll="ls -laG"
alias la="ls -laG"
alias cp="cp -p"
alias rm="rm -i"
alias mv="mv -i"
alias ..="cd .."
<<<<<<< HEAD
alias cdhtdocs="cd /Library/WebServer/Documents"
=======
>>>>>>> 32906342fb8ca1b4bab269fb9cdae00670141c4e

cdd () {
        if [ $1 ] ;
        then
                cd `cat $HOME/.cdd | awk '{print "["FNR"] "$1""}' | grep "\[$1\]" | awk '{print $2}'`
        else
                cat $HOME/.cdd | awk '{print "["FNR"] "$1""}'
        fi
}

bf() {
        if [ $1 ] ; 
        then
                sudo cp ${1} ${1}.`date +%Y%m%d%H%M%S`;
        fi  
}

# .DS_Storeファイルの削除コマンド
alias delDsF="sudo find . -type f -name '.DS_Store' -delete"

alias set-utf8='source ~/setting/lang-utf8'
HISTTIMEFORMAT='%Y-%m-%d %T '; export HISTTIMEFORMAT

YUI_ROOT=/Users/$ME/Src/javascript/yuicompressor-2.4.2
yuicompress() {
	/usr/bin/java -jar $YUI_ROOT/build/yuicompressor-2.4.2.jar ${@}
}

git config --global user.name	"$ME"
git config --global user.email	"$ME@gmail.com"
source $HOME/.git-completion.bash
source $HOME/.profile.local
