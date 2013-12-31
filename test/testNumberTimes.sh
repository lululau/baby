#!/bin/bash

function testNumberTimes_with_function_body() {

    s="$(num.times 10 "$(cat <<"EOF"
{    
    echo "$1"
}        
EOF
        )")"
    e=$'0\n1\n2\n3\n4\n5\n6\n7\n8\n9'
    assertEquals "$e" "$s"

    s="$(num.times 10 "$(cat <<"EOF"
{    
    echo '"'
}        
EOF
        )")"
    e=$'"\n"\n"\n"\n"\n"\n"\n"\n"\n"'
    assertEquals "$e" "$s"
}

function __test_func() {
    echo "$1"
}

function __test_func2() {
    echo '"'
}

function testNumberTimes_with_function_name() {

    s="$(num.times 10 __test_func)"
    unset __test_func
    e=$'0\n1\n2\n3\n4\n5\n6\n7\n8\n9'
    assertEquals "$e" "$s"

    unset __test_func

    s="$(num.times 10 __test_func2)"
    unset __test_func2
    e=$'"\n"\n"\n"\n"\n"\n"\n"\n"\n"'
    assertEquals "$e" "$s"
    unset __test_func2

}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2