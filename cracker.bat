@echo off
:: 设置日志记录
set logpath=%~dp0logs
set logfile=%logpath%\cleanup_%date:~0,4%%date:~5,2%%date:~8,2%.log
if not exist "%logpath%" mkdir "%logpath%"

:: 使用 >> 来追加日志而不是覆盖
echo. >> "%logfile%"
echo ========================================== >> "%logfile%"
echo Started registry cleanup at %date% %time% >> "%logfile%"

:: 执行注册表清理
echo Cleaning Update registry key... >> "%logfile%"
reg delete "HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Update" /f >> "%logfile%" 2>&1

echo Cleaning Registration keys... >> "%logfile%"
for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium" /s | findstr /L Registration"') do (
    echo Deleting: %%i >> "%logfile%"
    reg delete %%i /va /f >> "%logfile%" 2>&1
)

echo Cleaning CLSID entries... >> "%logfile%"
for /f "tokens=*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Classes\CLSID"') do (
    set "found="
    for /f "tokens=*" %%l in ('reg query "%%a" /f "Info" /s /e ^| findstr /i "Info"') do set found=1
    for /f "tokens=*" %%l in ('reg query "%%a" /f "ShellFolder" /s /e ^| findstr /i "ShellFolder"') do set found=1
    if defined found (
        echo Deleting CLSID: %%a >> "%logfile%"
        reg delete "%%a" /f >> "%logfile%" 2>&1
    )
)

:: 清理7天前的日志（改进错误处理）
echo. >> "%logfile%"
echo Checking for old logs to clean... >> "%logfile%"
dir /b "%logpath%\*.log" > nul 2>&1
if %errorlevel% equ 0 (
    forfiles /p "%logpath%" /m *.log /d -7 /c "cmd /c del @file" 2>nul
    if %errorlevel% equ 0 (
        echo Old logs cleaned successfully >> "%logfile%"
    ) else (
        echo No logs older than 7 days found >> "%logfile%"
    )
) else (
    echo No log files found to clean >> "%logfile%"
)

echo. >> "%logfile%"
echo Completed registry cleanup at %date% %time% >> "%logfile%"
echo ========================================== >> "%logfile%"