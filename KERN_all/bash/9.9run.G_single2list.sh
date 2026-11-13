#!/bin/bash

kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`
source place.sh 
for PH in `echo P`
do
  outdir="G_spool_$PH"
  workdir=$workpace/$place/"$PH"_all
  cd $workdir
  if [ ! -d $outdir ]; then
     mkdir -p $outdir
  fi
  
  list_Gd="inv_Gd_list_"$PH""
  weig_dat="1"
  ker_thres="1e-9"
  kernal=G_kernel_d_sc_"$PH".hml.SOD.iasp

$workpace/KERN_all/bin/G_single2list << EOF
$kernal
$list_Gd
$outdir
$weig_dat
$ker_thres
EOF

done
