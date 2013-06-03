#!/bin/bash

function testArrayCopy() {

    a=(10 '' 'h w' '$"' "'" '\ ')
    arr.copy b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w' '$"' "'")
    arr.copy b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w' '$"')
    arr.copy b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w')
    arr.copy b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '')
    arr.copy b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10)
    arr.copy b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=()
    arr.copy b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2