@echo off
setlocal
cd /d "%~dp0"

set "BUILD_ROOT=%LOCALAPPDATA%\WasdTweakLauncher-cmake-build"
for /f "delims=" %%H in ('powershell -NoProfile -Command "$p=(Get-Location).Path; $h=(New-Object Security.Cryptography.SHA256Managed).ComputeHash([Text.Encoding]::UTF8.GetBytes($p)); [BitConverter]::ToString($h).Replace('-','').Substring(0,16).ToLower()"') do set "SRC_HASH=%%H"
if not defined SRC_HASH (
  echo [ERROR] Konnte Build-Cache-Schluessel nicht erzeugen.
  exit /b 1
)
set "CMAKE_BUILD=%BUILD_ROOT%\%SRC_HASH%"
echo [INFO ] Build-Verzeichnis: "%CMAKE_BUILD%"

cmake -S . -B "%CMAKE_BUILD%" -G "Visual Studio 17 2022" -A x64
if errorlevel 1 exit /b 1

cmake --build "%CMAKE_BUILD%" --config Release -- /m:1
if errorlevel 1 exit /b 1

set "EXE_NAME=wasd+performance_runtime_tweaker_x64.exe"
set "OUT=%CMAKE_BUILD%\Release\%EXE_NAME%"
if not exist "%OUT%" (
  echo [ERROR] EXE nicht gefunden: "%OUT%"
  exit /b 1
)

copy /Y "%OUT%" "%~dp0%EXE_NAME%" >nul

echo.
echo [OK   ] %~dp0%EXE_NAME%
echo [HINT ] Lege "wasd tweak.bat" in denselben Ordner wie die EXE.
echo.
pause
exit /b 0
