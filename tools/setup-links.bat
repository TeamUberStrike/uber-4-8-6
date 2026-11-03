@echo off
rem Links the code folders at the repo root (UberClient v4.8.6 layout) into the Unity project.
rem Unity 4.6.5 only compiles scripts inside Assets/, so Assets/Scripts/Assembly-CSharp and
rem Assets/Plugins/Assembly-CSharp-firstpass are directory junctions to Assembly-CSharp/ and Assembly-CSharp-firstpass/.
rem Safe to run any number of times. open-project.bat and build-player.bat run it first.
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"
call :link "%ROOT%\Assets\Scripts\Assembly-CSharp" "%ROOT%\Assembly-CSharp" || exit /b 1
call :link "%ROOT%\Assets\Plugins\Assembly-CSharp-firstpass" "%ROOT%\Assembly-CSharp-firstpass" || exit /b 1
exit /b 0
:link
if exist "%~1\*" exit /b 0
if exist "%~1" ( echo %~1 exists but is not a folder - remove it and run again. & exit /b 1 )
mklink /J "%~1" "%~2" >nul || ( echo Could not create the link %~1 & exit /b 1 )
echo linked %~1 -^> %~2
exit /b 0
