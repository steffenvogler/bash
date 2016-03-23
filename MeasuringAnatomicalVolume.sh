#!/bin/bash

xcoord=$1
ycoord=$2
zcoord=$3


#probe at distinct POI
anatomy_ID=$(c3d ./result.mhd -probe $1x$2x$3vox)
reg_exp='is[[:space:]](.*)'
[[ $anatomy_ID =~ $reg_exp ]]
clean_anatomy_ID=${BASH_REMATCH[1]}
echo "Anatomy_ID: "$clean_anatomy_ID
# E.g.: Output will be "8" ... according to "WHS_0.5.1_Labels.ilf" this is the hippocampal formation
anatomy=$(xmllint --xpath 'string(//label[@id='$clean_anatomy_ID']/@name)' ../WHS_0.5.1_Labels.ilf)
echo $anatomy
#Threshold for Intensity-value=8
c3d result.mhd -threshold $clean_anatomy_ID $clean_anatomy_ID 1 0 -type short -spacing 0.0215x0.0215x0.0215mm -o Threshold.nii
sed -i '10s/.*/ElementSpacing = 0.0215 0.0215 0.0215/' ./Threshold.nii
#Output is a binary image with only the hippocampal formation
#Try to estimate volume now
volume=$(c3d Threshold.nii -voxel-integral)
reg_exp2='l:[[:space:]](.*)'
[[ $volume =~ $reg_exp2 ]]
clean_volume=${BASH_REMATCH[1]}
echo "The volume of "$anatomy" is "$clean_volume" ul."