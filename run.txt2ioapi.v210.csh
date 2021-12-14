#! /bin/csh -f
## Common setups
setenv PROMPTFLAG N

set ddom = d01
set wdir = /home/maggieooi/MEGAN/MEGANv2.10
set idir = /home/maggieooi/MEGAN/MEGANv2.10/Input
set bdir = /home/maggieooi/MEGAN/MEGANv2.10/bin
## File setups
## Inputs
setenv EFSTXTF ${idir}/EF210_mSEA_${ddom}.csv
setenv PFTTXTF ${idir}/PFT210_mSEA_${ddom}.csv
setenv LAITXTF ${idir}/LAI210_mSEA_${ddom}.csv
setenv GRIDDESC ${idir}/GRIDDESC
setenv GDNAM3D 201611${ddom}

## Outputs
setenv EFMAPS  ${idir}/EFMAPS.mSEA.${ddom}.ncf
setenv PFTS16  ${idir}/PFTS16.mSEA.${ddom}.ncf
setenv LAIS46  ${idir}/LAIS46.mSEA.${ddom}.ncf

## Run control
setenv RUN_EFS T       # [T|F]
setenv RUN_LAI T       # [T|F]
setenv RUN_PFT T       # [T|F]

## Run TXT2IOAPI
rm -f $EFMAPS $LAIS46 $PFTS16
${bdir}/txt2ioapi | tee ${wdir}/log.txt2ioapi.${ddom}.txt
