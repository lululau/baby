#!/bin/bash

function testArrayPrint() {

    a=(10 20 "h w" '$"' "'" '\ ')
    a_repr=$(arr.print "a")
    expected=$(cat <<"EOF"
('10' '20' 'h w' '$"' ''\''' '\ ')
EOF
        )
    assertEquals "$expected" "$a_repr"
}


PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2