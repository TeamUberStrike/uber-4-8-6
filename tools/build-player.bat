@echo off
setlocal
call "%~dp0config.bat"
call "%~dp0setup-links.bat" || exit /b 1
if not "%~1"=="" set "BUILD_DIR=%~f1"
if not exist "%UNITY465_EXE%" ( echo Unity 4.6.5 not found at "%UNITY465_EXE%". Run tools\setup-unity-4.6.5.bat first. & exit /b 1 )
tasklist /fi "imagename eq Unity.exe" 2>nul | findstr /i /c:"Unity.exe" >nul && ( echo Close the Unity editor first - a project can only be open once. & exit /b 1 )
if not exist "%REPO_ROOT%\Build" mkdir "%REPO_ROOT%\Build"
if exist "%BUILD_DIR%\build_result.txt" del "%BUILD_DIR%\build_result.txt"

set ATTEMPT=1
:build
echo.
echo === Building UberStrike 4.7.1 to %BUILD_DIR% (attempt %ATTEMPT%) ===
echo Unity opens its window during the build. If it says "license has expired", click Re-activate.
start "" /wait "%UNITY465_EXE%" -projectPath "%REPO_ROOT%" -executeMethod ReleaseBuild.Build -releaseOut "%BUILD_DIR%" -logFile "%REPO_ROOT%\Build\build.log"
if exist "%BUILD_DIR%\UberStrike.exe" if exist "%BUILD_DIR%\build_result.txt" goto :copy
rem After scripts are added or removed the first start only re-imports; a second start builds.
if "%ATTEMPT%"=="1" (
  set "ATTEMPT=2"
  goto :build
)
echo BUILD FAILED - see %REPO_ROOT%\Build\build.log  (search for "error CS")
exit /b 1

:copy
copy /y "%REPO_ROOT%\steam_appid.txt" "%BUILD_DIR%\" >nul
copy /y "%REPO_ROOT%\steam_api.dll" "%BUILD_DIR%\" >nul
if exist "%REPO_ROOT%\PlayerFiles" xcopy /e /i /y /q "%REPO_ROOT%\PlayerFiles\*" "%BUILD_DIR%\" >nul
if exist "%UBERSTRIKE_STEAM_DIR%\uberdaemon.exe" (
  copy /y "%UBERSTRIKE_STEAM_DIR%\uberdaemon.exe" "%BUILD_DIR%\" >nul
) else (
  echo NOTE: uberdaemon.exe not found in "%UBERSTRIKE_STEAM_DIR%".
  echo       Copy it from your Steam UberStrike folder next to UberStrike.exe, or set UBERSTRIKE_STEAM_DIR.
)
rem UberKill.BoxLoader copies sharedassets7.normal or .bluebox over sharedassets7.assets when a room or training starts.
if exist "%REPO_ROOT%\Assets\Scripts\Assembly-CSharp\UberKill.cs" call :bluebox || exit /b 1
type "%BUILD_DIR%\build_result.txt"
echo.
echo Done: %BUILD_DIR%\UberStrike.exe   - start it with tools\launch-client.bat
exit /b 0

:bluebox
rem Same edit as the patcher's sharedassets7.bluebox, made from this build's own file.
set "CSC=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe"
copy /y "%BUILD_DIR%\UberStrike_Data\sharedassets7.assets" "%BUILD_DIR%\UberStrike_Data\sharedassets7.normal" >nul
if not exist "%~dp0MakeBluebox.exe" "%CSC%" /nologo /out:"%~dp0MakeBluebox.exe" "%~dp0MakeBluebox.cs" || ( echo Could not compile tools\MakeBluebox.cs & exit /b 1 )
"%~dp0MakeBluebox.exe" "%BUILD_DIR%\UberStrike_Data\sharedassets7.assets" "%~dp0bluebox\InsideGrayAlt_1.dxt5" "%BUILD_DIR%\UberStrike_Data\sharedassets7.bluebox" || ( echo Making sharedassets7.bluebox failed & exit /b 1 )
exit /b 0
