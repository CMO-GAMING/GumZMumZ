@echo off
color 0A
:START
:: If you are not sure how to do this... visit http://www.cmogaming.com 
:: join our Discord https://discord.gg/KK6KAvvD for more information . 

:: Name of THIS BATCH FILE :: 
:: Helps with debug & window reference, when needed.  
set FILENAME="START_SERVER.bat" 
:: Name of the SERVER TITLE :: 
:: This will be the Name of your Game server instance. 
:: Enter the same name here as you have it listed in your .cfg file
set SERVERTITLE="My GumZMumZ Server 1" 

:: DAYZGHOSTFILES AKA DAYZSERVER REPOSITORY FILES ::
:: This is the directory where the original dayzserver files will be downloaded and stored ::
:: These files will be updated by steamcmd when the GUM.bat script is executed and reboots every xx minutes ::
:: GUM.bat SCRIPT updates the DAYZSERVERFILES itself, it connects to the steamcmd and updates all dayserver files to their current release ::
set DAYZGHOSTFILES=G:\MyDayZServer

:: SERVER ROOT DIRECTORY ::
:: This would be the directory where the default DayZServer_x64.exe file is located 
:: By default dayzserver is installed at C:\Steamlibrary\steamapps\common\DayZServer\
:: You can modify this  if your directory is different
set DAYZSERVER_DIRECTORY="G:\MyDayZGameServer"

:: This is where you put your steam workshop directory details
set STEAM_WORKSHOP=G:\SteamCMD1\steamapps\workshop\content\221100

:: MOD UPDATE LIST ::
:: This points to your MOD_LIST_GLOBAL.txt file. 
:: This is required if you want to auto udate your server. 
:: The contents of the file must be accurate "MODIDNUMBER,@MODNAME" one mod per line.
set MOD_LIST=(G:\MyDayZGameServer\GumZMumz\MOD_LIST_GLOBAL.txt)

:: SERVERDZ.CFG ::
:: The name of your serverDZ.cfg file if you have renamed it. 
:: If you are only running one instance and using the default simply enter serverDZ.cfg
set CONFIG=ServerDZ_SRV1.cfg

:: PORT :: 
:: Please SET YOUR GAME PORT ::
set GPORT=XXXX

:: MODLIST ::
:: Here you will enter your MODS you will be running on the server
set ACTIVEMODS=

:: PROFILES FOLDER INFORMATION ::
:: Please enter the directory for your server/instance Profiles folder. 
:: This fodler will NOT already be present in a NEW installation
:: Instead, the provided profiles folder will be AUTO GENERATED on FIRST boot. 
:: This profile location becomes home to any mod generated configurable files IE: Dayz Expansion, Community online tools, or V++ADMIN.
:: This IS NOT the same folder as your mpmissions storage folder... 
set PROFILES=G:\MyDayZGameServer\profiles-SRV1

:: The path to your battleye folder...
set BEpath=G:\MyDayZGameServer\battleye-SRV1

:: GIVE YOUR SERVER INSTANCE IT'S OWN DayZServer-x64-INSTANCE-ID.exe name "
:: Below you can choose to rename your dayzserver executable file in order to match this specific batch file configuration variables as well as specific serverDZ.cfg parameters.
set DZSA_EXE_RENAME=DayZServer_x64_SRV1.exe
:: How often do you want to restart your dayzserer
:: The below example number will restart the server every 4 hours
set timeout1=14600

:: As long as you have entered the correct information as requested and outlined above the server will start, update, and continue to reboot/update every x hours. 
:: You can use the same directory for multiple instances of servers AS LONG AS YOU CHANGE THE ABOVE INFORMATION PER SERVER.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: THERE IS ABSOLUTELY NO NEED TO MODIFY THE CONTENT BELOW THIS LINE ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set ="START_SERVER.bat" 
set LOG_DIR=G:\MyDayZGameServer\GumZMumZ\logs
set LOG_FILE=%LOG_DIR%\start_server_output.log
set ERROR_LOG_FILE=%LOG_DIR%\start_server_errors.log
if not exist %LOG_DIR% mkdir %LOG_DIR%
echo Starting Server...
echo Log files at %LOG_DIR%


