@echo off
:START
TITLE DayZServer CORE FILE - GLOBAL UPDATE MANAGER (GUM)
COLOR 0A
:: Configure the below "sets" to suit your system or directory setup.

set SCRIPTTITTLE="G.U.M"
:: Name of THIS BATCH FILE :: 
:: Helps with debug & window reference, when needed.  
set TITLE="GUM.bat" 

:: DAYZGHOSTFILES AKA DAYZSERVER REPOSITORY FILES ::
:: This is the directory where the original dayzserver files will be downloaded and stored ::
:: These files will be updated by steamcmd when the GUM.bat script is executed and reboots every xx minutes ::
:: GUM.bat SCRIPT updates the DAYZSERVERFILES itself, it connects to the steamcmd and updates all dayserver files to their current release ::
set DAYZGHOSTFILES="PATHTOYOURDAYZSERVERREPO"

:: GAME SERVER ROOT DIRECTORY ::
:: This would be the directory where the default DayZServer_x64.exe file is located 
:: By default dayzserver is installed at C:\Steamlibrary\steamapps\common\DayZServer\
:: You can modify this  if your directory is different. This directory will be where your instance(s) of modified dayzservers will reside.
set DAYZSERVER_DIRECTORY="PATHTOYOURDAYZGAMESERVER"

:: STEAMCMD DIRECTORY AND USER INFORMATION ::
:: Below you will need to modify/set the location of your steamcmd Directory location of steam workshop, steam user name. 
set STEAMCMD_LOCATION=C:PATHTOYOUR\steamCMD
:: This is where you put your steam workshop directory details
set STEAM_WORKSHOP=C:PATHTOYOUR\steamCMD\steamapps\workshop\content\221100

:: Enter your steam user name. Do not worry about a password.
set STEAM_USER=YOURSTEAMUSERNAME
:: No need to edit this next line...
set STEAMCMD_DEL=10

:: TIMEOUT FOR SCRIPT RESTART ::
set TIMEOUT1=1200

:UPDDayZServer
@timeout 1 > NUL
echo Welcome...
@timeout 1 > NUL 
echo                  Now initiating %SCRIPTTITTLE%.
@timeout 1 > NUL
cls
echo --PLEASE NOTE-- This script will ONLY update your CORE server files.
@timeout 1 > NUL
cls
echo --PLEASE NOTE-- This Script DOES NOT update your DAYZ MOD files.
@timeout 1 > NUL
cls
echo --PLEASE NOTE-- To update your DAYZ MODS make sure you are running file: MUM.Bat
@timeout 15 > NUL
cls
goto STEAMCMD

:STEAMCMD
@echo off
cd %STEAMCMD_LOCATION%
steamcmd.exe +force_install_dir "%DAYZGHOSTFILES%" +login "%STEAM_USER%" +app_update 223350 validate +quit
@timeout 1
cls
echo ------------ DayZServer Files updated, and/or validating process has completed
@timeout 1 > NUL
cls
goto TRANSFER

:INFO
echo Seeing a report of "0 Files were copied" is normal, it means there are NO updated files to copy
@timeout 1 > NUL
echo Seeing a report of "can't read file:..." should be expected FOR THESE FILES: 
@timeout 1 > NUL
echo whitelist.txt - Marked as exempt
@timeout 1 > NUL
echo serverDZ.cfg - Marked as exempt
@timeout 1 > NUL
echo ------  Files that have been marked as exempt are config files.
echo ------  Config files are any files that are manually edited to suit your server setup.
echo ------  Overwriting these files in your game server directory WILL BREAK your server.
@timeout 5 > NUL
cls
goto TRANSFER

:TRANSFER
echo ------ New or updated core server files now being transfered to: 
echo ------ %DAYZSERVER_DIRECTORY%
xcopy %DAYZGHOSTFILES% %DAYZSERVER_DIRECTORY% /Z /U /Y /R
echo Seeing a report of "0 Files were copied" above, is normal, it means there are NO updated files to copy
@timeout 2 > NUL
echo Seeing a report of "can't read file:..." above, should be expected FOR THESE FILES: 
@timeout 15 > NUL
cls
goto restart 

:RESTART 
echo This system is monitoring Steam Dayz Server App (code: 223350)
echo The GUM process will repeat once every 5 minutes...
timeout %TIMEOUT1%
::Time in seconds to wait before..
timeout 5
::Go back to the top and repeat the whole cycle again
cls
goto START 

