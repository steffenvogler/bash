#!/bin/sh

#Atlasing-Batch

mkdir ./00_ManualInit_from_WHS
transformix -in ./in/canon_T1_r_orig.mha -out ./00_ManualInit_from_WHS/ -tp 00_TransformParameters_manual_initialization_From_WHS.txt -threads 4

#mkdir ./01_AffineDTI
#elastix -m ./00_ManualInit/result.mhd -f in/slide_78.mha -p 02_Parameters_Affine_DTI.txt -out ./01_AffineDTI/ -threads 4

#mkdir ./01_AffineDTI_Stack
#sed '15s/.*/(Origin 0.0 0.0 -16.0)/' ./01_AffineDTI/TransformParameters.0.txt > ./01_AffineDTI/TransformParameters_mod2.0.txt
#sed -i '12s/.*/(Size 1213 871 32)/' ./01_AffineDTI/TransformParameters_mod2.0.txt
#transformix -in ./00_ManualInit/result.mhd -out ./01_AffineDTI_Stack/ -tp ./01_AffineDTI/TransformParameters_mod2.0.txt -threads 4

#mkdir ./02_BSpline
#elastix -m 01_AffineDTI_Stack/result.mhd -f in/slide_78.mha -p 04_Parameters_BSpline.txt -out ./02_BSpline/ 

#mkdir ./02_BSpline_Stack
#sed '15s/.*/(Origin 0.0 0.0 -16.0)/' ./02_BSpline/TransformParameters.0.txt > ./02_BSpline/TransformParameters_mod2.0.txt
#sed -i '12s/.*/(Size 1213 871 32)/' ./02_BSpline/TransformParameters_mod2.0.txt
#transformix -in ./01_AffineDTI_Stack/result.mhd -out ./02_BSpline_Stack/ -tp ./02_BSpline/TransformParameters_mod2.0.txt

#mkdir ./03_BSpline_Stack_Back_To_AffineDTI
#elastix -m 02_BSpline_Stack/result.mhd -f 01_AffineDTI/result.0.mhd -p 04_Parameters_BSpline_2.txt -out ./03_BSpline_Stack_Back_To_AffineDTI/ 

#mkdir ./03_BSpline_Stack_Back_To_AffineDTI_Slide78
#transformix -in in/slide_78.mha -out ./03_BSpline_Stack_Back_To_AffineDTI_Slide78/ -tp ./03_BSpline_Stack_Back_To_AffineDTI/TransformParameters_mod.0.txt -threads 4

#mkdir ./01_AffineDTI_Stack_Back_To_ManualInit
#elastix -m ./01_AffineDTI_Stack/result.mhd -f ./00_ManualInit/result.mhd -p 02_Parameters_Affine_DTI_2.txt -out ./01_AffineDTI_Stack_Back_To_ManualInit/

#mkdir ./01_AffineDTI_Inverse_Mov
#sed '12s/.*/(Size 1024 1024 200)/' ./01_AffineDTI_Stack_Back_To_ManualInit/TransformParameters.0.txt  > ./01_AffineDTI_Stack_Back_To_ManualInit/TransformParameters_mod.0.txt
#sed -i '14s/.*/(Spacing 1.0000000000 1.0000000000 1.0000000000)/' ./01_AffineDTI_Stack_Back_To_ManualInit/TransformParameters_mod.0.txt  
#transformix -in ./03_BSpline_Stack_Back_To_AffineDTI_Slide78/result.mhd -out ./01_AffineDTI_Inverse_Mov/ -tp ./01_AffineDTI_Stack_Back_To_ManualInit/TransformParameters_mod.0.txt -threads 4

#mkdir ./00_ManualInit_Inverse
#transformix -in ./01_AffineDTI_Inverse_Mov/result.mhd -out ./00_ManualInit_Inverse -tp 00_TransformParameters_manual_initialization_inverse.txt

exit 0   


#TO-DO
#- read filesize and adjust parameters accordingly
#- read filename and rename all results ( clip file extension via: f=$1 ; nm1=` basename $f | cut -d '.' -f 1 `)
#- make it batch-able
# apply SimpleImageReconstruction Step in the beginning