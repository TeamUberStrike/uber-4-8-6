@echo off
setlocal
call "%~dp0config.bat"
echo.
echo === Unity 4.6.5f1 setup ===
echo This uses the public kit https://github.com/constripacity/unity-4.6.5f1
echo (Mono certificates, editor prefs, offline licence file, launcher). You activate
echo your OWN free Unity Personal licence with your Unity ID during the kit's setup.
echo.
if not exist "%UNITY465_EXE%" (
  echo Unity 4.6.5f1 is not installed at "%UNITY465_EXE%".
  echo 1. Download "Unity 4.6.5" for Windows from https://unity.com/releases/editor/archive
  echo 2. Install it to %USERPROFILE%\Unity4.6.5   ^(or set UNITY465_EXE to your Unity.exe^)
  echo 3. Run this script again.
  start "" "https://unity.com/releases/editor/archive"
  exit /b 1
)
where git >nul 2>nul || ( echo Git is required: https://git-scm.com/download/win & exit /b 1 )
if exist "%UNITY465_KIT%\.git" (
  echo Updating the kit in %UNITY465_KIT% ...
  git -C "%UNITY465_KIT%" pull --ff-only
) else (
  echo Downloading the kit to %UNITY465_KIT% ...
  git clone https://github.com/constripacity/unity-4.6.5f1 "%UNITY465_KIT%" || exit /b 1
)
echo Starting the kit's setup (it asks for administrator rights) ...
call "%UNITY465_KIT%\setup.cmd"
