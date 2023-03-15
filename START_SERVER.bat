@echo off
:start
TITLE 
COLOR 0A
:: Configurable Variables Are listed below ::
:: If you are not sure how to do this... visit http://www.cmogaming.com 
:: Alos join our Discord https://discord.gg/KK6KAvvD for more information . 

:: Name of THIS BATCH FILE :: 
:: Helps with debug & window reference, when needed.  
set TITLE="START_SERVER.bat" 
:: Name of the SERVER TITLE :: 
:: This will be the Name of your Game server instance. 
:: Enter the same name here as you have it listed in your .cfg file
set SERVERTITLE="FILLME" 

:: SERVER ROOT DIRECTORY ::
:: This would be the directory where the default DayZServer_x64.exe file is located 
:: By default dayzserver is installed at C:\Steamlibrary\steamapps\common\DayZServer\
:: You can modify this  if your directory is different
set DAYZSERVER_DIRECTORY="PATHTOYOURDAYZGAMESERVERDIRECTORY"

:: SERVERDZ.CFG ::
:: The name of your serverDZ.cfg file if you have renamed it. 
:: If you are only running one instance and using the default simply enter serverDZ.cfg
set CONFIG=serverDZ_SRV1.cfg

:: PORT :: 
:: Please set your Game Port
set GPORT=1234

:: MODLIST ::
:: Here you will enter your MODS you will be running on the server
set ACTIVEMODS=;@mod
:: PROFILES FOLDER INFORMATION ::
:: Please enter the directory for your server/instance Profiles folder. 
:: This fodler will NOT already be present in a NEW installation
:: Instead, the provided profiles folder will be AUTO GENERATED on FIRST boot. 
:: This profile location becomes home to any mod generated configurable files IE: Dayz Expansion, Community online tools, or V++ADMIN.
:: This IS NOT the same folder as your mpmissions storage folder... 
set PROFILES=G:\DayZServers\GLOBAL\profiles-SRV1

:: The path to your battleye folder...
set BEpath=G:\DayZServers\GLOBAL\battleye-SRV1

:: GIVE YOUR SERVER INSTANCE IT'S OWN DayZServer-x64-INSTANCE-ID.EXE "
:: Below you can choose to rename your dayzserver executable file in order to match this specific batch file configuration variables as well as specific serverDZ.cfg parameters.
set DZSA_EXE_RENAME=DayZServer_x64-SRV1.exe
:: How often do you want to restart your dayzserer
:: The below example number will restart the server every 4 hours
set timeout1=14600

:: As long as you have entered the correct information as requested and outlined above the server will start, update, and continue to reboot/update every x hours. 
:: You can use the same directory for multiple instances of servers AS LONG AS YOU CHANGE THE ABOVE INFORMATION PER SERVER.

:: THERE IS ABSOLUTELY NO NEED TO MODIFY THE CONTENT BELOW THIS LINE ::


::::::::::::::

goto CHECKSRVR
pause 

::  Checks to see if the server is already running by searching the tasklist
:CHECKSRVR
echo Checking task manager for running %DZSA_EXE_RENAME% and terminating if active...
tasklist /FI "%DZSA_EXE_RENAME%" 2>NUL | find /I /N "%DZSA_EXE_RENAME%">NUL
if "%ERRORLEVEL%"=="0" goto checkbec
timeout 3 > NUL
goto CHECKMODS

:startsv
cls
echo Starting %SERVERTITLE% 
timeout 2
cd "%DAYZSERVER_DIRECTORY%"
start %DZSA_EXE_RENAME% -config=%CONFIG% -port=%GPORT% -dologs -adminlog -netlog -freezecheck -BEpath=%BEpath% -profiles=%PROFILES% "-mod=%ACTIVEMODS%"
FOR /L %%s IN (2,-1,0) DO (
	cls
	echo Initializing server, wait %%s seconds to initialize Bec.. 
	timeout 1 >nul
)
goto Restart

:checkmods
cls
FOR /L %%s IN (2,-1,0) DO (
	cls
	echo Checking for mod updates in %%s seconds.. 
	timeout 1 >nul
)
echo Reading in configurations/variables set in this batch and MOD_LIST. Updating DayZ Mods...
@ timeout 1 >nul
echo Syncing DayZServer Files from Steamcmd workshop...
@ timeout 2 >nul
@ for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do robocopy "%STEAM_WORKSHOP%\%%g" "%DAYZSERVER_DIRECTORY%\%%h" *.* /mir
@ for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do forfiles /p "%DAYZSERVER_DIRECTORY%\%%h" /m *.bikey /s /c "cmd /c copy @path %DAYZSERVER_DIRECTORY%\keys"
cls
echo Initiating DayZServer executable as defined in your %TITLE% file. 
@ timeout 3 >nul
cls
goto UPDSrvexe

:UPDSrvexe
CD %DAYZSERVER_DIRECTORY%
echo off f | xcopy /D %DAYZSERVER_DIRECTORY%\DayZServer_x64.exe %DAYZSERVER_DIRECTORY%\%DZSA_EXE_RENAME%* /A /Y
goto startsv

:Restart
timeout %TIMEOUT1%
taskkill /%DZSA_EXE_RENAME% /F
::Time in seconds to wait before..
timeout 2
::Go back to the top and repeat the whole cycle again
goto start