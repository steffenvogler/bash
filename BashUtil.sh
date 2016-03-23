#!/bin/bash

#Atlasing-Util

begin=$(date +"%s")

<<COMMENT
COMMENT
#sleep 1

atlas='canon_T1_r_orig.mha'
own='slide_78.mha'

echo "spec's of atlas"
atlas_elem_spacing=$(sed -n '/^ElementSpacing/p' $atlas)
pattern='([[:alpha:]]*) = ([[:digit:].]*) ([[:digit:].]*) ([[:digit:].]*)'
[[ $atlas_elem_spacing =~ $pattern ]] 
atlas_x_res=${BASH_REMATCH[2]}
atlas_y_res=${BASH_REMATCH[3]}
atlas_z_res=${BASH_REMATCH[4]}
echo $atlas_elem_spacing
echo $atlas_x_res
echo $atlas_y_res
echo $atlas_z_res

atlas_xyz_dim=$(sed -n '/^DimSize/p' $atlas)
pattern='([[:alpha:]]*) = ([[:digit:].]*) ([[:digit:].]*) ([[:digit:].]*)'
[[ $atlas_xyz_dim =~ $pattern ]] 
atlas_x_dim=${BASH_REMATCH[2]}
atlas_y_dim=${BASH_REMATCH[3]}
atlas_z_dim=${BASH_REMATCH[4]}
echo $atlas_xyz_dim
echo $atlas_x_dim
echo $atlas_y_dim
echo $atlas_z_dim


printf '\n'
echo "spec's of own"
own_elem_spacing=$(sed -n '/^ElementSpacing/p' $own)
pattern='([[:alpha:]]*) = ([[:digit:].]*) ([[:digit:].]*) ([[:digit:].]*)'
[[ $own_elem_spacing =~ $pattern ]] 
own_x_res=${BASH_REMATCH[2]}
own_y_res=${BASH_REMATCH[3]}
own_z_res=${BASH_REMATCH[4]}
echo $own_elem_spacing
echo $own_x_res
echo $own_y_res
echo $own_z_res

own_xyz_dim=$(sed -n '/^DimSize/p' $own)
pattern2='([[:alpha:]]*) = ([[:digit:].]*) ([[:digit:].]*) ([[:digit:].]*)'
[[ $own_xyz_dim =~ $pattern2 ]] 
own_x_dim=${BASH_REMATCH[2]}
own_y_dim=${BASH_REMATCH[3]}
own_z_dim=${BASH_REMATCH[4]}
echo $own_xyz_dim
echo $own_x_dim
echo $own_y_dim
echo $own_z_dim

printf '\n'


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