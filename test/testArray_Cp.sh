#!/bin/bash

function testArray_Cp() {

    a=(10 '' 'h w' '$"' "'" '\ ')
    arr._cp b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w' '$"' "'")
    arr._cp b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w' '$"')
    arr._cp b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '' 'h w')
    arr._cp b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10 '')
    arr._cp b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=(10)
    arr._cp b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=()
    arr._cp b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2