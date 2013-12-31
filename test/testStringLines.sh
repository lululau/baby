#!/bin/bash

function testStringLines() {

    s="hello world"
    assertEquals 1 $(str.lines "$s")

    s=$'hello world\nhello world'
    assertEquals 2 $(str.lines "$s")

    s=$'hello wo"ld\nhe'\'$'lo world\n '
    assertEquals 3 $(str.lines "$s")

}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2