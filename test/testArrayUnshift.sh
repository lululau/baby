#!/bin/bash

function testArrayUnshift() {

    a=()
    arr.unshift! '\ ' a
    expected_arr=('\ ')
    expected=$(arr.print expected_arr)
    assertEquals "$expected" "$(arr.print a)"

    arr.unshift! "'" a
    expected_arr=("'" '\ ')
    expected=$(arr.print expected_arr)
    assertEquals "$expected" "$(arr.print a)"

    arr.unshift! '$"' a
    expected_arr=('$"' "'" '\ ')
    expected=$(arr.print expected_arr)
    assertEquals "$expected" "$(arr.print a)"

    arr.unshift! 'h w' a
    expected_arr=('h w' '$"' "'" '\ ')
    expected=$(arr.print expected_arr)
    assertEquals "$expected" "$(arr.print a)"

    arr.unshift! '20' a
    expected_arr=(20 'h w' '$"' "'" '\ ')
    expected=$(arr.print expected_arr)
    assertEquals "$expected" "$(arr.print a)"

    arr.unshift! '10' a
    expected_arr=(10 20 'h w' '$"' "'" '\ ')
    expected=$(arr.print expected_arr)
    assertEquals "$expected" "$(arr.print a)"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2