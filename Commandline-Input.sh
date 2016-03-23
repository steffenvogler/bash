#!/bin/sh
#Mosaic-Batch

#mkdir ./01_ManualInit+AffineDTI_SingleSlide
#elastix -m in/canon_T1_r_full.mha -f in/slide_78.mha -p 02_Parameters_Affine_DTI.txt -out ./out/ -t0 01_TransformParameters_manual_initialization.txt 
#mkdir ./01_ManualInit+AffineDTI_Stack
#############Change TansformParameter.0.txt to fit new stack size##############COMMAND TO OPEN, MODIFY AND SAVE sed '2 s/elit/newline text/' text1.txt > new_file.txt##########
sed '12 s/32/34/;15 s/.*/(Origin 0.0 0.0 -17.0)/' ./out/TransformParameters.0.txt > ./out/TransformParameters_mod.0.txt
#sed '12 s/32/34/' ./out/TransformParameters.0.txt > ./out/TransformParameters_mod.0.txt
#transformix -in ./in/canon_T1_r_full.mha -out ./01_ManualInit+AffineDTI_Stack/ -tp ./out/TransformParameters.0.txt
#mkdir ./02_BSpline_SingleSlide
#elastix -m 01_ManualInit+AffineDTI_Stack/result.mhd -f in/slide_78.mha -p 04_Parameters_BSpline.txt -out ./02_BSpline_SingleSlide/ 
#############Change TansformParameter.0.txt to fit new stack size##############
#mkdir ./02_BSpline_Stack
#transformix -in ./01_ManualInit+AffineDTI_Stack/result.mhd -out ./02_BSpline_Stack/ -tp ./02_BSpline_SingleSlide/TransformParameters.0.txt

#############Starting Inverse Transformation###################################

#mkdir ./03_BSpline_Stack_Inverse
##########Change 05b_TransformParameters_new_inv2.0.txt ONLY here (LINE 4 or 5): (InitialTransformParametersFileName "./04_elastix_bspline/TransformParameters.0.txt") REPLACE WITH: (InitialTransformParametersFileName "./02_BSpline_SingleSlide/TransformParameters.0.txt")
#elastix -f 02_BSpline_Stack/result.mhd -m 02_BSpline_Stack/result.mhd -out 03_BSpline_Stack_Inverse/ -t0 05b_TransformParameters_new_inv2.0.txt -p 05b_Parameters_Inverse.txt 



exit 0        