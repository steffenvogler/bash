#!/bin/sh
#hi
STARTTIME=$(date +%s)

    sed -i "s|,.*.tif|,/home/ip-linux/Documents/CellDetection/Counting_Party/data/AntiGFP_processed_mask/90B.tif|g" /home/ip-linux/Documents/CellDetection/Counting_Party/data/gac/gac.txt
    ../itk/twang_git/Bin/XPIWIT < ../data/gac/gac.txt 
   sed -i "s|,.*.tif|,/home/ip-linux/Documents/CellDetection/Counting_Party/data/AntiGFP_processed_mask/90A.tif|g" /home/ip-linux/Documents/CellDetection/Counting_Party/data/gac/gac.txt
    ../itk/twang_git/Bin/XPIWIT < ../data/gac/gac.txt 
   sed -i "s|,.*.tif|,/home/ip-linux/Documents/CellDetection/Counting_Party/data/AntiGFP_processed_mask/89B.tif|g" /home/ip-linux/Documents/CellDetection/Counting_Party/data/gac/gac.txt
    ../itk/twang_git/Bin/XPIWIT < ../data/gac/gac.txt 
  

STOPTIME=$(date +%s)
diff=$(($STOPTIME-$STARTTIME))
echo "It takes $(($diff/60)) minutes to complete the task..." > computation_GAC.txt 2>&1



