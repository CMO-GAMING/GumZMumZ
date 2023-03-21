@echo off
color 0A
title GUM - GLOBAL UPDATE MANAGER
set SCRIPTTITTLE="G.U.M"
set TITLE="GUM.bat" 
:START
:: Configure the below "sets" to suit your system or directory setup.
:: DAYZGHOSTFILES AKA DAYZSERVER REPOSITORY FILES ::
:: This is the directory where the original dayzserver files will be downloaded and stored ::
:: These files will be updated by steamcmd when the GUM.bat script is executed and reboots every xx minutes ::
:: GUM.bat SCRIPT updates the DAYZSERVERFILES itself, it connects to the steamcmd and updates all dayserver files to their current release ::
set DAYZGHOSTFILES="G:\MyDayZServer"

:: GAME SERVER ROOT DIRECTORY ::
:: This would be the directory where your ACTIVE GAME SERVER will be located 
:: This directory will be where your instance/active dayzserver will reside.
set DAYZSERVER_DIRECTORY="G:\MyDayZGameServer"

:: STEAMCMD DIRECTORY AND USER INFORMATION ::
:: Below you will need to modify/set the location of your steamcmd Directory for this line you will simply put in the directory where your steamcmd.exe resides. 
set STEAMCMD_LOCATION=G:\SteamCMD1 

:: Enter your steam user name. Do not worry about a password.
set STEAM_USER=YOURSTEAMUSERNAME
:: No need to edit this next line...
set STEAMCMD_DEL=10

:: TIMEOUT FOR SCRIPT RESTART ::
set TIMEOUT1=1200

:UPDDayZServer
@timeout 1 > NUL
echo Welcome...
@timeout 2 > NUL 
echo                 Initiating %SCRIPTTITTLE%.
@timeout 3 > NUL
cls
echo --PLEASE NOTE-- 
echo 				This script will ONLY update Server CORE server files.
@timeout 2 > NUL
cls
echo --PLEASE NOTE-- 
echo 				This Script DOES NOT update Server MOD files.
@timeout 2 > NUL
cls
echo --PLEASE NOTE-- 
echo				To update Server MODS make sure you are running: MUM.Bat
@timeout 5 > NUL
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
goto WAIT

:WAIT
cls
echo Please keep this window open to continue running Global Update Manager.
echo Closing this window will terminate GUM.
echo GUM will check for upates every 15 Minutes.
echo To RESTART this process early press CTRL+C enter N at the prompt.
echo To TERMINATE this window press CTRL+C enter Y at the prompt.
echo Otherwise let this process do what it does.
echo.
echo If you need support or to see whats next for GumZMumz... 
echo 				Join our Discord https://discord.gg/KK6KAvvD community
timeout %TIMEOUT1% /nobreak >nul
timeout 1
cls
goto START 

:: More updates to come in the near future ::
