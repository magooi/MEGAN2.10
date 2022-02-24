### Disclaimer
This is just a tutorial created to assist the execution of the 	
Model of Emissions of Gases and Aerosols from Nature (MEGAN) model.
Please visit the developer site for more information:
https://bai.ess.uci.edu/megan/

Reference: https://gmd.copernicus.org/articles/5/1471/2012/

The tutorial is developed for academic purposes in support of the UKM-YSD Chair in Climate Change grant (ZF-2020-001)

# Downloading data and codes
Download required files as provided:

Basic: 
1) MEGAN source code
2) Tutorial input files
3) Run scripts

<!--Advanced:
4) PREPCHEM2MEGAN preprocessor
5) PREPCHEM2MEGAN_data-->

# Getting the device environment ready
Download Ubuntu 20.04 LTS from the Microsoft Store or https://ubuntu.com/wsl

Follow the instructions here to install the required Windows Subsytem and restart the machine, as per the instructions on

https://docs.microsoft.com/en-us/windows/wsl/install-on-server

Download MobaXTerm for Windows

https://mobaxterm.mobatek.net

Download gedit for Windows

https://gedit.en.uptodown.com/windows

# Moving files to the Linux environment
Locate the Ubuntu folder in your machine (AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc)

Enter to the home directory and create a folder called "MEGAN"

Example: (replace the username according to your account)

>C:\Users\Chelg\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home\maggieooi\MEGAN

![fileloc](https://user-images.githubusercontent.com/52151758/145754696-894900a9-5b77-4645-9f2e-2373b406fc79.PNG)

<!--Tutorial 1:-->
Move MEGANv2.10_beta.tar.gz and Tutorial1 into .../home/`user`/MEGAN

# Setting up WSL Ubuntu environment
## Enter to the WSL Ubuntu
Open your MobaXTerm and double-click on WSL

## Installing necessary functions
Type commands below and key in password when prompted
```
sudo apt-get update
sudo apt install ncview
sudo apt install csh
```

## Extracting the files

### Check files permissions
Some basic LINUX commands:
```
pwd         - present working directory
ls          - listing files in folder
ls -lah     - listing files in folder with all details (a) in human readable form (h)
cd          - change directory
cd MEGAN    - enter MEGAN directory
```
![pdenied](https://user-images.githubusercontent.com/52151758/145756814-a22b54fd-a3d6-4d52-aa08-5e460c51b80b.PNG)

### Change file access status
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
### Move files into the MEGAN folder
```
mv MEGANv2.10_beta.tar.gz MEGAN
mv Tutorial1.zip MEGAN
```

### Untar and unzip files ending with .tar.gz
In MEGAN directory:
```
cd ~/MEGAN
ls
tar -zxvf MEGANv2.10_beta.tar.gz
ls -lah
ls -lah MEGANv2.10
cd ../
unzip Tutorial1.zip
ls -lah
ls -lah Tutorial1
```
<!-- In PREPMEGAN4CMAQ_data:

LINUX commands for untar and unzip:
```
tar -zxvf global_30s_2013_001_invlat.tar.gz    - couldn't run for multiple files
for i in *.tar.gz; do tar -zxvf "$i"; done     - list files and run one by one
```
![untar](https://user-images.githubusercontent.com/52151758/145760108-78828eda-f8d8-4c5f-9f84-ac46e5a30822.PNG)-->

# Running MEGAN
## Understanding MEGAN codes
in MEGAN/MEGANv2.10
```
|-bin         : execution files (txt2ioapi, met2mgn, emproc, mgn2mech)
|-src         : source codes
|-work        : script executed (txt2ioapi, met2mgn, emproc, mgn2mech csh files)
|-Input       : input files (EF, PFT, LAI csv files)
|-Output      : output files
|-setcase.csh : setting the environment variables
```

## Preparation
1) Correction of bin/mgn2mech link
```
cd bin
ls -l
ln -sf ../src/MGN2MECH/mgn2mech .
ls -l
```

2) Copy tutorial input files into MEGANv2.10 folder
```
cd ~/MEGAN/Tutorial1/Input
ls
cp * ../../MEGANv2.10/Input
```

3) Copy tutorial script files into MEGANv2.10 folder
```
cd ~/MEGAN/Tutorial1
ls
cp *csh ../MEGANv2.10
cd ../MEGANv2.10
ls -lah
ls -lah Input
```

4) Setting environmental variables setcase.csh
```
cd MEGAN/MEGANv2.10
cat setcase.csh     - printout file on screen
pwd
vi setcase.csh      - edit `MGNHOME` directory
```
In vi/vim editor:

Enter `i` for edit mode; `Esc` to exit edit mode

Enter `:w` to save change; `ZZ` to save change and exit; `:q!` to exit without saving

## Execution

1) txt2ioapi: Convert the text files into the I/O API files
```
./run.txt2ioapi.v210.csh
```
Input files: EF210_mSEA_d01.csv, LAI210_mSEA_d01.csv, PFT210_mSEA_d01.csv

Output files: EFMAPS.mSEA.d01.ncf, LAIS46.mSEA.d01.ncf, PFTS16.mSEA.d01.ncf

Output logfile: log.txt2ioapi.d01.txt

2) met2mgn: Convert meteorological files (WRF/MCIP output) into I/O API files
```
./run.met2mgn.v210.2016352.csh
```
Input files: METCRO2D_d01_2016325, METCRO3D_d01_2016325, METDOT3D_d01_2016325

Output files: MET.MEGAN.2016325.d01.ncf

Output logfile: log.met2mgn.2016325.d01.txt

3) emproc: MEGAN emission processing files
```
./run.emproc.v210.2016352.csh
```
Input files: Output files from txt2ioapi and met2mgn

Output files: ER.mSEA.2016325.d01.ncf

Logfiles: log.emproc.2016325.d01.txt 

4) mgn2mech: MEGAN output speciated to specified chemical mechanism 

```
./run.mgn2mech.v210.2016352.csh
```
Input files: ER.mSEA.2016325.d01.ncf

Output files: MEGANv2.10.mSEA.CB05.2016325.d01.ncf

Logfiles: log.run.CB05.2016325.d01.txt 
