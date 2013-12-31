#!/bin/bash

function testStringReplace() {

    s="hello,world."
    r=$(str.replace 's#l#X#g' "$s")
    assertEquals "heXXo,worXd." "$r"

    r=$(str.replace 's#.(?=l)#X#g' "$s")
    assertEquals "hXXlo,woXld." "$r"

    r=$(str.replace 's#.(?!l)#X#g' "$s")
    assertEquals "XelXXXXXrXXX" "$r"

    r=$(str.replace 's#(?<=l).#X#g' "$s")
    assertEquals "helXX,worlX." "$r"

    r=$(str.replace 's#(?<!l).#X#g' "$s")
    assertEquals "XXXloXXXXXdX" "$r"

    s=$(cat <<"EOF"
h'el"lo,'' w"""or'ld.'''
EOF
)
    r=$(str.replace 's#\"#X#g' "$s")
    e=$(cat <<"EOF"
h'elXlo,'' wXXXor'ld.'''
EOF
)
    assertEquals "$e" "$r"

    r=$(str.replace "s#'#X#g" "$s")
    e=$(cat <<"EOF"
hXel"lo,XX w"""orXld.XXX
EOF
)
    assertEquals "$e" "$r"

    r=$(str.replace "s# #X#g" "$s")
    e=$(cat <<"EOF"
h'el"lo,''Xw"""or'ld.'''
EOF
)
    assertEquals "$e" "$r"

}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2