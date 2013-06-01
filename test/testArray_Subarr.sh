#!/bin/bash

function testArray_Subarr() {

    a=(10 20 "h w" '$"' "'" '\ ')
    arr._subarr b 0 1 "${a[@]}"
    b_repr=$(arr.print b)
    expected="('10')"
    assertEquals "$expected" "$b_repr"
    unset b b_repr expected
    arr._subarr b 1 2 "${a[@]}"
    b_repr=$(arr.print b)
    expected="('20' 'h w')"
    assertEquals "$expected" "$b_repr"
    unset b b_repr expected
    arr._subarr b 3 3 "${a[@]}"
    b_repr=$(arr.print b)
    expected_arr=('$"' "'" '\ ')
    expected=$(arr.print "expected_arr")
    assertEquals "$expected" "$b_repr"
    unset b b_repr expected expected_arr
    arr._subarr b 4 1 "${a[@]}"
    expected_arr=("'")
    expected=$(arr.print expected_arr)
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
    unset b b_repr expected expected_arr
    arr._subarr b 5 1 "${a[@]}"
    expected_arr=('\ ')
    expected=$(arr.print expected_arr)
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
}

function testArray_Subarr_with_zero_length() {

    a=(10 20 "h w" '$"' "'" '\ ')
    arr._subarr b 0 0 "${a[@]}"
    b_repr=$(arr.print b)
    expected="()"
    assertEquals "$expected" "$b_repr"
    unset b b_repr
    arr._subarr b 1 0 "${a[@]}"
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
    unset b b_repr
    arr._subarr b 3 0 "${a[@]}"
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
    unset b b_repr
    arr._subarr b 4 0 "${a[@]}"
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
    unset b b_repr
    arr._subarr b 5 0 "${a[@]}"
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
}

function testArray_Subarr_with_negative_length() {

    a=(10 20 "h w" '$"' "'" '\ ')
    arr._subarr b 0 -1 "${a[@]}"
    b_repr=$(arr.print b)
    expected="()"
    assertEquals "$expected" "$b_repr"
    unset b b_repr
    arr._subarr b 1 -2 "${a[@]}"
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
    unset b b_repr
    arr._subarr b 3 -3 "${a[@]}"
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
    unset b b_repr
    arr._subarr b 4 -100 "${a[@]}"
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
    unset b b_repr
    arr._subarr b 5 -9999999 "${a[@]}"
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
}

function testArray_Subarr_with_length_out_of_index() {

    a=(10 20 "h w" '$"' "'" '\ ')
    arr._subarr b 0 10 "${a[@]}"
    b_repr=$(arr.print b)
    expected=$(arr.print a)
    assertEquals "$expected" "$b_repr"
    unset b b_repr expected
    arr._subarr b 1 10 "${a[@]}"
    b_repr=$(arr.print b)
    expected=$(arr._print 20 "h w" '$"' "'" '\ ')
    assertEquals "$expected" "$b_repr"
    unset b b_repr expected
    arr._subarr b 3 10 "${a[@]}"
    b_repr=$(arr.print b)
    expected_arr=('$"' "'" '\ ')
    expected=$(arr.print "expected_arr")
    assertEquals "$expected" "$b_repr"
    unset b b_repr expected expected_arr
    arr._subarr b 4 10 "${a[@]}"
    expected_arr=("'" '\ ')
    expected=$(arr.print expected_arr)
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
    unset b b_repr expected expected_arr
    arr._subarr b 5 10 "${a[@]}"
    expected_arr=('\ ')
    expected=$(arr.print expected_arr)
    b_repr=$(arr.print b)
    assertEquals "$expected" "$b_repr"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2