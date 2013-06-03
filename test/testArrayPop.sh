#!/bin/bash

function testArrayPop() {

    a=(10 20 "h w" '$"' "'" '\ ')
    arr.pop! poped_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected='\ '
    assertEquals "$expected" "$poped_val"
    a_repr=$(arr.print a)
    expected=$(arr._print 10 20 "h w" '$"' "'")
    assertEquals "$expected" "$a_repr"
    arr.pop! poped_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected="'"
    assertEquals "$expected" "$poped_val"
    a_repr=$(arr.print a)
    expected=$(arr._print 10 20 "h w" '$"')
    assertEquals "$expected" "$a_repr"
    arr.pop! poped_val a
    returned_code=$?    
    assertEquals 0 $returned_code
    expected='$"'
    assertEquals "$expected" "$poped_val"
    a_repr=$(arr.print a)
    expected=$(arr._print 10 20 "h w")
    assertEquals "$expected" "$a_repr"
    arr.pop! poped_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected="h w"
    assertEquals "$expected" "$poped_val"
    a_repr=$(arr.print a)
    expected=$(arr._print 10 20)
    assertEquals "$expected" "$a_repr"
    arr.pop! poped_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected="20"
    assertEquals "$expected" "$poped_val"
    a_repr=$(arr.print a)
    expected=$(arr._print 10)
    assertEquals "$expected" "$a_repr"
    arr.pop! poped_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected="10"
    assertEquals "$expected" "$poped_val"
    a_repr=$(arr.print a)
    expected='()'
    assertEquals "$expected" "$a_repr"
    arr.pop! poped_val a
    returned_code=$?
    assertNotEquals 0 $returned_code
}



PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2