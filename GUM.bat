@echo off
color 0A
title GUM-GLOBAL UPDATE MANAGER
set SCRIPTTITTLE="G.U.M - GLOBAL UPDATE MANAGER"
set SCRIPTVERSION="GumZMumz 1.0" 
:START
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Please change the variables below to match your current DayZServer System Configuration               ::
:: When you run this script a cmd prompt will open up and connect to SteamCMD                            ::
:: You will be prompted for the password that goes with the steam username you declare in variable below ::
:: Wait for the download or verification process to indicate your core files are up to date              ::
:: Leave GUM window running to check for updates every 15 minutes                                        ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: GHOSTFILES ::
:: Directory where the CORE dayzserver files have been *or will be* downloaded by the script, and archived::
:: NOTE: You will want to create this directory, before running this script, if DIR is not already present::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set DAYZGHOSTFILES="G:\dayzserver"

:: STEAMCMD DIRECTORY AND USER INFORMATION ::
:: Below you will need to modify/set the location of your SteamCMD Directory. If you are following our    ::
:: Instructions for this installation then this line is already accurate, if you are configuring GumZMumz ::
:: to run with a previous installation of steamcmd and dayzserver you may need to change this variable.   ::
:: The directory where your steamcmd.exe can be found                                                     ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set STEAMCMD_LOCATION=G:\steamcmd

:: YOUR STEAM USERNAME ::
:: Enter your steam user name. Do not worry about a password. If this is your first time running GUM.bat  ::
:: you will be prompted for a password when you run the script. If you have previously run steamcmd.exe   ::
:: the steamcmd directory will already have your user criteria stored. GUMZMUMZ                           ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set STEAM_USER=CHANGETHISTOYOURSTEAMUSERNAME
:: No need to edit this next line...
set STEAMCMD_DEL=10

:: TIMEOUT FOR SCRIPT RESTART ::
set TIMEOUT1=1200

:UPDDayZServer
echo Welcome... %SCRIPTTITTLE% %SCRIPT_VERSION%
@timeout 1 > NUL
cls
echo --PLEASE NOTE-- 
echo 				This script will ONLY update Server CORE server files.
@timeout 2 > NUL
echo --PLEASE NOTE-- 
echo 				This Script DOES NOT update Server MOD files.
@timeout 2 > NUL
echo --PLEASE NOTE-- 
echo				To update Server MODS make sure you are running: MUM.Bat
@timeout 8 > NUL
cls
@timeout 2 > NUL 
echo                 Initiating %SCRIPTTITTLE%.
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
echo Process has completed. Core DayZServer files are now up to date
echo Keep this window open to continue running Global Update Manager.
echo Closing this window will terminate GUM.
echo GUM will check for upates every 15 Minutes by default.
echo To RESTART this process early press CTRL+C enter N at the prompt.
echo To TERMINATE this window press CTRL+C enter Y at the prompt.
echo Otherwise allow this process/script to do what it does.
echo.
echo If you need support, to be a part of our community, or to enquire 
echo             .....  what's next for GumZMumz  ... 
echo 				Join our Discord 
echo.
echo                          https://discord.gg/KK6KAvvD community
timeout %TIMEOUT1% /nobreak >nul
timeout 1
cls
goto START 

:: More updates to come in the near future ::
