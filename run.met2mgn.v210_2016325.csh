#!/bin/csh
#
# MET2MGN v2.10 
# --
#
#
# TPAR2IOAPI v2.03a 
# --added 26-category landuse capability for mm5camx (number of landuse categories defined by NLU) 
# --added capability for LATLON and UTM projections
# --added capability for MCIP v3.3 input (2m temperatures)
# --bug in PAR processing subroutine fixed where first few hours in GMT produced zero PAR
# --added code to fill missing par data (if valid data exists for the hours surrounding it)
#
# TPAR2IOAPI v2.0
# --added capability for MM5 or MCIP input
# 
#
#        RGRND/PAR options:
#           setenv MM5RAD  Y   Solar radiation obtained from MM5
#           OR 
#           setenv MCIPRAD Y   Solar radiation obtained from MCIP
#                  --MEGAN will internally calculate PAR for each of these options and user needs to  
#                    specify `setenv PAR_INPUT N' in the MEGAN runfile
#           OR
#           setenv SATPAR Y (satellite-derived PAR from UMD GCIP/SRB files)
#                  --user needs to specify `setenv PAR_INPUT Y' in the MEGAN runfile
#
#        TEMP options:
#           setenv CAMXTEMP Y         2m temperature, calculated from mm5camx output files
#           OR
#           setenv MM5MET  Y         2m temperature, calculated from MM5 output files
#                                     Note: 2m temperature is calculated since the P-X/ACM PBL
#                                     MM5 configuration (most commonly used LSM/PBL scheme for AQ 
#                                     modeling purposes) does not produce 2m temperatures.
#           OR
#           setenv MCIPMET Y         temperature obtained from MCIP
#              -setenv TMCIP  TEMP2   2m temperature, use for MCIP v3.3 or newer
#              -setenv TMCIP  TEMP1P5 1.5m temperature, use for MCIP v3.2 or older
#
#        TZONE   time zone for input mm5CAMx files 
#        NLAY    number of layers contained in input mm5CAMx files 
#        NLU     number of landuse categories contained in CAMx landuse file 
#

############################################################



############################################################
# Episodes
############################################################
set ddom = d01 
set STJD = 2016325 
set EDJD = 2016325

setenv EPISODE_SDATE 2016325
setenv EPISODE_STIME  000000    

############################################################
# Setting up directories and common environment variable
############################################################
set wdir = /home/maggieooi/MEGAN/MEGANv2.10
set idir = /home/maggieooi/MEGAN/MEGANv2.10/Input
set bdir = /home/maggieooi/MEGAN/MEGANv2.10/bin

set INPPATH     = $idir
set OUTPATH     = $idir
setenv GRIDDESC ${idir}/GRIDDESC
setenv GDNAM3D 201611${ddom}

if (! -e $OUTPATH) mkdir $OUTPATH

setenv PFILE $OUTPATH/PFILE
rm -fv $PFILE

############################################################
# Looping
############################################################
set JDATE = $STJD
set Y4 = 2016
set Y2 = 16
set MM = 11
@ DD = 20
@ DDm1 = 19
while ($JDATE <= $EDJD)

echo '===================='
echo 'JDATE = '$JDATE
echo '===================='
if ($JDATE == 2016367) set JDATE = 2017001
@ jdy  = $JDATE - 2000000
#set Y4 = `j2g $JDATE | awk '{print $1}'`
#set Y2 = `echo $Y4 | cut -c 3-4`
#set MM = `j2g $JDATE | awk '{print $2}'`
#set DD = `j2g $JDATE | awk '{print $3}'`

set Y4 = 2016
set Y2 = 16
set MM = 11
#@ DD++
echo '===================='
echo 'jdy    = '$jdy
echo 'Y4MMDD = '$Y4$MM$DD
echo '===================='


@ JDATEm1 = $JDATE - 1
if ($JDATEm1 == 2016000) set JDATEm1 = 2015365
@ jdym1  = $JDATEm1 - 2000000
#set Y4m1 = `j2g $JDATEm1 | awk '{print $1}'`
#set Y2m1 = `echo $Y4m1 | cut -c 3-4`
#set MMm1 = `j2g $JDATEm1 | awk '{print $2}'`
#set DDm1 = `j2g $JDATEm1 | awk '{print $3}'`
set Y4m1 = 2016
set Y2m1 = 16
set MMm1 = 11
#@ DDm1++

#set start/end dates
setenv STDATE ${jdy}00
setenv ENDATE ${jdy}23

#TEMP/PAR input choices
#set if using MM5 output files
setenv MM5MET N
setenv MM5RAD N

#set if using UMD satellite PAR data
set PARDIR = $idir/PAR
setenv SATPAR N
set satpar1 = "$PARDIR/$Y2m1${MMm1}par.h"
set satpar2 = "$PARDIR/$Y2${MM}par.h"

if ($satpar1 == $satpar2) then
  setenv numSATPAR 1
  setenv SATPARFILE1 $satpar2
else
  setenv numSATPAR 2
  setenv SATPARFILE1 $satpar1
  setenv SATPARFILE2 $satpar2
endif

#set if using MCIP output files
setenv MCIPMET Y
setenv TMCIP  TEMP2          #MCIP v3.3 or newer
#setenv TMCIP  TEMP1P5       #MCIP v3.2 or older

setenv MCIPRAD Y 
if ($JDATE == $EPISODE_SDATE) then
  setenv METCRO2Dfile1 $INPPATH/METCRO2D_${ddom}_${JDATE}
else
  setenv METCRO2Dfile1 $INPPATH/METCRO2D_${ddom}_${JDATE} 
  setenv METCRO2Dfile2 $INPPATH/METCRO2D_${ddom}_${JDATE}
endif
setenv METCRO3Dfile  $INPPATH/METCRO3D_${ddom}_${JDATE} 
setenv METDOT3Dfile  $INPPATH/METDOT3D_${ddom}_${JDATE}

setenv OUTFILE $OUTPATH/MET.MEGAN.${JDATE}.${ddom}.ncf
rm -rf $OUTFILE

$bdir/met2mgn |tee $wdir/log.met2mgn.${JDATE}.${ddom}.txt 

@ DD++
@ DDm1++
@ JDATE++

end  # End while JDATE
