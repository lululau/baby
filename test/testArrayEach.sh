#!/bin/bash

function testArrayEach_with_function_body_string() {

    a=(10 20 "h w" '$"' "'" '\ ')
    b=$(arr.each '
    {
        echo "hello, $1."
    }
    ' "a")
    expected=$'hello, 10.\nhello, 20.\nhello, h w.\nhello, $".\nhello, \'.\nhello, \ .'
    assertEquals "$expected" "$b"
}

function __test_hello() {
    echo "hello, $1."
}

function testArrayEach_with_function_name() {    

    a=(10 20 "h w" '$"' "'" '\ ')
    b=$(arr.each '__test_hello' "a")
    expected=$'hello, 10.\nhello, 20.\nhello, h w.\nhello, $".\nhello, \'.\nhello, \ .'
    assertEquals "$expected" "$b"
}

function testArrayEach_with_meta_characters() {

    a=(10 20 "h w" '$"' "'" '\ ')
    b="$(arr.each '
    {
        echo "hello,'\''\"\\\$ $1."
    }
    ' "a")"
    expected=$'hello,\'"\$ 10.\nhello,\'"\$ 20.\nhello,\'"\$ h w.\nhello,\'"\$ $".\nhello,\'"\$ \'.\nhello,\'"\$ \ .'
    assertEquals "$expected" "$b"
}

PROG_DIR=$(cd "$(dirname "$0")"; pwd)
source "$PROG_DIR/../baby.sh"
source /usr/lib/shunit2/src/shunit2