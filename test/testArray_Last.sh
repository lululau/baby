#!/bin/bash

function testArray_Last() {

    a=(10 '' 'h w' '$"' "'" '\ ')
    b=$(arr._last "${a[@]}")
    assertEquals '\ ' "$b"

    a=(10 '' 'h w' '$"' "'")
    b=$(arr._last "${a[@]}")
    assertEquals "'" "$b"

    a=(10 '' 'h w' '$"')
    b=$(arr._last "${a[@]}")
    assertEquals '$"' "$b"

    a=(10 '' 'h w')
    b=$(arr._last "${a[@]}")
    assertEquals 'h w' "$b"

    a=(10 '')
    b=$(arr._last "${a[@]}")
    assertEquals '' "$b"

    a=(10)
    b=$(arr._last "${a[@]}")
    assertEquals 10 "$b"    

    a=()
    b=$(arr._last "${a[@]}")
    assertEquals '' "$b"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2