#### history
HISTFILE="$HOME/.zhistory"      # 履歴ファイル
HISTSIZE=10000                  # メモリ上に保存される $HISTFILE の最大サイズ
SAVEHIST=10000                  # 保存される最大履歴数
setopt bang_hist                # !を使ったヒストリ展開を行う(d)
setopt extended_history         # ヒストリに実行時間も保存する
setopt hist_ignore_dups         # 直前と同じコマンドはヒストリに追加しない
setopt share_history            # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks       # 余分なスペースを削除してヒストリに保存する
setopt hist_ignore_all_dups     # 既にヒストリにあるコマンド行は古い方を削除

if [ "$TERM" = "screen" ]; then
    chpwd () { echo -n "_`dirs`\\" }
    chpwd
fi

mkWorkDir () {
    mkdir -p $HOME/Src/Work/`date +%Y%m`
    cd $HOME/Src/Work/`date +%Y%m`
}

backup () {
        if [ $1 ]
        then
                tar zcvf ${1}.`date +%Y%m%d%H%M%S`.tar.gz ${1}
        fi
}

bf () {
    if [ $1 ]; then
        cp ${1} ${1}.`date +%Y%m%d%H%M%S`.$ME;
    fi
}

cdwww() {
    #cd /usr/local/var/www
    cd /opt/homebrew/var/www
}

unixtime(){
    date '+%s'
}

# homebrewを優先させる
typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)

### Aliases ###
alias ll='ls -al'
alias lr='ls -ltr'
alias la='ls -alF'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'
alias -g S='| sed'
alias -g A='| awk'
alias -g W='| wc'

# ------------------------------
# General Settings
# ------------------------------
export EDITOR=nvim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export PERL_BADLANG=0

bindkey -e               # キーバインドをemacsモードに設定
#bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

setopt auto_name_dirs
setopt auto_remove_slash
setopt hist_ignore_space
setopt pushd_ignore_dups
setopt rm_star_silent
setopt sun_keyboard_hack
setopt always_last_prompt
setopt cdable_vars
setopt sh_word_split
setopt auto_param_keys

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{$fg[cyan]%}%n %/%# %{${reset_color}%}"
tmp_prompt2="%{$fg[cyan]%}%_> %{${reset_color}%}"
tmp_rprompt="%{$fg[green]%}[%/]%{${reset_color}%}"
tmp_sprompt="%{$fg[yellow]%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"
# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
    tmp_prompt="%B%U${tmp_prompt}%u%b"
    tmp_prompt2="%B%U${tmp_prompt2}%u%b"
    tmp_rprompt="%B%U${tmp_rprompt}%u%b"
    tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

#PROMPT='%{'$'\e[''33m%}[${HOSTNAME}:%~]%{'$'\e[''m%}'$'\n''%{'$'\e[''$[32+$RANDOM % 5]m%}%U%B[%*][%n@%m]\$%b%{'$'\e[''m%}%U%u '

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
#RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
PROMPT="%{$fg[green]}%}[%W %*] [${HOST%%.*}:%/]
${PROMPT}"
  #PROMPT="%{${fg[green]}%}[%W %*] ${HOST%%.*}:%/ ${PROMPT}"
;

if [ -f /opt/homebrew/opt/zinit/zinit.zsh ]
then
    source /opt/homebrew/opt/zinit/zinit.zsh
    # ----------------------------
    # Zinit plugins
    # ----------------------------
    # 入力補完
    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-completions
    # コマンド履歴を検索
    zinit light zdharma/history-search-multi-word
    # Load a few important annexes, without Turbo
    # (this is currently required for annexes)
    zinit light-mode for \
        zdharma-continuum/zinit-annex-as-monitor \
        zdharma-continuum/zinit-annex-bin-gem-node \
        zdharma-continuum/zinit-annex-patch-dl \
        zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk
fi

# ------------------------------
# Other Settings
# ------------------------------
### rbenv ###
if [ -d $HOME/.rbenv ]
then
    export PATH="$HOME/.rbenv/bin:$PATH"
    export PATH="$HOME/.rbenv/shims:$PATH"
    export RBENV_ROOT=$HOME/.rbenv
    if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
fi



