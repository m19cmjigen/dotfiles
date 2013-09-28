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
alias cdhtdocs="cd /Library/WebServer/Documents"

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

git config --global user.name	"$ME"
git config --global user.email	"$ME@gmail.com"

if [ -e $HOME/git-completion.bash ]
then
    source $HOME/git-prompt.sh
    source $HOME/git-completion.bash
fi

if [ -e $HOME/.profile.local ]
then
    source $HOME/.profile.local
fi

if [ ! -d $HOME/.rbenv ]
then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
