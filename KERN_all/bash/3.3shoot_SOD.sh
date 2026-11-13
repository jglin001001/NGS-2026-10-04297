#!/bin/bash
mdl=iasp
region=SOD
kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`
source place.sh

for im in `echo -4`
do
  for PH in `echo P`
  do
    if [ $PH == "P" ];then
      phase=1
    elif [ $PH == "S" ];then
      phase=21
    fi
    for freq in `echo h m l`
    do
        EVT=$workpace/$place/"$PH"_all/$PH.$freq.$region.evtlst
$workpace/KERN_all/bin/shootray_evt_stibet04 <<EOF
1
$im
$phase
1000. 0.
10. 5. .5
500
1, 1
1.0e-10, 0.5
1.
1
$EVT
EOF
      mv shootrays.bp.$PH $workpace/$place/"$PH"_all/shootrays.bp.$PH.$freq.$region.$mdl
      mv shootrays.$PH  $workpace/$place/"$PH"_all/shootrays.$PH.$freq.$region.$mdl
    done
  done
done