# 参考: https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/steeef.zsh-theme
export VIRTUAL_ENV_DISABLE_PROMPT=1
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f') '
}
setopt prompt_subst
autoload -U add-zsh-hook
autoload -Uz vcs_info
#use extended color palette if available
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{214}"
    purple="%F{135}"
    hotpink="%F{163}"
    limegreen="%F{002}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
fi
# gitのみ有効化
zstyle ':vcs_info:*' enable git
# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true
# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH_BASE="[%b]%u%c"
FMT_BRANCH=${FMT_BRANCH_BASE}
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%}+${PR_RST}"
FMT_STAGED="%{$limegreen%}!${PR_RST}"
zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""
# gitコマンド実行時に呼ばれる
function steeef_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec
# ディレクトリ変更時に呼ばれる
function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd
# コマンド実行毎に呼ばれる
function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # untrackedファイルをチェックする（vcs_infoでは取得できないため）
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            FMT_BRANCH="${FMT_BRANCH_BASE}%{$purple%}*${PR_RST}"
        else
            FMT_BRANCH="${FMT_BRANCH_BASE}"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH}"
        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd
PROMPT=$'
%F{8}%n@%m %*${PR_RST} 
[%{$limegreen%}%~${PR_RST}]$vcs_info_msg_0_$(virtualenv_info)
$ '



## vcs_info 設定
#zstyle ':vcs_info:*' enable git # hg bzr svn 
#rPROMPT=""
#
#autoload -Uz vcs_info
#autoload -Uz add-zsh-hook
#autoload -Uz is-at-least
#autoload -Uz colors
#zstyle ':vcs_info:*' max-exports 3
#
#zstyle ':vcs_info:*' enable git svn hg bzr
## 標準のフォーマット(git 以外で使用)
## misc(%m) は通常は空文字列に置き換えられる
#zstyle ':vcs_info:*' formats '(%s)-[%b]'
#zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
#zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
#zstyle ':vcs_info:bzr:*' use-simple true
#
#
#if is-at-least 4.3.10; then
#    # git 用のフォーマット
#    # git のときはステージしているかどうかを表示
#    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
#    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
#    zstyle ':vcs_info:git:*' check-for-changes true
#    zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
#    zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列
#fi
#
## hooks 設定
#if is-at-least 4.3.11; then
#    # git のときはフック関数を設定する
#
#    # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
#    # のメッセージを設定する直前のフック関数
#    # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
#    # 各関数が最大3回呼び出される。
#    zstyle ':vcs_info:git+set-message:*' hooks \
#                                            git-hook-begin \
#                                            git-untracked \
#                                            git-push-status \
#                                            git-nomerge-branch \
#                                            git-stash-count
#
#    # フックの最初の関数
#    # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
#    # (.git ディレクトリ内にいるときは呼び出さない)
#    # .git ディレクトリ内では git status --porcelain などがエラーになるため
#    function +vi-git-hook-begin() {
#        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
#            # 0以外を返すとそれ以降のフック関数は呼び出されない
#            return 1
#        fi
#
#        return 0
#    }
#
#    # untracked フィアル表示
#    #
#    # untracked ファイル(バージョン管理されていないファイル)がある場合は
#    # unstaged (%u) に ? を表示
#    function +vi-git-untracked() {
#        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
#        if [[ "$1" != "1" ]]; then
#            return 0
#        fi
#
#        if command git status --porcelain 2> /dev/null \
#            | awk '{print $1}' \
#            | command grep -F '??' > /dev/null 2>&1 ; then
#
#            # unstaged (%u) に追加
#            hook_com[unstaged]+='?'
#        fi
#    }
#
#    # push していないコミットの件数表示
#    #
#    # リモートリポジトリに push していないコミットの件数を
#    # pN という形式で misc (%m) に表示する
#    function +vi-git-push-status() {
#        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
#        if [[ "$1" != "1" ]]; then
#            return 0
#        fi
#
#        if [[ "${hook_com[branch]}" != "master" ]]; then
#            # master ブランチでない場合は何もしない
#            return 0
#        fi
#
#        # push していないコミット数を取得する
#        local ahead
#        ahead=$(command git rev-list origin/master..master 2>/dev/null \
#            | wc -l \
#            | tr -d ' ')
#
#        if [[ "$ahead" -gt 0 ]]; then
#            # misc (%m) に追加
#            hook_com[misc]+="(p${ahead})"
#        fi
#    }
#
#    # マージしていない件数表示
#    #
#    # master 以外のブランチにいる場合に、
#    # 現在のブランチ上でまだ master にマージしていないコミットの件数を
#    # (mN) という形式で misc (%m) に表示
#    function +vi-git-nomerge-branch() {
#        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
#        if [[ "$1" != "1" ]]; then
#            return 0
#        fi
#
#        if [[ "${hook_com[branch]}" == "master" ]]; then
#            # master ブランチの場合は何もしない
#            return 0
#        fi
#
#        local nomerged
#        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')
#
#        if [[ "$nomerged" -gt 0 ]] ; then
#            # misc (%m) に追加
#            hook_com[misc]+="(m${nomerged})"
#        fi
#    }
#
#
#    # stash 件数表示
#    #
#    # stash している場合は :SN という形式で misc (%m) に表示
#    function +vi-git-stash-count() {
#        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
#        if [[ "$1" != "1" ]]; then
#            return 0
#        fi
#
#        local stash
#        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
#        if [[ "${stash}" -gt 0 ]]; then
#            # misc (%m) に追加
#            hook_com[misc]+=":S${stash}"
#        fi
#    }
#
#fi
#
#function _update_vcs_info_msg() {
#    local -a messages
#    local prompt
#
#    LANG=en_US.UTF-8 vcs_info
#
#    if [[ -z ${vcs_info_msg_0_} ]]; then
#        # vcs_info で何も取得していない場合はプロンプトを表示しない
#        prompt=""
#    else
#        # vcs_info で情報を取得した場合
#        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
#        # それぞれ緑、黄色、赤で表示する
#        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
#        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
#        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )
#
#        # 間にスペースを入れて連結する
#        prompt="${(j: :)messages}"
#    fi
#
#    RPROMPT="$prompt"
#}
#add-zsh-hook precmd _update_vcs_info_msg

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH="/usr/local/opt/apr/bin:$PATH"
export PATH="/usr/local/opt/apr-util/bin:$PATH"
export PYTHON="/opt/homebrew/bin/python3"
# Set PATH, MANPATH, etc., for Homebrew.
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/php@8.0/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if [ -f $HOME/.profile.local ]
then
    source $HOME/.profile.local
