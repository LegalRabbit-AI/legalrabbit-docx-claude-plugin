@echo off

setlocal enabledelayedexpansion
for /f "delims=" %%I in ("%~dp0..") do set "PLUGIN_DIR=%%~fI"

fsutil reparsepoint query "%PLUGIN_DIR%" 1>&2

if %ERRORLEVEL% EQU 0 (
    for %%I in ("%PLUGIN_DIR%") do (
        set "SYMLINK_NAME=%%~nxI"
    )

    for /f "tokens=2 delims=[]" %%A in ('dir /aL "%PLUGIN_DIR%\.." ^| findstr /C:"!SYMLINK_NAME!"') do (
        set "REAL_PATH=%%A"
    )

    echo Symlink name: !SYMLINK_NAME! 1>&2
    echo Real path: !REAL_PATH! 1>&2
    set "PLUGIN_DIR=!REAL_PATH!"
)

echo The plugin dir is: %PLUGIN_DIR% 1>&2

cd /d "%PLUGIN_DIR%"

:: Define the JSON file name
set "JSON_FILE=.codex-plugin\plugin.json"

:: Check if the file exists
if not exist "%JSON_FILE%" (
    echo Error: the plugin.json %JSON_FILE% not found.
    exit /b 1
)
:: Loop through the file to find the version line
for /f "tokens=1,2 delims=:" %%a in ('findstr /i "\"version\"" "%JSON_FILE%"') do (
    :: %%b contains the value (e.g., "0.2.0",)
    set "VERSION=%%b"

    :: Strip spaces, quotes, and commas
    set "VERSION=!VERSION: =!"
    set "VERSION=!VERSION:"=!"
    set "VERSION=!VERSION:,=!"
)

echo The version is: %VERSION%

set "APP_VERSION=%VERSION%"

call "scripts\prepare.bat" "%PLUGIN_DIR%" "%APP_VERSION%" > "output.log" 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo prepare.bat failed. See %PLUGIN_DIR%\output.log 1>&2
    exit /b 1
)

"bin\legalrabbit-docx-mcp.exe"
