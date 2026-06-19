@echo off

setlocal enabledelayedexpansion

set "PLUGIN_DIR=%~1"
set "APP_VERSION=%~2"

cd /d "%PLUGIN_DIR%"

echo The plugin dir is: %PLUGIN_DIR%

if not exist "bin" (
    mkdir "bin"
)

set "MCP_EXECUTABLE_PATH=bin\legalrabbit-docx-mcp.exe"

if exist "%MCP_EXECUTABLE_PATH%" (
    for %%A in ("%MCP_EXECUTABLE_PATH%") do (
        if %%~zA LSS 1024 (
            del /q "%MCP_EXECUTABLE_PATH%"
        )
    )
)

curl -R -L -s -f -z "%MCP_EXECUTABLE_PATH%" -o "%MCP_EXECUTABLE_PATH%.tmp" "https://github.com/LegalRabbit-AI/legalrabbit-docx-claude-plugin/releases/download/%APP_VERSION%/legalrabbit-docx-mcp.exe"

if %ERRORLEVEL% EQU 0 (
    if exist "%MCP_EXECUTABLE_PATH%.tmp" (
        move /y "%MCP_EXECUTABLE_PATH%.tmp" "%MCP_EXECUTABLE_PATH%"
        echo Downloaded %MCP_EXECUTABLE_PATH% successfully.
    ) else (
        echo The current legalrabbit-docx-mcp.exe is up-to-date.
    )
) else (
    if not exist "%MCP_EXECUTABLE_PATH%" (
        echo Downloading %MCP_EXECUTABLE_PATH% failed with error code: %ERRORLEVEL%
        exit /b 1
    )
)

set "ZIP_FILE_PATH=legalrabbit-docx.manifest"

if exist "%ZIP_FILE_PATH%" (
    for %%A in ("%ZIP_FILE_PATH%") do (
        if %%~zA LSS 1024 (
            del /q "%ZIP_FILE_PATH%"
        )
    )
)

curl -R -L -s -f -z "%ZIP_FILE_PATH%" -o "%ZIP_FILE_PATH%.tmp" "https://github.com/LegalRabbit-AI/legalrabbit-docx-claude-plugin/releases/download/%APP_VERSION%/legalrabbit-docx.manifest"

if %ERRORLEVEL% EQU 0 (
    if exist "%ZIP_FILE_PATH%.tmp" (
        move /y "%ZIP_FILE_PATH%.tmp" "%ZIP_FILE_PATH%" >nul
        echo Downloaded %ZIP_FILE_PATH% successfully.
    ) else (
        echo The current legalrabbit-docx.manifest is up-to-date.
    )
) else (
    if not exist "%ZIP_FILE_PATH%" (
        echo Downloading %ZIP_FILE_PATH% failed with error code: %ERRORLEVEL%
        exit /b 1
    )
)

if exist "agents" (
    rmdir /s /q "agents"
)

if exist "skills" (
    rmdir /s /q "skills"
)

"bin\legalrabbit-docx-mcp.exe" alohomora "%ZIP_FILE_PATH%"

if %ERRORLEVEL% NEQ 0 (
    echo unzipping failed with error code: %ERRORLEVEL%
    exit /b 1
)
