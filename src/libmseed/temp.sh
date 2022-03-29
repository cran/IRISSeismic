#!/bin/bash

for i in `ls *.c *.h`
do 
  diff $i ~/Desktop/libmseed-2.19.8/$i
done
