#!/usr/bin/env bash

URL=https://github.com/jmelis/system-bootstrap/tarball/master
TMP_DIR=/tmp
TAR=$TMP_DIR/system-bootstrap.tar.gz
TIMESTAMP=$(date '+%Y%m%d%H%M')

function bk_file {
    mv "$1" "$1.$TIMESTAMP"
}

cd $HOME

curl -sL $URL > $TAR
tar xvzf $TAR -C $TMP_DIR

DIR=$(tar tvzf $TAR |head -n1|awk '{print $NF}')

for file in `ls -a $TMP_DIR/$DIR`; do
    [ "$file" = "." -o "$file" = ".." ] && continue
    [ -e "$file" ] && bk_file "$file"

    echo "* Copying: $file"
    cp -r "$file" .
done

exit 0