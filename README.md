# Baby

A collection of some utility functions for bash array/string manipulation.

## 1. 使用示例

### 1.1 数组

1. arr._join

   用法：
   
   ```
   arr._join <separator> <elements of array>
   
   join <elements of array> to a string with <separator>, then write the joined string to stdout.
   ```
   
   示例：
   
   (1)
   
   ```   
   arr._join , hello world haha    # "hello,world,haha" will be written to stdout.
   ```

   (2)

   ```
   a=(10 20 30 40)
   s=$(arr._join "-" "${a[@]}")    # value of s will be "10-20-30-40"
   ```

2. arr.join

   用法：
   
   ```
   arr.join <sparator> <name of array>
   
   join elements of <array> to a string with <seprator>, the joined string will be written to stdout.
   ```
   
   示例：
   
   (1)
   
   ```
   a=(11 20 58)
   s=$(arr.join ':' a)   # value of s will be "11:20:58"
   ```

3. arr.each

   用法：

   ```
   arr.each <command or function> <name of array>
   
   call the given <command or function> for each element in <array>, 
   passing the element and the index as the first and the second parameter.
   ```
   
   示例：
   
   (1)
   
   ```
   a=(10 20 30)
   function test() {
     local element=$1
     local index=$2
     echo "$index: $element"
   }
   arr.each test a
   ```
   
   (2)
   
   ```
   s="$(arr.each '{
   local e=$1
   local i=$2
   echo "$i: $e"
   }' a)"   # value of s will be "0: 10\n1: 20\n2: 30"
   ```

4. arr.map

   用法：
   
   ```
   arr.map <name of a new array> <command or function> <name of original array>
   
   Call the given <command or function> for each element of <original array>, 
   create a new array named <name of a new array> containing the values returned
   by the <command or functon>.
   ```
   
   示例：
   
   ```
   a=(10 20 30)
   arr.map b '{
   local elem=$1
   echo $(($elem * 5))
   }' a
   
   echo ${b[0]}  # => 50
   echo ${b[1]}  # => 100
   echo ${b[2]}  # => 150   
   ```


5. arr.grep

   用法：
   
   ```
   arr.grep <name of a new array> <command or function> <name of original array>
   
   evluates the <command or function> for each element of <original array> and returns the list value consisting of those elements for which the expression evaluated to true, and the returned list value will be assigned to the <a new array>.
   ```
   
   示例：
   
   ```
   a=(1 2 3 4 5 6 7 8 9)
   arr.grep b '{
   local elem=$1
   if ((elem < 5 )) || ((elem%2 == 1))
   then
     return 0
   else
     return 1
   fi
   }' a
   arr.print b # => ('1' '2' '3' '4' '5' '7' '9')
   ```
   
6. arr.print

   用法：
   
   ```
   arr.print <name of an array>
   
   print the expression string of <array>.
   ```
   
   示例：
   
   ```
   a=(1 2 3 'hello world')
   arr.print a  # => ('1' '2' '3' 'hello world')
   ```

### 1.2 字符串

1. str.length

   用法：
   
   ```
   str.length <string>
   
   print length of <string> to stdout.
   ```
   
   示例：
   
   ```
   a="hello world"
   len=$(str.length "$a")  # len => 11   
   ```

2. str.lines

   用法：
   
   ```
   str.lines <string>
   
   print the count of lines of <string> to stdout.
   
   ```
   
   示例：
   
   ```
   a=$'hello\nworld\ntest'
   l=$(str.lines "$a")  # l => 3   
   ```
   
3. str.replace

   用法：
   
   ```
   str.replace <perl 's' replacement expression> <string>
   
   replace <string> using <perl 's' replacement expression>.
   ```
   
   示例：
   
   ```
   a='123'
   b=$(str.replace 's#\d#$& * 2#ge' "$a")  # b => 246
   ```

4. str.reverse

   用法：
   
   ```
   str.reverse <original string>
   
   print a new string containing characters of the <original string> in reverse order to stdout.
   ```
   
   示例：
   
   ```
   a="hello world"
   b=$(str.reverse "$a")   # b => "dlrow olleh"
   ```

### 1.3 数值

1. num.times


   用法：
   
   ```
   num.times <n times> <function>

   call <function> <n times>

   <n times>:

      times the <function> will be invoked.

   <function>:

      The function which will be invoked <n times>, passing 
      in values from zero to n-1 as the first argument.
      If the <function> arg only contains one line text, then 
      it will be reguarded as name of a pre-defined function, 
      for example:

       function hello() {
           echo "hello, $1"
       }    

      num.times 2 hello

      Running the above code will print :

       hello, 0
       hello, 1

      If the <funcrion> arg contains more than one line text, 
      then it'll be treated as the body of a bash function 
      definition, so it must be like this:

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
   
   ```

**更多示例请参照 test 目录下的测试用例**

## 2. 安装

### 2.1 检出代码：

```
git clone https://github.com/lululau/baby
```

### 2.2 运行测试：

Baby 目前只在 Bash 4.2.25 中测试通过，使用前请确认它在你的 shell 中可以正常运行，运行测试的方法为：

```
cd baby
source baby.sh
cd test
./t.sh
```

### 2.3 使用方法：

```
#!/bin/bash

source xxx/xxx/baby.sh

your codes ...
```






