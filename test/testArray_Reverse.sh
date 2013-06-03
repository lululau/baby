#!/bin/bash

function testArray_Reverse() {

    a=(10 20 'h w' '$"' "'" '\ ')
    arr._reverse b "${a[@]}"
    expected_arr=('\ ' "'" '$"' 'h w' 20 10)
    assertEquals "$(arr.print expected_arr)" "$(arr.print b)"

    a=('\ ')
    arr._reverse b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=("'")
    arr._reverse b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=('$"')
    arr._reverse b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=('')
    arr._reverse b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"

    a=()
    arr._reverse b "${a[@]}"
    assertEquals "$(arr.print a)" "$(arr.print b)"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2