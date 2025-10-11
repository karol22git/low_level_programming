#!/bin/bash
filename=$1
destination=$2
object_file="${destination}.o"
nasm -felf "$filename" -o "$object_file"
#ld object_file -o destination
ld -m elf_i386  "$object_file" -o "$destination"


#nasm -felf64 hello.asm -o hello.o
#ld hello.o -o hello
#ld -m elf_x86_64  hello.o -o hello