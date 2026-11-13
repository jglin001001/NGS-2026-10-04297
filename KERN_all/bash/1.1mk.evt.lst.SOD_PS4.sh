#!/bin/bash

kkk=`pwd`
workpace=`echo ${kkk%/KERN_all*}`

source place.sh
workdir=$workpace/$place

if [ ! -e "$workdir/P_all" ]; then
  mkdir -p "$workdir/P_all"
fi

for freq in h m l
do
  list=$workdir/P_all/P.$freq.SOD.evts.lst
  > "$list"
done

for net in PS 1A XF XO YY
do
  echo "Network: $net"

  for freq in h m l
  do
    mcccdir=../../FFT_mariana_${net}/${net}/sliced/DATA/var4
    dir=$mcccdir/*.phase.$freq
    list=$workdir/P_all/P.$freq.SOD.evts.lst

    case "$freq" in
      h|m)
        ccmin=0.60
        ;;
      l)
        ccmin=0.60
        ;;
      *)
        echo "  Unknown freq: $freq"
        continue
        ;;
    esac

    if ! ls $dir >/dev/null 2>&1; then
      echo "  No directory: $dir"
      continue
    fi

    for vkfile in $dir/*.vk
    do
      if [ ! -e "$vkfile" ]; then
        continue
      fi

      # total unique station number in the vk file
      total_obs=`awk '
        $1 ~ /^[A-Za-z0-9]+[.][A-Za-z0-9]+$/ {
          sta[$1]=1
        }
        END {
          print length(sta)
        }
      ' "$vkfile"`

      good_obs=`awk -v ccmin="$ccmin" '
        $1 ~ /^[A-Za-z0-9]+[.][A-Za-z0-9]+$/ && ($4+0) > ccmin {
          sta[$1]=1
        }
        END {
          print length(sta)
        }
      ' "$vkfile"`

      echo "  freq=$freq cc>$ccmin good/total=${good_obs}/${total_obs}: $vkfile"

      if [ "$good_obs" -gt 4 ]; then
        echo "$vkfile" >> "$list"
      fi

    done
  done
done
