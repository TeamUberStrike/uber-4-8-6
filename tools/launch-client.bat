@echo off
setlocal
call "%~dp0config.bat"
if not "%~1"=="" set "BUILD_DIR=%~f1"
if not exist "%BUILD_DIR%\UberStrike.exe" ( echo No build at %BUILD_DIR%. Run tools\build-player.bat first. & exit /b 1 )
tasklist /fi "imagename eq steam.exe" 2>nul | findstr /i /c:"steam.exe" >nul || echo WARNING: Steam is not running - start Steam and log in first.
rem Started from cmd on purpose: launching from Git Bash leaks its MSYS environment into Steam's helper and login hangs.
start "" /d "%BUILD_DIR%" "%BUILD_DIR%\UberStrike.exe"
