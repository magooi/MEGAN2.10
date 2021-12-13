# Getting data and codes
Download required files from Google Drive:

https://drive.google.com/drive/u/1/folders/1vKritH0B7nrAcHv0K_C1nxTheXBKn0pd

Basic: 
1) MEGAN source code
2) Tutorial input files
3) Run scripts

Advanced:

4) PREPCHEM2MEGAN preprocessor

## Getting the device environment ready
Download Ubuntu 20.04 LTS from the Microsoft Store or https://ubuntu.com/wsl

Follow the instructions here to install the required Windows Subsytem and restart the machine, as per the instructions on

https://docs.microsoft.com/en-us/windows/wsl/install-on-server

Download MobaXTerm for Windows

https://mobaxterm.mobatek.net

## Getting data ready
### Windows environment: Putting the files in the Linux home directory
Locate the Ubuntu folder in your machine: go to user folder

Example: (replace the username according to your account)

>C:\Users\Chelg\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home\maggieooi\MEGAN

![fileloc](https://user-images.githubusercontent.com/52151758/145754696-894900a9-5b77-4645-9f2e-2373b406fc79.PNG)

### WSL Ubuntu Environment: Extracting the files
1) Enter to the WSL Ubuntu environment
Open your MobaXTERM and double-click on WSL
![launch](https://user-images.githubusercontent.com/52151758/145755339-cfb38f60-60e9-442e-8e6d-935f47cb10c7.PNG)

2) Check files - make sure it can be accessed
Some basic LINUX commands:
```
pwd         - present working directory
ls          - listing files in folder
ls -lah     - listing files in folder with all details (a) in human readable form (h)
cd          - change directory
cd MEGAN    - enter MEGAN directory
```
![pdenied](https://user-images.githubusercontent.com/52151758/145756814-a22b54fd-a3d6-4d52-aa08-5e460c51b80b.PNG)

Turn on access with 755
```
chmod             - change mode of access (**r**ead,**w**rite,e**x**ecute); level: 7 (rwe), 5 (r-e), 4 (r--); 
                    user: user, group, others                  
chmod 700         - change mode of access to 700 (only admin can rwe)
chmod 755         - change mode of access to 755 (admin can rwe, groups and other can read and execute)
chmod 755 *       - change mode recursively (applies 700 for all the files)
chmod -R 755 *    - change mode recursively (applies 700 for all the files and files inside folders)
ls -lah
```

![chmod755](https://user-images.githubusercontent.com/52151758/145758195-ac8c72fe-9c78-4d7e-9aa3-ce1a94ebf4d0.PNG)

3) Untar and unzip files ending with .tar.gz
~~Files: MEGANv2.10beta.tar.gz, PREPMEGAN4CMAQ_data, sabi22.tar.gz~~
~~tar -zxvf *tar.gz~~

## Running MEGAN
### Understanding MEGAN codes
in MEGAN/MEGANv2.10
```
|-bin       : execution files (txt2ioapi, met2mgn, emproc, mgn2mech)
|-src       : source codes
|-work      : script executed (txt2ioapi, met2mgn, emproc, mgn2mech csh files)
|-Input     : input files (EF, PFT, LAI csv files)
|-Output    : output files
```

### Preparation
1) Correction of bin/mgn2mech link
```
cd bin
ls -l
ln -sf ../src/mgn2mech/mgn2mech .
ls -l
```

2) Copy tutorial input files into Input folder
```
cd MEGAN/Tutorial
cp *csv ../MEGANv2.10/Input
cp GRIDDESC ../MEGANv2.10
```

3) Setting environmental variables setcase.csh
```
cd MEGAN/MEGANv2.10
vi setcase.csh
```
In vi/vim editor:

Enter `i` for edit mode; `Esc` to exit edit mode

Enter `:w` to save change; `ZZ` to save change and exit; `:q!` to exit without saving

### Execution

1) txt2ioapi: Convert the text files into the I/O API files
```
./run.txt2ioapi.v210.csh
```
Specify input files location: EF.mSEA.csv, LAI.mSEA.csv, PFT.mSEA.csv

Specify output files location: EF.mSEA.ncf, LAI.mSEA.ncf, PFT.mSEA.ncf

Specify logfiles location: logfile...

2) met2mgn: Convert meteorological files (WRF/MCIP output) into I/O API files
```
./run.met2mgn.v210.2016352.csh
```
Input files: EF.mSEA.csv, LAI.mSEA.csv, PFT.mSEA.csv

Output files: EF.mSEA.ncf, LAI.mSEA.ncf, PFT.mSEA.ncf

Logfiles: logfile...

3) emproc: MEGAN emission processing files
```
./run.emproc.v210.2016352.csh
```
Input files: EF.mSEA.csv, LAI.mSEA.csv, PFT.mSEA.csv

Output files: EF.mSEA.ncf, LAI.mSEA.ncf, PFT.mSEA.ncf

Logfiles: logfile...

4) mgn2mech: MEGAN output speciated to specified chemical mechanism 

```
./run.mgn2mech.v210.2016352.csh
```
Input files: EF.mSEA.csv, LAI.mSEA.csv, PFT.mSEA.csv

Output files: EF.mSEA.ncf, LAI.mSEA.ncf, PFT.mSEA.ncf

Logfiles: logfile...
