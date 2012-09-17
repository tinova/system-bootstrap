alias ll='ls -lh'
alias la='ls -halrt'
alias l='ls -hlrt'
alias grep='grep --color=auto'
alias less='less -r'
alias forget='unset HISTFILE'
alias tree='tree -CF'
alias mtr='mtr -t'

# alias lspwd='realpath -s'
# alias diff='colordiff -u'
alias vi='vim'

# Git
alias git-graph='git log --oneline --graph --decorate'
alias gs='git status'
alias gl='git log'
alias gsl='git sl'
alias gslhead='gsl|head'
alias gr='gitroot'

#opennebula
export ONE_AUTH=$HOME/.one/auth
echo 'oneadmin:-' > $ONE_AUTH

function one_env {
    #!/bin/bash

    DATE=$(date "+%Y%m%d%H%M%S")
    PID=$$

    TEMPFILE=/tmp/one-$PID-$DATE

    cat <<EOF > $TEMPFILE
    export ONE_LOCATION=$(pwd)
    export ONE_AUTH=\$ONE_LOCATION/.one-auth
    export ONE_XMLRPC=http://localhost:2633/RPC2
    export PATH=\$ONE_LOCATION/bin:\$PATH
    echo oneadmin:- > \$ONE_AUTH

    function onelog {
            if [ -n "\$1" ]; then
                    vm=\$1
                    if echo \$vm|grep -qE '^[0-9]+$'; then
                if [ -f $ONE_LOCATION/var/$vm/vm.log ]; then
                    less $ONE_LOCATION/var/$vm/vm.log
                else
                    echo "The log for the VM '\$vm' does not exist."
                fi
            else
                echo "'\$vm' is not a valid VM identifier."
            fi
        else
            less \$ONE_LOCATION/var/oned.log
        fi
    }

    #. \$HOME/.one-bash_completion
EOF

    source $TEMPFILE
    rm $TEMPFILE
}


function delkey {
    line=$1
    sed -i "${line}d" ~/.ssh/known_hosts
}

function gitroot {
    ROOTDIR=`git rev-parse --show-cdup 2>/dev/null`
    test -n "$ROOTDIR" && cd $ROOTDIR
}


function set_one_auth {
    TMP=$(mktemp)
    echo "$1" > $TMP
    export ONE_AUTH=$TMP
}
