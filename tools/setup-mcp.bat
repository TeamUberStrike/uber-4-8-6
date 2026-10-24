@echo off
setlocal
call "%~dp0config.bat"
echo.
echo === ForgeRipper MCP (optional) ===
echo Lets Claude Code read and export assets from a Unity game folder (for example the Steam
echo client) through AssetRipper. Needs access to the private repo constripacity/ForgeRipper,
echo Git, Python 3.11+ and the .NET 8 SDK.
echo.
where git >nul 2>nul || ( echo Git is required: https://git-scm.com/download/win & exit /b 1 )
where python >nul 2>nul || ( echo Python 3.11+ is required: https://www.python.org/downloads/ & exit /b 1 )
if exist "%FORGERIPPER_DIR%\.git" (
  git -C "%FORGERIPPER_DIR%" pull --ff-only
) else (
  git clone https://github.com/constripacity/ForgeRipper "%FORGERIPPER_DIR%" || ( echo Clone failed - ask the repo owner for access. & exit /b 1 )
)
python -m pip install -e "%FORGERIPPER_DIR%" || exit /b 1

set "FR=%FORGERIPPER_DIR:\=/%"
> "%REPO_ROOT%\.mcp.json" echo {
>>"%REPO_ROOT%\.mcp.json" echo   "mcpServers": {
>>"%REPO_ROOT%\.mcp.json" echo     "forgeripper": {
>>"%REPO_ROOT%\.mcp.json" echo       "command": "python",
>>"%REPO_ROOT%\.mcp.json" echo       "args": ["-m", "bridge.mcp_server"],
>>"%REPO_ROOT%\.mcp.json" echo       "cwd": "%FR%"
>>"%REPO_ROOT%\.mcp.json" echo     }
>>"%REPO_ROOT%\.mcp.json" echo   }
>>"%REPO_ROOT%\.mcp.json" echo }
echo Wrote %REPO_ROOT%\.mcp.json (machine-specific, not committed).
echo Restart Claude Code in this folder and approve the "forgeripper" server.
echo AssetRipper listens on port 5000 like the UberStrike web services: run one or the other.
