#!/bin/bash
kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`
source place.sh 
area=SOD

for PH in `echo P`
do
  filedir=$workpace/$place/"$PH"_all
  cp mesh.config $filedir
  cd $filedir
  echo "0" > nevent.lst

  echo "  104  0" > nstation.lst
  cat nstation.lst
  for freq in `echo h m l`
  do
    if [ $freq = l ];then
      ceo_freq=1
    elif [ $freq = m ];then
      ceo_freq=1
    elif [ $freq = h ];then
      ceo_freq=1
    fi
   echo $ceo_freq
$workpace/KERN_all/bin/addG_stacor<<EOF
$ceo_freq
$workpace/$place/P_all/$PH.$freq.$area.stacor
$workpace/$place/P_all/$PH.$freq.$area.datsta
$workpace/$place/P_all/G_kernel_d_$PH.$freq.$area.iasp
EOF
  done
done


