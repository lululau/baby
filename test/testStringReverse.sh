#!/bin/bash

function testStringReverse() {

    s="hello,world."
    r=$(str.reverse "$s")
    expected=".dlrow,olleh"
    assertEquals "$expected" "$r"

    s=$(cat <<"EOF"
h'el"lo,'' w"""or'ld.'''
EOF
)
    r=$(str.reverse "$s")
    expected=$(cat <<"EOF"
'''.dl'ro"""w '',ol"le'h
EOF
)
    assertEquals "$expected" "$r"

    s=""
    r=$(str.reverse "$s")
    expected=""
    assertEquals "$expected" "$r"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2