#!/bin/bash
kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`
source place.sh 
workdir=$workpace/$place/P_all
codedir=$workpace/KERN_all

outdir="result.2th_P_all"
fnm_smooth='SOD.55x33x31.smooth2th.dat'

cp $fnm_smooth $workdir
cd $workdir
list_Gd="inv_Gd_list_P"
damp_list="20 18 14 12 10 9 8 7 6 5"
smot_list="20 16 12"
weigst_list="1"
weigev_list="1"
nst=2
nev=1
nlo=0
num_cmp=1
ker_thres="1e-3"
data_thres=20

SOLVER="$codedir/bin/"'solver_damp_smooth'
echo $SOLVER
if [ ! -d $outdir ]; then
   mkdir -p $outdir
fi

function inv_compile {
  FC=ifort
  SRC='$codedir/codes/INV'
  echo "$FC -O3 -o $SOLVER $SRC/mod_LSQR.f90 $SRC/solver_damp_smooth.f90"
  $FC -O3 -o $SOLVER $SRC/mod_LSQR.f90 $SRC/solver_damp_smooth.f90
}

# ----------------------------------------------------------------------
$SOLVER << EOF
1
20 0
$num_cmp
$nst 0
$nev 0
$list_Gd
$fnm_smooth
$ker_thres $data_thres
EOF

cat try.mis | awk '{if($2>-0.6 && $2<0.6) printf("%7i\n"),$1}' > temp

cp /dev/null ./list.txt
for num in `cat temp`;do
  sed -n "$num"p $list_Gd >> ./list.txt
done

function inv_loop {
  for weig_st in ${weigst_list}; do
  for weig_ev in ${weigev_list}; do
  for smot in ${smot_list}; do
  for damp in ${damp_list}; do
  echo "st ev smooth damp=" $weig_st $weig_ev $smot $damp

$SOLVER << EOF
1
$damp $smot
$num_cmp
$nst $weig_st
$nev $weig_ev
list.txt
$fnm_smooth
$ker_thres $data_thres
EOF


  mv try.xyz $outdir/try.damp${damp}.smot${smot}.st${weig_st}.ev${weig_ev}.dat
  mv try.sum $outdir/sum.damp${damp}.smot${smot}.st${weig_st}.ev${weig_ev}.dat
  mv try.err $outdir/err.damp${damp}.smot${smot}.st${weig_st}.ev${weig_ev}.dat
  mv try.sta $outdir/sta.damp${damp}.smot${smot}.st${weig_st}.ev${weig_ev}.dat
  mv try.evt $outdir/evt.damp${damp}.smot${smot}.st${weig_st}.ev${weig_ev}.dat
  mv try.mis $outdir/mis.damp${damp}.smot${smot}.st${weig_st}.ev${weig_ev}.dat
  done
  done
  done
  done
}

echo ""
echo "solving with different daming ..."
time inv_loop;
