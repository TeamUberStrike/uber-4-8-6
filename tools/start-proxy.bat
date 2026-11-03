@echo off
setlocal
call "%~dp0config.bat"
where node >nul 2>nul || ( echo Node.js is required: https://nodejs.org & exit /b 1 )
echo Proxy: http://127.0.0.1:8888  -^>  UberStrike web services on 127.0.0.1:5000
echo Keep this window open while you play. Ctrl+C stops it.
node "%REPO_ROOT%\svc_proxy.js"
