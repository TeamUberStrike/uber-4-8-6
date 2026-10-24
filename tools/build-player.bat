@echo off
setlocal
call "%~dp0config.bat"
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
if exist "%REPO_ROOT%\EmbeddedResources\Assembly-CSharp" call :embed || exit /b 1
type "%BUILD_DIR%\build_result.txt"
echo.
echo Done: %BUILD_DIR%\UberStrike.exe   - start it with tools\launch-client.bat
exit /b 0

:embed
rem Unity cannot embed resources when compiling scripts; add them to the built Assembly-CSharp.dll like the team build.
set "CSC=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe"
for %%I in ("%UNITY465_EXE%") do set "UNITY_MANAGED=%%~dpIData\Managed"
if not exist "%~dp0Mono.Cecil.dll" copy /y "%UNITY_MANAGED%\Mono.Cecil.dll" "%~dp0" >nul
if not exist "%~dp0EmbedResources.exe" "%CSC%" /nologo /out:"%~dp0EmbedResources.exe" /r:"%~dp0Mono.Cecil.dll" "%~dp0EmbedResources.cs" || ( echo Could not compile tools\EmbedResources.cs & exit /b 1 )
"%~dp0EmbedResources.exe" "%BUILD_DIR%\UberStrike_Data\Managed\Assembly-CSharp.dll" "%REPO_ROOT%\EmbeddedResources\Assembly-CSharp" || ( echo Embedding resources failed & exit /b 1 )
exit /b 0