fi
#source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
eval "$(direnv hook zsh)"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

function prtag() {
        local pr_num=$1
        if [[ -z $pr_num ]]; then
        echo "探したいPRの番号を引数に指定してね"
        return 1
        fi
        if ! [[ $pr_num =~ ^[0-9]+$ ]]; then
        echo "数字で入力してね"
        return 1
        fi
        local merge_commit
        merge_commit=$(gh pr view "$pr_num" --json mergeCommit -q .mergeCommit.oid)
        if [[ -z $merge_commit ]]; then
        echo "PRが見つからないか、マージされていない可能性があります"
        return 1
        fi
        local tag
        tag=$(git describe --contains "$merge_commit" | sed 's/~[0-9]*$//')
        if [[ -z $tag ]]; then
        echo "該当するタグが見つかりません"
        return 1
        fi
        local repo_name
        repo_name=$(git remote get-url origin | sed 's/.*://;s/.git$//')
        echo "$tag"
        echo "https://github.com/${repo_name}/releases/tag/$tag"
}

# CFO-Alpha の歴史改変を乗り越えて PR を開く
function sepr() {
        if [[ $1 = '' ]]; then echo '探したいPRに含まれるコミットを引数として指定してね'; return; fi
        PR_NUM=`git log --merges --oneline --reverse --ancestry-path $1...develop | grep 'Merge pull request #' | head -n 1 | awk '{print $5}' | sed 's/#//g'`
        REPO_URL=`git config --get remote.origin.url | sed -r 's/.*(\@|\/\/)(.*)(\:|\/)([^:\/]*)\/([^\/\.]*)\.git/https:\/\/\2\/\4\/\5/'`
        echo "あなたのお探しの PR は $REPO_URL/pull/$PR_NUM"
}
