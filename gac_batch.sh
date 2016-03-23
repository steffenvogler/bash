#!/bin/sh
#hi
STARTTIME=$(date +%s)
for file in /home/ip-linux/Documents/CellDetection/Counting_Party/data/AntiGFP_processed_mask/*.tif
do
         # name=${file##*/}
       # base=${name%.txt}
       #eval "sed -i 's/,(.+.tiff)/,$file/' /home/ip-linux/Documents/CellDetection/Counting_Party/data/gac/gac.txt"
    sed -i "s|,.*.tif|,$file|g" /home/ip-linux/Documents/CellDetection/Counting_Party/data/gac/gac.txt
    ../itk/twang_git/Bin/XPIWIT < ../data/gac/gac.txt 
    #  echo $file
    done

STOPTIME=$(date +%s)
diff=$(($STOPTIME-$STARTTIME))
echo "It takes $(($diff/60)) minutes to complete the task..." > computation_GAC.txt 2>&1



