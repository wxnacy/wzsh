#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-13
# Modified: 2022-01-13
# Description: fzf chrome 相关命令
#===============================

function ch() {
    # 搜索 chrome 浏览记录
    local cols sep google_history open
    cols=$(( COLUMNS / 3 ))
    sep='{::}'

    if [ "$(uname)" = "Darwin" ]; then
        google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
        open=open
    else
        google_history="$HOME/.config/google-chrome/Default/History"
        open=xdg-open
    fi
    cp -f "$google_history" /tmp/h
    sqlite3 -separator $sep /tmp/h \
        "select substr(title, 1, $cols), url
        from urls order by last_visit_time desc" |
    awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
    fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

function cb() {
    # 搜索 chrome 书签记录
    local google_bookmark open

    if [ "$(uname)" = "Darwin" ]; then
        open=open
    else
        open=xdg-open
    fi

    python ${WZSH_HOME}/plugins/wzsh-fzf/chrome.py print_bookmarks |
        # awk 'BEGIN { FS = "\t" } { printf \x1b[36m%s\x1b[m\n", $1, $2 }' |
        fzf --ansi --multi --no-hscroll --tiebreak=begin |
        awk 'BEGIN { FS = "\t" } { print $2 }' |
        xargs open > /dev/null 2> /dev/null
            # --preview "echo {} | awk 'BEGIN { FS="\t" } {print $2}'" |
}

cmd=$1
if [[ $cmd == 'cb' ]]
then
    cb
fi
