#!/bin/sh

if  [ -z "$1" ] ; then
    echo Usage: $0 diff-file
    exit
fi

if [ \! -e .repo ] ; then
    echo Warning: $0 should be run from the root of your repo tree,
proceeding anyway
fi

LINENUM=0
CHUNKSTART=1
CHUNKLEN=0

grep -n '^project ' "$1" | {

while read PROJLINE; do
    LINENUM=`echo $PROJLINE | sed 's@^\(.*\)[:]project \(.*\)@\1@'`
    PROJECT=`echo $PROJLINE | sed 's@^\(.*\)[:]project \(.*\)@\2@'`
    if [ "$CHUNKSTART" != "1" ]; then
        CHUNKLEN=`expr $LINENUM - $CHUNKSTART`
        cat "$1" | head -n `expr $CHUNKSTART '+' $CHUNKLEN - 1` | tail
-n $CHUNKLEN | patch -p1 --no-backup-if-mismatch -d "$PROJDIR"
    fi
    echo Applying patch to the dir $PROJECT
    PROJDIR="$PROJECT"
    CHUNKSTART=`expr $LINENUM '+' 1`
done

if [ "$CHUNKSTART" != "1" ]; then
    FILESIZE=`cat "$1" | wc -l`
    cat "$1" | tail -n `expr $FILESIZE - $CHUNKSTART + 1` | patch -p1
--no-backup-if-mismatch -d "$PROJDIR"
fi

} 
