#!/bin/bash

function testArraySize() {

    a=(10 '' 'h w' '$"' "'" '\ ')
    b=$(arr.size "a")
    assertEquals 6 "$b"

    a=(10 '' 'h w' '$"' "'")
    b=$(arr.size "a")
    assertEquals 5 "$b"

    a=(10 '' 'h w' '$"')
    b=$(arr.size "a")
    assertEquals 4 "$b"

    a=(10 '' 'h w')
    b=$(arr.size "a")
    assertEquals 3 "$b"

    a=(10 '')
    b=$(arr.size "a")
    assertEquals 2 "$b"

    a=(10)
    b=$(arr.size "a")
    assertEquals 1 "$b"    

    a=()
    b=$(arr.size "a")
    assertEquals 0 "$b"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2