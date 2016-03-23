#!/bin/bash
 
#Atlasing-Util
 
begin=$(date +"%s")
 
 
folder='./for_Steffi_8bit/'
#folder='./Cells/'
ext_in=tif
ext_out=mha
parameters_file=Parameters_Rigid.txt
 
 
 
 
i=1
j=2
files=(ls $folder*)
echo "${files[$i]}"
echo "${files[$j]}"
 
count=$(ls $folder | wc -l)
#count=2
echo $count
 
while [ $i -lt $count ]; do
        echo item: ${files[$i]} plus ${files[$j]}
        mkdir -p ./outdir$i$j
        elastix -f ${files[$i]} -m ${files[$j]} -p $parameters_file -out ./outdir$i$j -threads 4
        let i=i+1
        let j=j+1
        done
     
i=2
j=3
k=1
l=2
while [ $i -lt $count ]; do
        echo item: ${files[$i]} plus ${files[$j]}
        sed -i '4s/.*/(InitialTransformParametersFileName ".\/outdir'$k$l'\/TransformParameters.0.txt")/' ./outdir$i$j/TransformParameters.0.txt 
        let i=i+1
        let j=j+1
        let k=k+1
        let l=l+1
        done
 
        
i=1
j=2
mkdir ./results/
while [ $i -lt $count ]; do
        #echo item: ${files[$i]} plus ${files[$j]}
        transformix -in ${files[$j]} -tp ./outdir$i$j/TransformParameters.0.txt -out ./results/ -threads 4 -def all
        s=${files[$j]##*/}
        #mv ./results/result.$ext_out ./results/${s%.$ext_in}.$ext_out
        mv ./results/deformationField.$ext_out ./results/deformationField_${s%.$ext_in}.$ext_out
        let i=i+1
        let j=j+1
        done   
 
 
i=1
j=2
while [ $i -lt $count ]; do
        rm -rf ./outdir$i$j
        let i=i+1
        let j=j+1
        done
 
 
#s=${files[1]##*/}
#cp ${files[1]} ./results/${s%.$ext_in}.$ext_out
 
echo 'DONE'
termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "$(($difftimelps / 60)) minutes and $(($difftimelps % 60)) seconds elapsed for Script Execution."
printf '\n'
 
exit 0  