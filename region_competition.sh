#the flag --mcmc 1 enables DRS mode (discrete region sampling instead of region competition) - doesn't work for some reason   
#../itk/RegionCompetition_MOSAIC/bin/RegionCompetition ../data/segment.mhd_adjcont_nlm_bgsub.mhd --mcmc 1 --output ../data/segment.mhd_rc.mhd --init_mode blob_det --init_blob_min 8 --init_blob_max 40 


STARTTIME=$(date +%s)
#for filename in ../data/AntiGFP_cropped/*; do
#name=${filename##*/}
#../itk/RegionCompetition_MOSAIC/bin/RegionCompetition ../data/AntiGFP_cropped/$name --output ../data/RC_results_GFP_crop/$name.mhd -i 50 --init_mode blob_det --init_blob_min 8 --init_blob_max 30  --energy psPoisson -r 4 --data 1.0 --internal curv -l 0.2 -b 0.02 -t 0.001
#echo $name
#done
ImageJ-linux64 -macro analyze.ijm /home/ip-linux/Documents/CellDetection/Counting_Party/data/RC_results_GFP_crop/&
STOPTIME=$(date +%s)
diff=$(($STOPTIME-$STARTTIME))
echo "It takes $(($diff/60)) minutes to complete the task..." > computation_RC.txt 2>&1