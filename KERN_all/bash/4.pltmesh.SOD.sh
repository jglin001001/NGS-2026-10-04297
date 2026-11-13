#!/bin/bash
RANGE=135/167/7/25
latc=16
lonc=151

dlat=8
dlon=13.5
ddep=900
ddep0=0.0

../bin/mesh_car<<EOF
55 33 31
$lonc $latc
$dlon $dlat $ddep $ddep0
EOF

cpt=geo
gmt begin mesh.SOD.ps
    gmt grdimage @earth_relief_15s -JM20c -R$RANGE -Baf -C$cpt -I+d
    gmt plot mesh.plot -W1p,13
    echo 143 14.35 152 20.5 | gmt plot -Sr+s -W2p,238/99/99
    cat ../../ALL/St_all.lst | awk '{print $4, $3}' | gmt plot -St0.3c -W1.2p,black -Gred
gmt end show    
