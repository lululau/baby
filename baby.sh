#!/bin/bash

function arr._join() {

    local __help=$(cat <<"EOF"
Usage:

    arr._join <separator> <elements of array>
    join <elements of array> to a string with <separator>, then write the joined string to stdout.

<example>:

    1. arr._join , hello world haha

       "hello,world,haha" will be written to stdout.

    2. a=(10 20 30 40)
       s=$(arr._join "-" "${a[@]}")

       value of s will be "10-20-30-40"
EOF
        )

    func.help "$__help" "$@" && return 0
    local __delimiter=$1
    shift
    if [ -z "$1" ]
    then
        exit
    fi
    local __return_value=$1
    shift
    local __item
    for __item in "$@"
    do
        __return_value="${__return_value}${__delimiter}${__item}"
    done
    echo "$__return_value"
}

function arr.join() {
    local __help=$(cat <<"EOF"
Usage:        

    arr.join <separator> <name of array>
EOF
)
    local __arr_name=$2
    local __delimiter=$1
    __delimiter=${__delimiter//\'/\'\\\'\'}
    eval "arr._join '$__delimiter' \"\${$__arr_name[@]}\""
}

# example:
#     arr._map "my_new_array" "my_command" "$@"
#     arr._map "my_new_array" "my_command" "${my_arrray[@]}"
# comments:
#     execute "my_command" with the elememnt passed for every element of "$@" or "${my_array[@]}" 
#     assign the mapped array to "my_new_array"
function arr._map() {
    local __assign_array_name=$1
    shift
    local __map_func=$1
    shift
    local __map_func_lines=$(str.lines "$__map_func")    
    local __map_func_name="__tmp_func"
    if [ "$__map_func_lines" -gt 1 ]; then
        local __func_definition="
        function $__map_func_name()
        $__map_func
        "
        eval "$__func_definition"
    else
        __map_func_name="$__map_func"
    fi
    local __local_arr=()
    local __item
    for __item in "$@"
    do
        __item=${__item//\'/\'\\\'\'}
        local __new_item=$(eval "$__map_func_name '$__item'")
        __local_arr+=("$__new_item")
    done
    if [[ "${#__local_arr[@]}" == 0 ]]; then
        eval "$__assign_array_name=()"
    else
        local __joined_array=""
        local __i
        for __i in "${__local_arr[@]}"
        do
            __i=${__i//\'/\'\\\'\'}
            __joined_array="$__joined_array' '$__i"
        done
        __joined_array=${__joined_array#\' \'}
        eval "$__assign_array_name=('$__joined_array')"
    fi
    unset __tmp_func
}

# example:
#     arr._map "my_new_array" "my_command" my_array
# comments:
#     execute "my_command" with the elememnt passed for every element of "my_array" 
#     assign the mapped array to "my_new_array"
function arr.map() {
    local __func=$2
    __func=${__func//\'/\'\\\'\'}
    local __arr_name=$3
    eval "arr._map '$1' '$__func' \"\${$__arr_name[@]}\""
}

function arr._print() {
    local __tmp_arr
    arr._map __tmp_arr "$(cat <<'EOF'
{
    local __str=$1
    __str=${__str//\'/\'\\\'\'}
    echo "'$__str'"    
}
EOF
    )" "$@"
    echo "($(arr._join " " "${__tmp_arr[@]}"))"
}

function arr.print() {
    local arr_name=$1
    eval "arr._print \"\${$arr_name[@]}\""
}

function arr._grep() {
    local __assign_array_name=$1
    shift
    local __grep_func=$1
    shift
    local __grep_func_lines=$(str.lines "$__grep_func")
    local __grep_func_name="__tmp_func"
    if [ "$__grep_func_lines" -gt 1 ]; then
        local __func_definition="
        function $__grep_func_name()
        $__grep_func
        "
        eval "$__func_definition"
    else
        __grep_func_name="$__grep_func"
    fi
    local __local_arr=()
    local __item
    for __item in "$@"
    do
        local __quoted=${__item//\'/\'\\\'\'}
        local __eval_str=$(cat <<EOF
        if $__grep_func_name '$__quoted'
        then
            echo true
        else
            echo false
        fi
EOF
)
        local __eval_result=$(eval "$__eval_str")
        if [ "$__eval_result" = true ]; then
            __local_arr+=("$__item")
        fi
    done
    if [[ ${#__local_arr[@]} == 0 ]]; then
        eval "$__assign_array_name=()"
    else
        local __joined_array=""
        local __i
        for __i in "${__local_arr[@]}"
        do
            __i=${__i//\'/\'\\\'\'}
            __joined_array="$__joined_array' '$__i"
        done
        __joined_array=${__joined_array#\' \'}
        eval "$__assign_array_name=('$__joined_array')"
    fi
    unset __tmp_func
}

function arr.grep() {
    local __func=$2
    __func=${__func//\'/\'\\\'\'}
    local __arr_name=$3
    eval "arr._grep '$1' '$__func' \"\${$__arr_name[@]}\""
}

function arr._include?() {
    local __value=$1
    shift
    local __elem
    for __elem in "$@"
    do
        if [ "$__elem" = "$__value" ]; then
            return 0
        fi
    done
    return 1
}

function arr.include?() {
    local __value=$1
    __value=${__value//\'/\'\\\'\'}
    local __arr_name=$2
    return $(eval "arr._include? '$__value' \"\${$__arr_name[@]}\"; echo \$?")
}

function arr._each() {
    local __func=$1
    shift
    local __func_lines=$(str.lines "$__func")
    local __func_name="__tmp_func"
    if [ "$__func_lines" -gt 1 ]; then        
        local __func_definition="
        function $__func_name()
        $__func
        "
        eval "$__func_definition"
    else
        __func_name="$__func"
    fi
    local __elem
    local __i=0
    for __elem in "$@"
    do
        __elem=${__elem//\'/\'\\\'\'}
        eval "$__func_name '$__elem' '$__i'"
        ((__i++))
    done
    unset __tmp_func
}

function arr.each() {
    local __func=$1
    __func=${__func//\'/\'\\\'\'}
    local __arr_name=$2
    eval "arr._each '$__func' \"\${$__arr_name[@]}\""
}

function arr._subarr() {
    local __new_arr_name=$1
    shift
    local __offset=$1
    shift
    local __length=$1
    shift
    local __size=$(arr._size "$@")
    if ((__length > __size - __offset)); then
        __length=$((__size - __offset))
    fi
    if [ "$__length" -lt 1 ]; then
        eval "$__new_arr_name=()"
        return 0
    fi
    if [ "$__offset" -gt 0 ]; then
        for i in $(seq 1 "$__offset"); do
            shift
        done
    fi
    local __joined_array=""
    local __i
    for __i in $(seq 1 "$__length"); do
        local __item=${!__i}        
        __item=${__item//\'/\'\\\'\'}
        __joined_array="$__joined_array' '$__item"
    done
    __joined_array=${__joined_array#\' \'}
    eval "$__new_arr_name=('$__joined_array')"
}

function arr.subarr() {
    eval "arr._subarr '$1' '$2' '$3' \"\${$4[@]}\""
}

function arr.pop!() {
    local __poped_var_name=$1
    shift
    local __arr_name=$1
    shift
    local __last_item
    local __arr_size=$(arr.size $__arr_name)
    if ((__arr_size < 1)); then
        return 1
    fi
    eval "__last_item=\${$__arr_name[$((__arr_size-1))]}"
    __last_item=${__last_item//\'/\'\\\'\'}
    eval "$__poped_var_name='$__last_item'"
    arr.subarr "$__arr_name" 0 $((__arr_size-1)) "$__arr_name"
    return 0
}

function arr.push!() {
    local __push_val=$1
    __push_val=${__push_val//\'/\'\\\'\'}
    local __arr_name=$2
    eval "$__arr_name+=('$__push_val')"
}

function arr.shift!() {
    local __shifted_var_name=$1
    shift
    local __arr_name=$1
    shift
    local __arr_size=$(arr.size $__arr_name)
    if ((__arr_size < 1)); then
        return 1
    fi
    local __first_item
    eval "__first_item=\${$__arr_name[0]}"
    __first_item=${__first_item//\'/\'\\\'\'}
    eval "$__shifted_var_name='$__first_item'"
    arr.subarr "$__arr_name" 1 $__arr_size "$__arr_name"
    return 0
}

function arr.unshift!() {
    local __unshift_val=$1
    __unshift_val=${__unshift_val//\'/\'\\\'\'}
    local __arr_name=$2
    local __arr_repr=$(arr.print "$__arr_name")
    eval "$__arr_name=('$__unshift_val' ${__arr_repr:1}"
}

function arr._reverse() {
    local __new_arr_name=$1
    shift
    local __arr_size=$#
    if ((__arr_size < 1)); then
        eval "$__new_arr_name=()"
        return
    fi
    local __joined_array=""
    local __i
    for __i in $(seq $# 1); do
        local __item=${!__i}
        __item=${__item//\'/\'\\\'\'}
        __joined_array="$__joined_array' '$__item"
    done
    __joined_array=${__joined_array#\' \'}
    eval "$__new_arr_name=('$__joined_array')"
}

function arr.reverse() {
    eval "arr._reverse '$1' \"\${$2[@]}\""
}

function arr._first() {
    echo "$1"
}

function arr.first() {
    eval "arr._first \"\${$1[@]}\""
}

function arr._last() {
    local __size=$(arr._size "$@")
    if ((__size < 1)); then
        echo ""
        return 1
    fi
    echo "${!__size}"
    return 0
}

function arr.last() {
    eval "arr._last \"\${$1[@]}\""
}

function arr._size() {
    echo $#
}

function arr.size() {
    eval "arr._size \"\${$1[@]}\""
}

function arr._length() {
    arr._size "$@"
}

function arr.length() {
    arr.size "$@"
}

function arr._copy() {
    local __new_arr_name=$1
    shift
    eval "$__new_arr_name=$(arr._print "$@")"
}

function arr.copy() {
    eval "arr._copy '$1' \"\${$2[@]}\""
}

function arr._cp() {
    arr._copy "$@"
}

function arr.cp() {
    arr.copy "$@"
}

function arr.range() {
    local __arr_var_name=$1
    local __start=$2
    local __end=$3
    local __step="$4"
    if [ -z "$__step" ]; then
        if ((__start > __end)); then
            __step=-1
        else
            __step=1
        fi
    fi
    eval "$__arr_var_name=($(seq "$__start" "$__step" "$__end"))"
}

function str.split() {
    local __arr_name=$1
    local __splitor=$2
    local __string=$3
    local __arr_repr="($(echo "$__string" | perl -lne 'chomp;print join " ", map {s#\\#\\\\#g;s#"#\\"#g;s#\$#\\\$#g;qq/"$_"/} split /'${__splitor}'/'))"
    eval "$__arr_name=$__arr_repr"
}

function str.reverse() {
    echo "$1" | perl -lpe '$_=reverse <>'
}

function str.size() {
    echo ${#1}
}

function str.length() {
    str.size "$@"
}

function str.replace() {
    local __s_pattern=$1
    local __str=$2
    echo "$__str" | perl -pe "$__s_pattern"
}

function str.lines() {
    echo "$1" | wc -l | grep -oE '[0-9]+' --color=none
}

function num.times() {
    local __help=$(cat <<"EOF"
Usage:   

    num.times <n times> <function>

    call <function> <n times>

<n times>:

    times the <function> will be invoked.

<function>:

    The function which will be invoked <n times>, passing in values from zero to n-1 as the first argument.

    If the <function> arg only contains one line text, then it will be reguarded as name of a pre-defined function, for example:

       function hello() {
           echo "hello, $1"
       }    

       num.times 2 hello

    Running the above code will print :

       hello, 0
       hello, 1

    If the <funcrion> arg contains more than one line text, then it'll be treated as the body of a bash function definition, 
    so it must be like this:

       {
           your code ....
       }    

    for example, the code below will print same text as the previous example:

        num.times 2 "$(cat <<"EOF"
        {
             echo "hello, $1"
        }
        EOF
        )"
EOF
        )
    func.help "$__help" "$@" && return 0
    local __i
    local __times=$1
    if ((__times < 1)); then
        return 0
    fi
    local __func=$2
    local __func_lines=$(str.lines "$__func")
    local __func_name="__tmp_fuc"

    if [ "$__func_lines" -gt 1 ]; then
        local __func_definition="
        function $__func_name()
        $__func
        "
        eval "$__func_definition"
    else
        __func_name="$__func"
    fi
    for __i in $(seq 1 "$__times"); do
        eval "$__func_name '$((__i - 1))'"
    done
    unset __tmp_func
}

function func.help() {
    if [ "$#" -eq 1 ]; then
        "$1" --help
        return 0
    fi
    if [ "$2" == "--help" -o "$2" == "-h" ]; then
        echo "$1"
        return 0
    else
        return 1
    fi
}