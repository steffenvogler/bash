#!/bin/sh

#Atlasing-Batch

##mkdir ./00_ManualInit_of_WHS_label
#transformix -in ./in/WHS_label.mha -out ./00_ManualInit_of_WHS_label/ -tp 00_TransformParameters_manual_initialization_From_WHS_label.txt -threads 4
transformix -in ./in/WHS_0.5_Labels.nii -out ./00_ManualInit_of_WHS_label/ -tp 00_TransformParameters_manual_initialization_From_WHS_label.txt -threads 4

##mkdir ./00_ManualInit_of_WHS_Scaled_label
transformix -in ./00_ManualInit_of_WHS_label/result.mhd -out ./00_ManualInit_of_WHS_Scaled_label/ -tp 00_TransformParameters_manual_initialization_Scaled.txt -threads 4

##mkdir ./00_ManualInit_of_WHS_Scaled_single_label
transformix -in ./00_ManualInit_of_WHS_Scaled_label/result.mhd -out ./00_ManualInit_of_WHS_Scaled_single_label/ -tp 00_TransformParameters_manual_initialization_Scaled_single.txt -threads 4

#mkdir ./01_AffineDTI
#elastix -m ./00_ManualInit_of_WHS_Scaled_single/result.mhd -f in/slide_78.mha -p 01_Parameters_Affine_DTI.txt -out ./01_AffineDTI/ -threads 4

#mkdir ./01_AffineDTI_Stack
##mkdir ./01_AffineDTI_Stack_label
#sed '15s/.*/(Origin 0.0 0.0 -50)/' ./01_AffineDTI/TransformParameters.0.txt > ./01_AffineDTI/TransformParameters_mod2.0.txt
#sed -i '12s/.*/(Size 1213 871 100)/' ./01_AffineDTI/TransformParameters_mod2.0.txt
#transformix -in ./00_ManualInit_of_WHS_Scaled/result.mhd -out ./01_AffineDTI_Stack/ -tp ./01_AffineDTI/TransformParameters_mod2.0.txt -threads 4
transformix -in ./00_ManualInit_of_WHS_Scaled_label/result.mhd -out ./01_AffineDTI_Stack_label/ -tp ./01_AffineDTI/TransformParameters_mod2_label.0.txt -threads 4

#mkdir ./02_BSpline
#elastix -m 01_AffineDTI_Stack/result.mhd -f in/slide_78.mha -p 02_Parameters_BSpline.txt -out ./02_BSpline/ 

#mkdir ./02_BSpline_Stack
##mkdir ./02_BSpline_Stack_label
#sed '15s/.*/(Origin 0.0 0.0 -50)/' ./02_BSpline/TransformParameters.0.txt > ./02_BSpline/TransformParameters_mod2.0.txt
#sed -i '12s/.*/(Size 1213 871 100)/' ./02_BSpline/TransformParameters_mod2.0.txt
#transformix -in ./01_AffineDTI_Stack/result.mhd -out ./02_BSpline_Stack/ -tp ./02_BSpline/TransformParameters_mod2.0.txt
transformix -in ./01_AffineDTI_Stack_label/result.mhd -out ./02_BSpline_Stack_label/ -tp ./02_BSpline/TransformParameters_mod3.0.txt

<<COMMENT
mkdir ./03_BSpline_Stack_Back_To_AffineDTI
elastix -m 02_BSpline/result.0.mhd -f 01_AffineDTI/result.0.mhd -p 03_Parameters_BSpline_back.txt -out ./03_BSpline_Stack_Back_To_AffineDTI/ 
mkdir ./03_BSpline_Stack_Back_To_AffineDTI_Slice
transformix -in ./in/slide_78.mha -out ./03_BSpline_Stack_Back_To_AffineDTI_Slice/ -tp ./03_BSpline_Stack_Back_To_AffineDTI/TransformParameters.0.txt -threads 4

mkdir ./04_AffineDTI_Back_To_ManualInit
elastix -m ./01_AffineDTI_Stack/result.mhd -f ./00_ManualInit_of_WHS_Scaled_single/result.mhd -p 04_Parameters_Affine_DTI_back.txt -out ./04_AffineDTI_Back_To_ManualInit/
mkdir ./04_AffineDTI_Back_To_ManualInit_Slice
sed '12s/.*/(Size 512 512 1)/' ./04_AffineDTI_Back_To_ManualInit/TransformParameters.0.txt  > ./04_AffineDTI_Back_To_ManualInit/TransformParameters_mod.0.txt
sed -i '15s/.*/(Origin 0.0 0.0 0)/' ./04_AffineDTI_Back_To_ManualInit/TransformParameters_mod.0.txt 
transformix -in ./03_BSpline_Stack_Back_To_AffineDTI_Slice/result.mhd -out ./04_AffineDTI_Back_To_ManualInit_Slice/ -tp ./04_AffineDTI_Back_To_ManualInit/TransformParameters.0.txt -threads 4

mkdir ./05_ManualInit_Descale
transformix -in ./04_AffineDTI_Back_To_ManualInit_Slice/result.mhd -out ./05_ManualInit_Descale/ -tp 05_TransformParameters_manual_descale.txt  -threads 4

mkdir ./06_ManualInit_Reorient
transformix -in ./05_ManualInit_Descale/result.mhd -out ./06_ManualInit_Reorient/ -tp 06_TransformParameters_manual_reorient.txt  -threads 4

COMMENT

exit 0   


#TO-DO
#- read filesize and adjust parameters accordingly
#- read filename and rename all results ( clip file extension via: f=$1 ; nm1=` basename $f | cut -d '.' -f 1 `)
#- make it batch-able
# apply SimpleImageReconstruction Step in the beginning