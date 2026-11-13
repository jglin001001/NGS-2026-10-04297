#!/bin/bash

kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`
area=SOD
mdl=iasp
source place.sh 
for PH in `echo P`
do
   workdir=$workpace/$place/"$PH"_all
   cd $workdir
$workpace/KERN_all/bin/addG_d <<EOF
$station_numbers
G_kernel_d_stacor_$PH.h.$area.$mdl
G_kernel_d_stacor_$PH.m.$area.$mdl
G_kernel_d_stacor_$PH.l.$area.$mdl
none
EOF

/bin/mv G_d_add G_kernel_d_sc_$PH.hml.$area.$mdl

done
