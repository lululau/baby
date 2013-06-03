#!/bin/bash

function testArrayPush() {

    a=()
    arr.push! 10 a
    expected="('10')"
    a_repr=$(arr.print a)
    assertEquals "$expected" "$a_repr"

    arr.push! 20 a
    expected="('10' '20')"
    a_repr=$(arr.print a)
    assertEquals "$expected" "$a_repr"

    arr.push! 'h w' a
    expected="('10' '20' 'h w')"
    a_repr=$(arr.print a)
    assertEquals "$expected" "$a_repr"

    arr.push! '$"' a
    expected="('10' '20' 'h w' '$\"')"
    a_repr=$(arr.print a)
    assertEquals "$expected" "$a_repr"

    arr.push! "'" a
    expected="('10' '20' 'h w' '$\"' ''\''')"
    a_repr=$(arr.print a)
    assertEquals "$expected" "$a_repr"

    arr.push! '\ ' a
    expected="('10' '20' 'h w' '$\"' ''\''' '\ ')"
    a_repr=$(arr.print a)
    assertEquals "$expected" "$a_repr"  
}



PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2