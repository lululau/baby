#!/bin/bash

function testArrayLast() {

    a=(10 '' 'h w' '$"' "'" '\ ')
    b=$(arr.last "a")
    assertEquals '\ ' "$b"

    a=(10 '' 'h w' '$"' "'")
    b=$(arr.last "a")
    assertEquals "'" "$b"

    a=(10 '' 'h w' '$"')
    b=$(arr.last "a")
    assertEquals '$"' "$b"

    a=(10 '' 'h w')
    b=$(arr.last "a")
    assertEquals 'h w' "$b"

    a=(10 '')
    b=$(arr.last "a")
    assertEquals '' "$b"

    a=(10)
    b=$(arr.last "a")
    assertEquals 10 "$b"    

    a=()
    b=$(arr.last "a")
    assertEquals '' "$b"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2