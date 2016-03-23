#!/bin/bash

#Atlasing-Batch

#mkdir ./00_ManualInit_of_WHS
#transformix -in ./in/canon_T1_r_orig.mha -out ./00_ManualInit_of_WHS/ -tp 00_TransformParameters_manual_initialization_From_WHS.txt -threads 4

#mkdir ./00_ManualInit_microscope_APAdjust
#transformix -in ./in/0015_ch1_8bit_mm.mha -out ./00_ManualInit_microscope_APAdjust/ -tp 00_TransformParameters_manual_initialization_Microscope_APAdjust.txt -threads 4

#mkdir ./01_AffineDTI
#elastix -m ./00_ManualInit_of_WHS/result_cropped.mha -f ./00_ManualInit_microscope_APAdjust/result.mhd -p 01_Parameters_Affine_DTI.txt -t0 Init_Transform_Rigid3D.txt -mMask ./00_ManualInit_of_WHS_mask/left_hemisphere_mask_binary.mha -out ./01_AffineDTI/ -threads 4

#mkdir ./01_AffineDTI_init
#elastix -m ./00_ManualInit_of_WHS/result_cropped.mha -f ./00_ManualInit_microscope_APAdjust/result.mhd -p 01_Parameters_Affine_DTI_init.txt -t0 Init_Transform_Rigid3D.txt -out ./01_AffineDTI_init/ -threads 4

#mkdir ./01_AffineDTI
#elastix -m ./00_ManualInit_of_WHS/result_cropped.mha -f ./00_ManualInit_microscope_APAdjust/result.mhd -p 01_Parameters_Affine_DTI.txt -out ./01_AffineDTI/ -threads 4
#elastix -m ./01_AffineDTI_init/result.0.mhd -f ./00_ManualInit_microscope_APAdjust/result.mhd -p 01_Parameters_Affine_DTI.txt -out ./01_AffineDTI/ -threads 4


#mkdir ./01_AffineDTI_Stack
#sed '15s/.*/(Origin 0.0 0.0 0.6875)/' ./01_AffineDTI/TransformParameters.0.txt > ./01_AffineDTI/TransformParameters_mod2.0.txt
#sed -i '12s/.*/(Size 4266 3948 100)/' ./01_AffineDTI/TransformParameters_mod2.0.txt
#sed -i '4s/.*/(InitialTransformParametersFileName "./Init_Transform_Rigid3D.txt")/' ./01_AffineDTI/TransformParameters_mod2.0.txt
#transformix -in ./00_ManualInit_of_WHS/result_cropped.mha -out ./01_AffineDTI_Stack/ -tp ./01_AffineDTI/TransformParameters_mod2.0.txt -threads 4
#####SOME ERROR HERE - ORIGINAL WHS HAS DIFFERENT RESOLUTION THAN MICROSCOPY IMAGE###

#mkdir ./02_BSpline
elastix -m 01_AffineDTI/result.0.mhd -f ./00_ManualInit_microscope_APAdjust/result.mhd -p 02_Parameters_BSpline_workinprogress.txt -out ./02_BSpline/ -threads 4

<<'TEST'
mkdir ./02_BSpline_Stack

sed '15s/.*/(Origin 0.0 0.0 -50)/' ./02_BSpline/TransformParameters.0.txt > ./02_BSpline/TransformParameters_mod2.0.txt
sed -i '12s/.*/(Size 1213 871 100)/' ./02_BSpline/TransformParameters_mod2.0.txt
transformix -in ./01_AffineDTI_Stack/result.mhd -out ./02_BSpline_Stack/ -tp ./02_BSpline/TransformParameters_mod2.0.txt

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
TEST
exit 0   


#MASK:
#c3d -create 256x1024x512 0.0215x0.0215x0.0215mm -origin 10.9005x11.997x-5.5255mm -orient LPI -o right_hemisphere_mask.mha
#c3d -create 256x1024x512 0.0215x0.0215x0.0215mm -origin 5.3965x11.997x-5.5255mm -orient LPI -o left_hemisphere_mask.mha

#TO-DO
#- read filesize and adjust parameters accordingly
#- read filename and rename all results ( clip file extension via: f=$1 ; nm1=` basename $f | cut -d '.' -f 1 `)
#- make it batch-able
# apply SimpleImageReconstruction Step in the beginning