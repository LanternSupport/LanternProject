@echo off
title FiveM & System Ultimate Cleaner
color 0b

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting Administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

:Menu
cls
echo ==================================================
echo      FIVE M  -  SYSTEM  -  NETWORK CLEANER
echo ==================================================
echo.
echo  [WARNING] This will close FiveM, Steam, and Discord.
echo.
echo  1. Start Cleaning (Y)
echo  2. Exit (N)
echo.
set /p confirm="Enter choice (Y/N): "

if /i "%confirm%"=="Y" goto StartClean
if /i "%confirm%"=="N" goto ExitTool
goto Menu

:StartClean
cls
echo.
echo [1/5] Closing processes (FiveM, Steam, Discord)...
taskkill /F /IM FiveM.exe /T >nul 2>&1
taskkill /F /IM Steam.exe /T >nul 2>&1
taskkill /F /IM Discord.exe /T >nul 2>&1
timeout /t 2 >nul

echo.
echo [2/5] Clearing FiveM Cache...
if exist "%LocalAppData%\FiveM\FiveM.app\crashes" rd /s /q "%LocalAppData%\FiveM\FiveM.app\crashes"
if exist "%LocalAppData%\FiveM\FiveM.app\logs" rd /s /q "%LocalAppData%\FiveM\FiveM.app\logs"
if exist "%LocalAppData%\FiveM\FiveM.app\data\cache" rd /s /q "%LocalAppData%\FiveM\FiveM.app\data\cache"
if exist "%LocalAppData%\FiveM\FiveM.app\data\nui-storage" rd /s /q "%LocalAppData%\FiveM\FiveM.app\data\nui-storage"
if exist "%LocalAppData%\FiveM\FiveM.app\data\server-cache" rd /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache"
if exist "%LocalAppData%\FiveM\FiveM.app\data\server-cache-priv" rd /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache-priv"
echo    - FiveM Cache Cleared.

echo.
echo [3/5] Cleaning Windows Temp Files...
del /s /f /q "%temp%\*.*" >nul 2>&1
rd /s /q "%temp%" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
echo    - System Temp Files Cleared.

echo.
echo [4/5] Clearing Discord Cache...
if exist "%AppData%\discord\Cache" rd /s /q "%AppData%\discord\Cache"
if exist "%AppData%\discord\Code Cache" rd /s /q "%AppData%\discord\Code Cache"
if exist "%AppData%\discord\GPUCache" rd /s /q "%AppData%\discord\GPUCache"
echo    - Discord Cache Cleared.

echo.
echo [5/5] Resetting Network & Recycle Bin...
ipconfig /flushdns >nul
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1
echo    - DNS Flushed & Recycle Bin Emptied.

echo.
echo ==================================================
echo        ALL SYSTEMS CLEANED SUCCESSFULLY!
echo ==================================================
echo.
echo You can now restart FiveM.
timeout /t 5 >nul
exit

:ExitTool
echo.
echo Operation canceled.
timeout /t 2 >nul
exit