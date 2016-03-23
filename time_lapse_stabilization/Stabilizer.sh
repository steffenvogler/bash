#!/bin/bash

#Atlasing-Util

begin=$(date +"%s")



#sleep 1

i=1
j=2
folder='./channel1/'
files=(ls $folder*)
echo "${files[$i]}"
echo "${files[$j]}"

count=$(ls $folder | wc -l)
echo $count

mkdir -p ./results
mkdir -p ./temp

transformix -in ${files[1]} -out ./results/ -tp ManualInit3D.txt -threads 4
t=${files[1]##*/}
mv ./results/result.mha ./results/${t%.mha}.mha


#for k in $(ls $folder); do
	    #echo item: ${files[$i]} plus ${files[$j]}
	    t=${files[i]##*/}
	    elastix -m ${files[$j]} -f ./results/${t%.mha}.mha -p Parameters_Rigid_3D.txt -out ./temp/ -threads 4
	    s=${files[$j]##*/}
	    mv ./temp/result.0.mha ./results/${s%.mha}.mha
	    let i=i+1
	    let j=j+1
#	    done
   
rm -rf ./temp
echo 'DONE'
termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "$(($difftimelps / 60)) minutes and $(($difftimelps % 60)) seconds elapsed for Script Execution."
printf '\n'

exit 0  


#TO-DO
#- read filesize and adjust parameters accordingly
#- read filename and rename all results ( clip file extension via: f=$1 ; nm1=` basename $f | cut -d '.' -f 1 `)
#- make it batch-able
# apply SimpleImageReconstruction Step in the beginning