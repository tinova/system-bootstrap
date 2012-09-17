#!/usr/bin/env bash

URL=https://github.com/jmelis/system-bootstrap/tarball/master
TMP_DIR=/tmp
TAR=$TMP_DIR/system-bootstrap.tar.gz
TIMESTAMP=$(date '+%Y%m%d%H%M')

function bk_file {
    echo "* Backing up: $1 => $1.$TIMESTAMP"
    mv "$1" "$1.$TIMESTAMP"
}

cd $HOME

curl -sL $URL > $TAR
tar xzf $TAR -C $TMP_DIR

DIR=$(tar tvzf $TAR |head -n1|awk '{print $NF}')

for file in `ls -a $TMP_DIR/$DIR`; do
    [ "$file" = "." -o "$file" = ".." ] && continue
    [ "$file" = "install.sh" ] && continue
    [ "$file" = "README.md"  ] && continue

    [ -e "$file" ] && bk_file "$file"

    echo "* Copying: $file"
    cp -r "$TMP_DIR/$DIR$file" .
done

exit 0
