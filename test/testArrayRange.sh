#!/bin/bash

function testArrayRange() {

    arr.range a 1 10
    e=(1 2 3 4 5 6 7 8 9 10)
    assertEquals "$(arr.print e)" "$(arr.print a)"

    arr.range a 1 10 2
    e=(1 3 5 7 9)
    assertEquals "$(arr.print e)" "$(arr.print a)"

    arr.range a 4 10 3
    e=(4 7 10)
    assertEquals "$(arr.print e)" "$(arr.print a)"

    arr.range a 1 10 -2
    e=()
    assertEquals "$(arr.print e)" "$(arr.print a)"

    arr.range a 10 -3 -2
    e=(10 8 6 4 2 0 -2)
    assertEquals "$(arr.print e)" "$(arr.print a)"

    arr.range a 5 -3 
    e=(5 4 3 2 1 0 -1 -2 -3)
    assertEquals "$(arr.print e)" "$(arr.print a)"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2