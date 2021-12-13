# MEGAN2.1beta
Download required files from Google Drive:

https://drive.google.com/drive/u/1/folders/1vKritH0B7nrAcHv0K_C1nxTheXBKn0pd
1) MEGAN source code
2) Tutorial input files
3) Run scripts
4) PREPCHEM2MEGAN preprocessor

# Getting the device environment ready
Download Ubuntu 20.04 LTS from the Microsoft Store or https://ubuntu.com/wsl

Follow the instructions here to install the required Windows Subsytem and restart the machine, as per the instructions on

https://docs.microsoft.com/en-us/windows/wsl/install-on-server

Download MobaXTerm for Windows

https://mobaxterm.mobatek.net

# Getting data ready
## Windows environment
### Putting the files in the Linux home directory
Locate the Ubuntu folder in your machine: go to user folder

Example: (replace the username according to your account)

>C:\Users\Chelg\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home\maggieooi\MEGAN

![fileloc](https://user-images.githubusercontent.com/52151758/145754696-894900a9-5b77-4645-9f2e-2373b406fc79.PNG)

## WSL Environment
### Extracting the files
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
chmod             - change mode of access (*r*ead,*w*rite,e*x*ecute); level: 7 (rwe), 5 (r-e), 4 (r--); 
                    user: user, group, others
chmod 700         - change mode of access to 700 (only admin can rwe)
chmod 755         - change mode of access to 755 (admin can rwe, groups and other can read and execute)
chmod 755 *       - change mode recursively (applies 700 for all the files)
chmod -R 755 *    - change mode recursively (applies 700 for all the files and files inside folders)
ls -lah
```
![chmod755](https://user-images.githubusercontent.com/52151758/145758195-ac8c72fe-9c78-4d7e-9aa3-ce1a94ebf4d0.PNG)


tar -zxvf *tar.gz
