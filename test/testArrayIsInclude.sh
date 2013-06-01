#!/bin/bash

function testArrayIsInclude() {

    a=(10 20 "h w" '$"' "'" '\ ')
    assertTrue 'arr.include? "10" "a"'
    assertTrue 'arr.include? "20" "a"'
    assertTrue 'arr.include? "h w" "a"'
    assertTrue 'arr.include? "\$\"" "a"'
    assertTrue 'arr.include? "'\''" "a"'
    assertTrue 'arr.include? "\\ " "a"'
    assertFalse 'arr.include? "30" "a"'
    assertFalse 'arr.include? "\$" "a"'
    assertFalse 'arr.include? "\"" "a"'
    assertFalse 'arr.include? "\\" "a"'
    assertFalse 'arr.include? "'\'\''" "a"'
}


PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2