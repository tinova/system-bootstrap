# Check for an interactive session
[ -z "$PS1" ] && return

# history
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTTIMEFORMAT='%F %T '
shopt -s histappend

# hostname
export HOSTNAME=`hostname`

# detect OS
OS=`uname -s`
[ "$OS"  = "Darwin" ] && Mac=y
[ "$OS"  = "Linux"  ] && Linux=y

# safe_load
function safe_load {
    for file in "$@"; do
        if [ -f "$file" ];then
            source "$file"
        fi
    done
    return 0
}

# bash completion
test -n "$Linux" && safe_load /etc/bash_completion
test -n "$Mac"   && safe_load /usr/local/etc/bash_completion

# colors
safe_load ~/.bash_colors

# exit_status
function get_exit_status {
    status=`echo $?`
    if [ `echo $status` != "0" ]; then
        exit_status="($status) "
    else
        exit_status=""
    fi
}

HOST_PROMPT="${bldgrn}\h${txtrst} "
PROMPT_COMMAND='get_exit_status'
GIT_PS1_SHOWDIRTYSTATE=1

if type __git_ps1 &> /dev/null; then
    PS1="${HOST_PROMPT}${bldred}\${exit_status}${txtrst}${bldcyn}\W${txtrst} ${bldpur}\$(__git_ps1 '(%s)')${txtrst} $ "
else
    PS1="${HOST_PROMPT}${bldred}\${exit_status}${txtrst}${bldcyn}\W${txtrst} $ "
fi

#env variables
export EDITOR=/usr/bin/vi
export PATH=$HOME/bin:/sbin:/usr/bin/perlbin/vendor/:$HOME/.cabal/bin:$PATH
export BROWSER=chromium

# bash_aliases
safe_load ~/.bash_aliases
alias gsl='git log --oneline --decorate --color'
