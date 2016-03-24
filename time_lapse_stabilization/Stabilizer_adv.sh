#!/bin/bash
 
#Atlasing-Util
 
begin=$(date +"%s")
 
#Registration is performed only on Ch1; Ch2 is corrected than accordingly
folder='./output_ch1/'
folder2='./output_ch2/'
#folder='./Cells/'
ext_in=tiff
ext_out=bmp
parameters_file=Parameters_Rigid.txt
 

i=1
j=2
files=(ls $folder*)
#files=(ls -v $folder*|sort -V)
files2=(ls $folder2*)
echo "${files[$i]}"
echo "${files[$j]}"
 
count=$(ls $folder | wc -l)
#count=10
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
        sed -i '29s/.*/(ResultImageFormat "bmp")/' ./outdir$i$j/TransformParameters.0.txt 
        sed -i '30s/.*/(ResultImagePixelType "unsigned char")/' ./outdir$i$j/TransformParameters.0.txt 
        let i=i+1
        let j=j+1
        let k=k+1
        let l=l+1
        done
 
        
i=1
j=2
mkdir ./results/
mkdir ./results/ch1
mkdir ./results/ch2
while [ $i -lt $count ]; do
        #echo item: ${files[$i]} plus ${files[$j]}
        #transformix -in ${files[$j]} -tp ./outdir$i$j/TransformParameters.0.txt -out ./results/ -threads 4 -def all
        transformix -in ${files[$j]} -tp ./outdir$i$j/TransformParameters.0.txt -out ./results/ch1/ -threads 4 
        s=${files[$j]##*/}
        mv ./results/ch1/result.$ext_out ./results/ch1/${s%.$ext_in}.$ext_out
        transformix -in ${files2[$j]} -tp ./outdir$i$j/TransformParameters.0.txt -out ./results/ch2/ -threads 4 
        t=${files2[$j]##*/}
        mv ./results/ch2/result.$ext_out ./results/ch2/${t%.$ext_in}.$ext_out
        #mv ./results/deformationField.mhd ./results/deformationField/deformationField_${s%.$ext_in}.mhd
        #sed -i '14s/.*/(ElementDataFile = deformationField_'${s%.$ext_in}'.raw/' ./results/deformationField/deformationField_${s%.$ext_in}.mhd
        #mv ./results/deformationField.raw ./results/deformationField/deformationField_${s%.$ext_in}.raw
        #transformix -in ${files2[$j]} -tp ./outdir$i$j/TransformParameters.0.txt -out ./results/ -threads 4 -def all
        #t=${files2[$j]##*/}
        #mv ./results/result.$ext_out ./results/${s%.$ext_in}.$ext_out
        #mv ./results/deformationField.$ext_out ./results/deformationField_${t%.$ext_in}.$ext_out
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