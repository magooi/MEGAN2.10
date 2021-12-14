#! /bin/csh -f

setenv reg mSEA
setenv PROMPTFLAG N
set ddom = d01

set wdir = /home/maggieooi/MEGAN/MEGANv2.10
set idir = /home/maggieooi/MEGAN/MEGANv2.10/Input
set odir = /home/maggieooi/MEGAN/MEGANv2.10/Output
set bdir = /home/maggieooi/MEGAN/MEGANv2.10/bin

setenv INPDIR $idir           # Input map data directory
setenv METDIR $idir           # MCIP input directory
setenv INTDIR $idir           # Intermediate file directory
setenv OUTDIR $odir           # Output directory
setenv GRIDDESC ${idir}/GRIDDESC
setenv GDNAM3D 201611${ddom}

set JD = 2016325
setenv SDATE ${JD}        #start date
setenv STIME 0
setenv RLENG 240000
setenv TSTEP 10000

setenv RUN_SPECIATE   Y    # run MG2MECH
setenv RUN_CONVERSION Y    # run conversions?
                           # run conversions MEGAN to model mechanism
                           # units are mole/s
setenv SPCTONHR       N    # speciation output unit in tonnes per hour
                           # This will convert 138 species to tonne per
                           # hour or mechasnim species to tonne per hour.

setenv MECHANISM    CB05

setenv EFMAPS  $INPDIR/EFMAPS.${reg}.${ddom}.ncf
setenv PFTS16  $INPDIR/PFTS16.${reg}.${ddom}.ncf
setenv LAIS46  $INPDIR/LAIS46.${reg}.${ddom}.ncf
setenv MGNERS  $INPDIR/ER.$reg.${SDATE}.${ddom}.ncf
setenv MGNOUT  $OUTDIR/MEGANv2.10.$reg.${MECHANISM}.${SDATE}.${ddom}.ncf

if ( ${RUN_SPECIATE} == 'Y' ) then
   $bdir/mgn2mech | tee $wdir/log.run.${MECHANISM}.${SDATE}.${ddom}.txt
endif