echo %date% %time% START_SERVER Initiated >> %LOG_FILE%
goto CHECKSRVR
pause 

:CHECKSRVR
echo %date% %time% Checking Server. Is the server already running... >> %LOG_FILE%
tasklist /FI "%DZSA_EXE_RENAME%" 2>NUL | find /I /N "%DZSA_EXE_RENAME%">NUL
if "%ERRORLEVEL%"=="0" (
echo %date% %time% Yes the server is running. Teminating Server >> %LOG_FILE%
) else (
echo %date% %time% No the server is not running, proceeding to COPYGHOST >> %LOG_FILE%
)
goto KILLSERVER
:KILLSERVER
taskkill /f /im Bec.exe
taskkill /f /im %DZSA_EXE_RENAME%
goto COPYGHOST

:COPYGHOST
echo %date% %time% COPYGHOST Initiated >> %LOG_FILE%
robocopy "%DAYZGHOSTFILES%" "%DAYZSERVER_DIRECTORY%" /E /S >> %LOG_FILE% 2>> %ERROR_LOG_FILE%
echo %date% %time% Files Have Been Copied >> %LOG_FILE%
echo %date% %time% Proceeding To CHECKMODS >> %LOG_FILE%
goto CHECKMODS

:checkmods
echo %date% %time% CHECKMODS Initiated >> %LOG_FILE%
@ for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do robocopy "%STEAM_WORKSHOP%\%%g" "%DAYZSERVER_DIRECTORY%\%%h" *.* /mir >> %LOG_FILE% 2>> %ERROR_LOG_FILE%
@ for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do forfiles /p "%DAYZSERVER_DIRECTORY%\%%h" /m *.bikey /s /c "cmd /c copy @path %DAYZSERVER_DIRECTORY%\keys" >> %LOG_FILE% 2>> %ERROR_LOG_FILE%
cls
echo %date% %time% CHECKMODS Has Completed >> %LOG_FILE%
goto UPDSERVEXE

:UPDSERVEXE
cls
echo %date% %time% UPDSERVEXE Initiated >> %LOG_FILE%
CD %DAYZSERVER_DIRECTORY%
echo %date% %time% Changing Directory >> %LOG_FILE%
echo off f | xcopy /D %DAYZSERVER_DIRECTORY%\DayZServer_x64.exe %DAYZSERVER_DIRECTORY%\%DZSA_EXE_RENAME% /A /Y >> %LOG_FILE% 2>> %ERROR_LOG_FILE%
goto STARTSERVER

:STARTSERVER
cls
echo %date% %time% STARTSERVER Initiated >> %LOG_FILE%
cd "%DAYZSERVER_DIRECTORY%"
echo %date% %time% Changed to %DAYZSERVER_DIRECTORY% >> %LOG_FILE%
echo %date% %time% Starting server >> %LOG_FILE%
start %DZSA_EXE_RENAME% -config=%CONFIG% -port=%GPORT% -dologs -adminlog -netlog -freezecheck -BEpath=%BEpath% -profiles=%PROFILES% "-mod=%ACTIVEMODS%" >> %LOG_FILE% 2>> %ERROR_LOG_FILE%
FOR /L %%s IN (2,-1,0) DO (
cls
)
goto WAITITOUT


:WAITITOUT
echo %date% %time% All Processes Initiated. Waiting It Out. >> %LOG_FILE%
echo Please keep this window open to continue auto restarts of your dayz server.
echo Closing this will terminate any scheduled game server RESTARTS.
echo Currently your server is set to RESTART every %TIMEOUT1% seconds.
echo To RESTART this process early press CTRL+C enter N at the prompt.
echo To TERMINATE this window press CTRL+C enter Y at the prompt.
echo Otherwise let this process do what it does.
echo.
echo If you require further support, want to see what is next for GumZMumz
echo or you want to support or conribute to our future development... 
echo 				Join our Discord https://discord.gg/KK6KAvvD community
timeout %TIMEOUT1% /nobreak >nul
echo %date% %time% Restart Initiated >> %LOG_FILE%
taskkill /%DZSA_EXE_RENAME% /F
goto START
