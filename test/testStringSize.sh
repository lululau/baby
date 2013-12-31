#!/bin/bash

function testStringSize() {

    s="hello,world."
    assertEquals 12 "$(str.size "$s")"

    s=$(cat <<"EOF"
h'el"lo,'' w"""or'ld.'''
EOF
)
    assertEquals 24 "$(str.size "$s")"

    s=""
    assertEquals 0 "$(str.size "$s")"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2