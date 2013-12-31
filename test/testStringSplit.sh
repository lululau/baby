#!/bin/bash

function testStringSplit() {

    s="hello,world."
    str.split a , "$s"
    expected_arr=(hello world.)
    assertEquals "$(arr.print expected_arr)" "$(arr.print a)"

    s=""
    str.split a , "$s"
    expected_arr=()
    assertEquals "$(arr.print expected_arr)" "$(arr.print a)"

    s="hello world."
    str.split a , "$s"
    expected_arr=('hello world.')
    assertEquals "$(arr.print expected_arr)" "$(arr.print a)"

    s=",,hello,world."
    str.split a , "$s"
    expected_arr=('' '' hello world.)
    assertEquals "$(arr.print expected_arr)" "$(arr.print a)"

    s="hel2lo,wo3rl4d."
    str.split a \\d "$s"
    expected_arr=(hel lo,wo rl d.)
    assertEquals "$(arr.print expected_arr)" "$(arr.print a)"

    s=$(cat <<"EOF"
h'el"lo,'' w"""or'ld.'''
EOF
)
    str.split a "'" "$s"
    expected_arr=(h 'el"lo,' '' ' w"""or' 'ld.')
    assertEquals "$(arr.print expected_arr)" "$(arr.print a)"

    str.split a '"' "$s"
    expected_arr=("h'el" "lo,'' w" "" "" "or'ld.'''")
    assertEquals "$(arr.print expected_arr)" "$(arr.print a)"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2