@echo off
rem Shared settings for the tools\*.bat scripts. To override one, set it before running a script,
rem e.g.  set "UNITY465_EXE=D:\Unity4.6.5\Unity.exe"  or  set "BUILD_DIR=D:\Builds\UberStrike"

for %%I in ("%~dp0..") do set "REPO_ROOT=%%~fI"
if not defined UNITY465_EXE set "UNITY465_EXE=%USERPROFILE%\Unity4.6.5\Unity.exe"
if not defined BUILD_DIR set "BUILD_DIR=%REPO_ROOT%\Build\UberStrike-4.7.1"
if not defined UNITY465_KIT set "UNITY465_KIT=%USERPROFILE%\unity-4.6.5f1"
if not defined FORGERIPPER_DIR set "FORGERIPPER_DIR=%USERPROFILE%\ForgeRipper"

rem The Steam install of UberStrike (for uberdaemon.exe). Default Steam library first.
if defined UBERSTRIKE_STEAM_DIR goto :eof
set "STEAM_PATH="
for /f "skip=2 tokens=2,*" %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAM_PATH=%%B"
if defined STEAM_PATH set "UBERSTRIKE_STEAM_DIR=%STEAM_PATH:/=\%\steamapps\common\UberStrike"
