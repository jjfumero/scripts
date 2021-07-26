#!/bin/bash


clang -cc1 -triple spir64-unknown-unknown $1.cl -O0 -finclude-default-header -emit-llvm-bc -o $1.bc
#clang -cc1 -triple spir64-unknown-unknown $1.cl -finclude-default-header -emit-llvm-bc -o $1.bc

if [ $? -eq 0 ]; then
	echo "Compilation OK"
else
	echo FAIL
	exit
fi
llvm-spirv $1.bc -o $1.spv
spirv-dis $1.spv

spirv-cfg $1.spv > x.gv
dot -Tpng  -o x.png x.gv 

cp $1.spv /tmp
