#!/bin/bash

function testStringLength() {

    s="hello,world."
    assertEquals 12 "$(str.length "$s")"

    s=$(cat <<"EOF"
h'el"lo,'' w"""or'ld.'''
EOF
)
    assertEquals 24 "$(str.length "$s")"

    s=""
    assertEquals 0 "$(str.length "$s")"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2