# This package contains the inversion code accompanying the manuscript : "Backfolded slab in the mantle transition zone as a melt source for Mariana petit-spot volcanism."

This package prepares travel-time data, traces seismic rays, computes finite-frequency sensitivity kernels, and performs damped and smoothed tomography inversion.

## Directories

```

"FFT_mariana_*": MCCC travel-time measurements from the PS, 1A, XF, XO, and YY networks.
"KERN_all": Processing scripts, compiled Linux programs, and a station list.

```

## Scripts in KERN_all/bash

```

place.sh                        Set the working directory name and station count.
1.1mk.evt.lst.SOD_PS4.sh        Select event files with at least five unique stations.
2.2setshoot_PS_SOD.sh           Prepare event, station, and observation files.
3.3shoot_SOD.sh                 Trace P-wave rays using the IASP91 reference model.
4.pltmesh.SOD.sh                Create the 3D inversion mesh and plot the mesh and stations.
5.5buildG.PS.SOD.sh             Build ray-based matrices and prepare kernel sampling locations.
6.6k27.P.SOD.sh                 Calculate finite-frequency sensitivity kernels for high-, intermediate- and low-frequency bands.
7.7addG_stacor.SOD.P.sh         Add correction terms to the kernel matrices.
8.8addG.SOD.PS.hml.sh           Combine the three frequency bands.
9.9run.G_single2list.sh         Split the combined matrix into observation files and create the inversion file list.
inv_make_smooth.m               Generate first- and second-order smoothing matrices.
11.11run.solver.pSOD.P.1th.sh   Filter data after an initial inversion, then run damping and smoothing combinations.

```

## Basic Use

From the package root, prepare the station list:

```bash
mkdir -p ALL/P_all
cp KERN_all/St_all.lst ALL/St_all.lst
cd KERN_all/bash
```

Run the numbered scripts in order using bash <script> .
