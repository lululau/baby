#!/bin/bash

function testArray_IsInclude() {

    a=(10 20 "h w" '$"' "'" '\ ')
    assertTrue 'arr._include? "10" "${a[@]}"'
    assertTrue 'arr._include? "20" "${a[@]}"'
    assertTrue 'arr._include? "h w" "${a[@]}"'
    assertTrue 'arr._include? "\$\"" "${a[@]}"'
    assertTrue 'arr._include? "'\''" "${a[@]}"'
    assertTrue 'arr._include? "\\ " "${a[@]}"'
    assertFalse 'arr._include? "30" "${a[@]}"'
    assertFalse 'arr._include? "\$" "${a[@]}"'
    assertFalse 'arr._include? "\"" "${a[@]}"'
    assertFalse 'arr._include? "\\" "${a[@]}"'
    assertFalse 'arr._include? "'\'\''" "${a[@]}"'
}


PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2