#!/bin/bash

for i in `ls`
do
 echo $i
 diff $i /Users/gillian/Desktop/libmseed-2.19.6/$i | wc -l

done
