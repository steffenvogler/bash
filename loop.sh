#!/bin/bash

for file in /home/ip-linux/Documents/CellDetection/Counting_Party/data/AntiGFP_cropped_processed/*.tiff
do
    for ((i = 0; i < 3; i++))
    do
        name=${file##*/}
       # base=${name%.txt}
     echo $file
    done
done