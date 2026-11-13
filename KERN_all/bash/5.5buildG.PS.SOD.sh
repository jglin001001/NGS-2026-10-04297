#!/bin/bash
kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`
source place.sh 
mdl=iasp

for PHASE in `echo P`
do
  workdir=$workpace/$place/"$PHASE"_all
  for freq in `echo h m l `
  do
    PH=$PHASE.$freq.SOD
    rayfile=$workdir/shootrays.$PH.$mdl
    datstafile=$workdir/$PH.datsta

$workpace/KERN_all/bin/buildG.new.osr <<EOF
$PHASE
$rayfile
$datstafile
0
EOF
  mv G_ray_d_$PHASE $workdir/G_ray_d_$PH.$mdl
  mv Kernel.pos_$PHASE $workdir/K_pos_$PH.$mdl
  mv Ray.summary_$PHASE $workdir/Ray.summary.$PH.$mdl
  done
done
