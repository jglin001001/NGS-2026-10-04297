#!/bin/bash
kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`
source place.sh 
mdl=iasp
area=SOD
for PH in `echo P`
do
  if [ $PH = "P" ];then
    phase=1
  elif [ $PH = "S" ];then
    phase=21
  fi
  for freq in `echo l m h`
  do
    if [ $freq = "l" ];then
      w1=0.03
      w2=0.1
    elif [ $freq = "m" ];then
      w1=0.1
      w2=0.5
    elif [ $freq = "h" ];then
      w1=0.5
      w2=2
    fi
    echo $w1 $w2

../bin/kernbg27_osref << EOF
1
-4
$phase
20. 10.
20., 5., .5
500
4 1
$w1 $w2
$workpace/KERN_all/asc/pulse.$PH.$freq.am.asc
1
$workpace/$place/P_all/K_pos_$PH.$freq.$area.$mdl
EOF

    workdir=$workpace/$place/"$PH"_all
    mv kobs.iasp."$PH"_G_kernel $workdir/G_kernel_$PH.$freq.$area.$mdl
    mv kobs.iasp."$PH"_G_kernel_d $workdir/G_kernel_d_$PH.$freq.$area.$mdl
    mv kobs.iasp."$PH"_G_kernel_ref $workdir/G_kernel_ref_$PH.$freq.$area.$mdl
    mv kobs.iasp."$PH"_G_kernel_d_ref $workdir/G_kernel_d_ref_$PH.$freq.$area.$mdl
  done
done
