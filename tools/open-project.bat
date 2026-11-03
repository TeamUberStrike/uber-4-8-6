@echo off
setlocal
call "%~dp0config.bat"
if not exist "%UNITY465_EXE%" ( echo Unity 4.6.5 not found at "%UNITY465_EXE%". Run tools\setup-unity-4.6.5.bat first. & exit /b 1 )
echo Opening %REPO_ROOT% in Unity 4.6.5 ...
echo If Unity says "license has expired", click Re-activate.
start "" "%UNITY465_EXE%" -projectPath "%REPO_ROOT%"
