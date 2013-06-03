#!/bin/bash

function testArrayShift() {

    a=(10 20 "h w" '$"' "'" '\ ')
    arr.shift! shifted_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected='10'
    assertEquals "$expected" "$shifted_val"
    a_repr=$(arr.print a)
    expected=$(arr._print 20 "h w" '$"' "'" '\ ')
    assertEquals "$expected" "$a_repr"

    arr.shift! shifted_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected='20'
    assertEquals "$expected" "$shifted_val"
    a_repr=$(arr.print a)
    expected=$(arr._print "h w" '$"' "'" '\ ')
    assertEquals "$expected" "$a_repr"

    arr.shift! shifted_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected='h w'
    assertEquals "$expected" "$shifted_val"
    a_repr=$(arr.print a)
    expected=$(arr._print '$"' "'" '\ ')
    assertEquals "$expected" "$a_repr"

    arr.shift! shifted_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected='$"'
    assertEquals "$expected" "$shifted_val"
    a_repr=$(arr.print a)
    expected=$(arr._print "'" '\ ')
    assertEquals "$expected" "$a_repr"

    arr.shift! shifted_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected="'"
    assertEquals "$expected" "$shifted_val"
    a_repr=$(arr.print a)
    expected=$(arr._print '\ ')
    assertEquals "$expected" "$a_repr"

    arr.shift! shifted_val a
    returned_code=$?
    assertEquals 0 $returned_code
    expected='\ '
    assertEquals "$expected" "$shifted_val"
    a_repr=$(arr.print a)
    expected="()"
    assertEquals "$expected" "$a_repr"

    arr.shift! shifted_val a
    returned_code=$?
    assertNotEquals 0 $returned_code
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2