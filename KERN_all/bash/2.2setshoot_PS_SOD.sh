#!/bin/bash
region=SOD
kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`
source place.sh
stnlst=$workpace/$place/St_all.lst
codedir=$workpace/KERN_all/bin
for PH in `echo P`
do
  echo $PH
  workdir=$workpace/$place/"$PH"_all
  cd $workdir
  cp $stnlst ./
$codedir/setshoot_tt2 <<EOF
St_all.lst
$PH.l.$region.evts.lst
$PH.m.$region.evts.lst
$PH.h.$region.evts.lst
$PH.l.$region.info
$PH.m.$region.info
$PH.h.$region.info
$PH.all.$region.info
$PH.l.$region.evtlst
$PH.m.$region.evtlst
$PH.h.$region.evtlst
$PH.all.$region.evtlst
$PH.l.$region.stacor
$PH.m.$region.stacor
$PH.h.$region.stacor
$PH.all.$region.stacor
$PH.l.$region.datsta
$PH.m.$region.datsta
$PH.h.$region.datsta
$PH.all.$region.datsta
EOF

done
