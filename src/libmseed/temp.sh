#!/bin/bash

for i in `ls *.h`
do
   echo $i
   diff $i ~/Desktop/libmseed-master/$i
done
