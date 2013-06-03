#!/bin/bash

function testArrayCp() {

    a=(10 '' 'h w' '$"' "'" '\ ')
    arr.cp b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w' '$"' "'")
    arr.cp b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w' '$"')
    arr.cp b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w')
    arr.cp b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '')
    arr.cp b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10)
    arr.cp b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=()
    arr.cp b "a"
    assertEquals "$(arr.print a)" "$(arr.print b)"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2