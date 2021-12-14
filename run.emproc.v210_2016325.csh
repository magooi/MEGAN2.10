#! /bin/csh -f

setenv reg mSEA
setenv PROMPTFLAG N
set ddom = d01

set wdir = /home/maggieooi/MEGAN/MEGANv2.10/
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

setenv RUN_MEGAN   Y                    # Run megan?
setenv ONLN_DT     Y                    # Use online daily average temperature
setenv ONLN_DS     Y                    # Use online daily average solar radiation

setenv EFMAPS $INPDIR/EFMAPS.${reg}.${ddom}.ncf
setenv PFTS16 $INPDIR/PFTS16.${reg}.${ddom}.ncf
setenv LAIS46 $INPDIR/LAIS46.${reg}.${ddom}.ncf
setenv MGNMET $INPDIR/MET.MEGAN.${SDATE}.${ddom}.ncf
setenv MGNERS $INPDIR/ER.${reg}.${SDATE}.${ddom}.ncf

if ( ${RUN_MEGAN} == 'Y' ) then
   rm -f $MGNERS
   time $bdir/emproc  >&! $wdir/log.emproc.${SDATE}.${ddom}.txt
endif

