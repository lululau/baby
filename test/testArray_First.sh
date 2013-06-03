#!/bin/bash

function testArray_First() {

    a=(10 '' 'h w' '$"' "'" '\ ')
    b=$(arr._first "${a[@]}")
    assertEquals "10" "$b"

    a=('' 'h w' '$"' "'" '\ ')
    b=$(arr._first "${a[@]}")
    assertEquals "" "$b"

    a=('h w' '$"' "'" '\ ')
    b=$(arr._first "${a[@]}")
    assertEquals "h w" "$b"

    a=('$"' "'" '\ ')
    b=$(arr._first "${a[@]}")
    assertEquals '$"' "$b"

    a=("'" '\ ')
    b=$(arr._first "${a[@]}")
    assertEquals "'" "$b"

    a=('\ ')
    b=$(arr._first "${a[@]}")
    assertEquals '\ ' "$b"

    a=()
    b=$(arr._first "${a[@]}")
    assertEquals '' "$b"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2