%ECHO OFF
set /p svpath="Enter Stardew Valley Path: "
IF NOT "%svpath:~-1%" == "\" set svpath=%svpath%\
IF EXIST "%svpath%" GOTO :exists

:notexist
echo No such path exists.
PAUSE
EXIT

:exists
inifile.exe SVPM.ini [General] StardewValleyPath=%svpath%
IF NOT EXIST ".\SMAPI\StardewModdingAPI" GOTO :complete
echo.

:smapiexist
IF EXIST "%svpath%StardewModdingAPI.exe" GOTO :askreinstall
inifile.exe SVPM.ini [General] SMAPIPath==
set /p option="Install SMAPI? (Y/N) "
goto :installchoice

:askreinstall
set /p option="You already have SMAPI, do you want to reinstall? (Y/N) "

:installchoice
IF /I "%option%" == "Y" GOTO :install
IF /I "%option%" == "N" GOTO :notinstall
echo Invalid Input!
goto :smapiexist


:install
set smapi=".\SMAPI"
xcopy "%smapi%" "%svpath%" /Y
inifile.exe SVPM.ini [General] SMAPIPath=%svpath%
echo.
echo Installed SMAPI to "%svpath%"
goto :complete

:notinstall
IF EXIST "%svpath%StardewModdingAPI.exe" (inifile.exe SVPM.ini [General] SMAPIPath=%svpath%) ELSE (echo. echo Run the Setup again if you choose to install SMAPI at a later time)

:complete
echo.
echo Setup Complete!
echo.
PAUSE