@echo off
:START
TITLE MOD UPDATE MANAGER
COLOR 0A
:: Configurable Variables Are listed below ::
set SCRIPTTITLE=M.U.M
:: Name of THIS BATCH FILE :: 
:: Helps with debug & window reference, when needed.  
set TITLE="MUM" 
set GUM="MUM.bat"
:: SERVER ROOT DIRECTORY ::

:: MOD UPDATE LIST ::
:: This points to your modlist.txt file. 
:: You will have had to created this txt file manually before starting the server.
:: This is a required file if you want to auto udate your server. 
:: The Modlist.txt must be unique per the dayz server instance it belongs to IE Modlist1.txt Modlist2.txt etc
:: This is assuming you want the servers to start faster by updating only the individual mods assigned in .bat file.
:: The contents of the file must be accurate "MODIDNUMBER,@MODNAME" one mod per line
:: You can ignore this, or leave it blank if you perefer manually updating your server(s)
:: If you are still not sure how this works... Join our Discord https://discord.gg/KK6KAvvD for more information . 
set MOD_LIST=(G:\mydayzserver\MOD_LIST_GLOBAL.txt)
:: STEAMCMD DIRECTORY AND USER INFORMATION ::
:: Below you will need to modify/set the location of your steamcmd Directory location of steam workshop, steam user name. 
set STEAMCMD_LOCATION=G:\steamcmd
:: This is where you put the path to your steam workshop directory
set STEAM_WORKSHOP=G:\steamcmd\steamapps\workshop\content\221100
:: Enter your steam user name. Do not worry about a password.
set STEAM_USER=CHANGETHISTOYOURSTEAMUSERNAME
:: No need to edit this next line...
set STEAMCMD_DEL=5

:: THINGS TO KNOW REGARDING STEAM LOGIN ::
:: SteamCMD Will ask for your password at the time of first boot from a new device. Password is then kept in a secure hash. 
:: You will only be prompted to enter password when you have deleted that hash. 
:: HOWEVER, if you have 2FA enabled ** such as email authorization code ** this will continue to be a problem every time the server auto-reboots.
:: 2FA interferes with the seamless login, update, mod update, server boot up process.

:: How often do you want MUM to check SteamCMD for updates
:: The default setting is 1800 seconds (30 minutes)
set TIMEOUT1=1800


:: THERE IS ABSOLUTELY NO NEED TO MODIFY THE CONTENT BELOW THIS LINE ::

::::::::::::::
goto CHECKMODS
:CHECKMODS
cls
FOR /L %%s IN (2,-1,0) DO (
	cls
	echo Checking for mod updates in %%s seconds.. 
	timeout 1 >nul
)
echo Reading in configurations/variables set in this batch and MOD_LIST. Updating Steam Workbench mods...
@ timeout 1 >nul
cd %STEAMCMD_LOCATION%
for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do steamcmd.exe +login %STEAM_USER% +workshop_download_item 221100 "%%g" +quit +cls
cls
echo Steam Workshop files/mods are up to date.
@ timeout 5 >nul
goto WAIT

:WAIT
cls
echo Please keep this window open to continue running Mod Update Manager.
echo Closing this window will terminate MUM.
echo MUM will check for upates every 15 Minutes.
echo To RESTART this process early press CTRL+C enter N at the prompt.
echo To TERMINATE this window press CTRL+C enter Y at the prompt.
echo Otherwise let this process do what it does.
echo.
echo If you need support, to be a part of our community, or to enquire 
echo             .....  what's next for GumZMumz  ... 
echo 				Join our Discord 
echo.
echo                          https://discord.gg/KK6KAvvD community
timeout %TIMEOUT1% /nobreak >nul
echo Restarting Mod Update Manager
timeout 2
goto START
