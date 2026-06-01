@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo.
echo ============================================
echo   WASD + Performance Tweak
echo   Alle Optimierungen kombiniert
echo ============================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [FEHLER] Dieses Script benötigt Administratorrechte!
    echo Bitte als Administrator ausführen.
    echo.
    pause
    exit /b 1
)

echo [INFO] Administratorrechte erkannt.
echo.

set /p CONFIRM="Drücken Sie 1 um den Ultimate Tweak auszuführen: "
if not "!CONFIRM!"=="1" (
    echo Abgebrochen.
    pause
    exit /b 0
)

echo.
echo ============================================
echo   TASTATUR-OPTIMIERUNGEN
echo ============================================
echo.

echo [1/25] Tastatur KeyRepeat-Einstellungen optimieren...

reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] KeyboardDelay auf 0 gesetzt
) else (
    echo     [WARNUNG] KeyboardDelay konnte nicht gesetzt werden
)

reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d "31" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] KeyboardSpeed auf 31 gesetzt
) else (
    echo     [WARNUNG] KeyboardSpeed konnte nicht gesetzt werden
)

echo.

echo [2/25] Tastatur-Filter-Treiber optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d "50" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] KeyboardDataQueueSize auf 50 gesetzt (optimiert)
) else (
    echo     [WARNUNG] KeyboardDataQueueSize konnte nicht gesetzt werden
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v ConnectMultiplePorts /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] ConnectMultiplePorts optimiert
) else (
    echo     [INFO] ConnectMultiplePorts nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v MaximumPortsServiced /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MaximumPortsServiced auf 1 gesetzt
) else (
    echo     [INFO] MaximumPortsServiced nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v SendOutputToAllPorts /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] SendOutputToAllPorts optimiert
) else (
    echo     [INFO] SendOutputToAllPorts nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v PollingIterations /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] PollingIterations auf 1 gesetzt
) else (
    echo     [WARNUNG] PollingIterations konnte nicht gesetzt werden
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v PollingIterationsMaximum /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] PollingIterationsMaximum auf 1 gesetzt
) else (
    echo     [WARNUNG] PollingIterationsMaximum konnte nicht gesetzt werden
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v PollingIterationsMask /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] PollingIterationsMask auf 0 gesetzt
) else (
    echo     [WARNUNG] PollingIterationsMask konnte nicht gesetzt werden
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v ResendIterations /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] ResendIterations auf 1 gesetzt
) else (
    echo     [INFO] ResendIterations nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v EnableKeyboardQueue /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] EnableKeyboardQueue aktiviert
) else (
    echo     [INFO] EnableKeyboardQueue nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d "50" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] i8042prt KeyboardDataQueueSize auf 50 gesetzt (optimiert)
) else (
    echo     [INFO] i8042prt KeyboardDataQueueSize nicht verfügbar
)

echo.

echo [3/25] USB-Tastatur-Polling optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbinput\Parameters" /v PollingIntervalMinimum /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] USB PollingIntervalMinimum auf 1 gesetzt
) else (
    echo     [INFO] USB-Tastatur-Polling-Einstellungen nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbinput\Parameters" /v PollingIntervalMaximum /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] USB PollingIntervalMaximum auf 1 gesetzt
) else (
    echo     [INFO] USB PollingIntervalMaximum nicht verfügbar
)

echo.

echo [4/25] Tastatur-Filter optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbfiltr\Parameters" /v PollingIterations /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] kbfiltr PollingIterations auf 1 gesetzt
) else (
    echo     [INFO] kbfiltr nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbfiltr\Parameters" /v PollingIterationsMaximum /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] kbfiltr PollingIterationsMaximum auf 1 gesetzt
) else (
    echo     [INFO] kbfiltr PollingIterationsMaximum nicht verfügbar
)

echo.

echo [5/25] HID-Tastatur optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdhid\Parameters" /v KeyboardDataQueueLength /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] HID KeyboardDataQueueLength auf 1 gesetzt
) else (
    echo     [INFO] HID KeyboardDataQueueLength nicht verfügbar
)

echo.

echo [6/25] Keyboard Layout optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v Attributes /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Keyboard Layout Attributes optimiert
) else (
    echo     [INFO] Keyboard Layout Attributes nicht verfügbar
)

echo.

echo ============================================
echo   MAUS-OPTIMIERUNGEN
echo ============================================
echo.

echo [7/25] Maus-Input Queue optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d "50" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] mouclass MouseDataQueueSize auf 50 gesetzt (optimiert)
) else (
    echo     [WARNUNG] MouseDataQueueSize konnte nicht gesetzt werden
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v MouseDataQueueSize /t REG_DWORD /d "50" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] i8042prt MouseDataQueueSize auf 50 gesetzt (optimiert)
) else (
    echo     [INFO] i8042prt MouseDataQueueSize nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbinput\Parameters" /v MouseDataQueueSize /t REG_DWORD /d "50" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] USB MouseDataQueueSize auf 50 gesetzt (optimiert)
) else (
    echo     [INFO] USB MouseDataQueueSize nicht verfügbar
)

echo.

echo [8/25] HID-Maus optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouhid\Parameters" /v MouseDataQueueLength /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] HID MouseDataQueueLength auf 1 gesetzt
) else (
    echo     [INFO] HID MouseDataQueueLength nicht verfügbar
)

echo.

echo [9/25] Maus-Filter-Treiber optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v MousePollingIterations /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MousePollingIterations auf 1 gesetzt
) else (
    echo     [INFO] MousePollingIterations nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v MousePollingIterationsMaximum /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MousePollingIterationsMaximum auf 1 gesetzt
) else (
    echo     [INFO] MousePollingIterationsMaximum nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v MousePollingIterationsMask /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MousePollingIterationsMask auf 0 gesetzt
) else (
    echo     [INFO] MousePollingIterationsMask nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v EnableMouseQueue /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] EnableMouseQueue aktiviert
) else (
    echo     [INFO] EnableMouseQueue nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v MouseSynchIn100ns /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MouseSynchIn100ns auf 0 gesetzt (minimale Synchronisation)
) else (
    echo     [INFO] MouseSynchIn100ns nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v MouseResolution /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MouseResolution optimiert
) else (
    echo     [INFO] MouseResolution nicht verfügbar
)

echo.

echo [10/25] USB-Maus-Polling optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbinput\Parameters" /v MousePollingIntervalMinimum /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] USB MousePollingIntervalMinimum auf 1 gesetzt
) else (
    echo     [INFO] USB MousePollingIntervalMinimum nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbinput\Parameters" /v MousePollingIntervalMaximum /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] USB MousePollingIntervalMaximum auf 1 gesetzt
) else (
    echo     [INFO] USB MousePollingIntervalMaximum nicht verfügbar
)

echo.

echo [11/25] Maus-Filter optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\moufiltr\Parameters" /v PollingIterations /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] moufiltr PollingIterations auf 1 gesetzt
) else (
    echo     [INFO] moufiltr nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\moufiltr\Parameters" /v PollingIterationsMaximum /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] moufiltr PollingIterationsMaximum auf 1 gesetzt
) else (
    echo     [INFO] moufiltr PollingIterationsMaximum nicht verfügbar
)

echo.

echo [12/25] Maus-Klassentreiber optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v ConnectMultiplePorts /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] ConnectMultiplePorts optimiert
) else (
    echo     [INFO] ConnectMultiplePorts nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MaximumPortsServiced /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MaximumPortsServiced auf 1 gesetzt
) else (
    echo     [INFO] MaximumPortsServiced nicht verfügbar
)

echo.

echo [13/25] Maus-Pointer-Einstellungen optimieren...

reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MouseSpeed auf 0 gesetzt
) else (
    echo     [INFO] MouseSpeed nicht verfügbar
)

reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MouseThreshold1 auf 0 gesetzt
) else (
    echo     [INFO] MouseThreshold1 nicht verfügbar
)

reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] MouseThreshold2 auf 0 gesetzt
) else (
    echo     [INFO] MouseThreshold2 nicht verfügbar
)

echo.

echo ============================================
echo   HID-POLLING & RAWINPUT
echo ============================================
echo.

echo [14/25] HID-Polling optimieren...

for /f "tokens=*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\HID" /s /v "PollingPeriod" 2^>nul ^| findstr /i "HKEY"') do (
    reg add "%%i" /v PollingPeriod /t REG_DWORD /d "1" /f >nul 2>&1
    if !errorLevel! equ 0 (
        echo     [OK] HID PollingPeriod auf 1 gesetzt
    )
)

for /f "tokens=*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\HID" /s /v "EnhancedPowerManagementEnabled" 2^>nul ^| findstr /i "HKEY"') do (
    reg add "%%i" /v EnhancedPowerManagementEnabled /t REG_DWORD /d "0" /f >nul 2>&1
    if !errorLevel! equ 0 (
        echo     [OK] HID EnhancedPowerManagement deaktiviert
    )
)

echo.

echo [15/25] RawInput optimieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96f-e325-11ce-bfc1-08002be10318}\0000" /v "EnableImmersiveMode" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] RawInput Immersive Mode deaktiviert
) else (
    echo     [INFO] RawInput-Einstellungen nicht verfügbar
)

echo.

echo ============================================
echo   SYSTEM-OPTIMIERUNGEN
echo ============================================
echo.

echo [16/25] System-Feinabstimmung für maximale Reaktionsgeschwindigkeit...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d "26" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Win32PrioritySeparation auf 26 gesetzt
) else (
    echo     [INFO] Win32PrioritySeparation nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] SystemResponsiveness auf 0 gesetzt
) else (
    echo     [INFO] SystemResponsiveness nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Games Scheduling Category auf High gesetzt
) else (
    echo     [INFO] Games Scheduling Category nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Games Priority auf 6 gesetzt
) else (
    echo     [INFO] Games Priority nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Games Clock Rate auf 10000 gesetzt
) else (
    echo     [INFO] Games Clock Rate nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Pro Audio Scheduling Category optimiert
) else (
    echo     [INFO] Pro Audio Scheduling Category nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Pro Audio Priority optimiert
) else (
    echo     [INFO] Pro Audio Priority nicht verfügbar
)

echo.

echo [17/25] Windows Game Mode aktivieren...

reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Game Mode Auto-Aktivierung aktiviert
) else (
    echo     [INFO] Game Mode Auto-Aktivierung nicht verfügbar
)

reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v GameModeEnabled /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Game Mode aktiviert
) else (
    echo     [INFO] Game Mode nicht verfügbar
)

reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Auto Game Mode aktiviert
) else (
    echo     [INFO] Auto Game Mode nicht verfügbar
)

echo.

echo [18/25] Autostart-Einträge optimieren...

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "DisableStartupApps" /t REG_BINARY /d "020000000000000000000000" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Autostart-Optimierung aktiviert (User)
) else (
    echo     [INFO] Autostart-Optimierung nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "DisableStartupApps" /t REG_BINARY /d "020000000000000000000000" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Autostart-Optimierung aktiviert (System)
) else (
    echo     [INFO] Autostart-Optimierung nicht verfügbar
)

echo.

echo [19/25] NTFS Last Access Update deaktivieren...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] NTFS Last Access Update deaktiviert
) else (
    echo     [INFO] NTFS Last Access Update nicht verfügbar
)

echo.

echo ============================================
echo   POWER-MANAGEMENT
echo ============================================
echo.

echo [20/25] USB Selective Suspend deaktivieren...

powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] USB Selective Suspend deaktiviert (AC)
) else (
    echo     [WARNUNG] USB Selective Suspend konnte nicht deaktiviert werden
)

powercfg /setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

echo.

echo [21/25] Power Plan optimieren...

powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] High Performance Power Plan aktiviert
) else (
    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
    if %errorLevel% equ 0 (
        echo     [OK] Balanced Power Plan aktiviert
    ) else (
        echo     [WARNUNG] Power Plan konnte nicht geändert werden
    )
)

powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ed 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 b286c2e0-1b99-4e51-a9c3-4f18f748b538 0 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 06cadf0e-64ed-448a-8927-ce7bf90eb35d 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] CPU Power Management optimiert
) else (
    echo     [INFO] CPU Power Management nicht verfügbar
)

echo.

echo [22/25] PCI Express Power Management optimieren...

powercfg /setacvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] PCI Express Link State Power Management optimiert
) else (
    echo     [INFO] PCI Express Power Management nicht verfügbar
)

echo.

echo [23/25] USB Root Hub Power Management optimieren...

for /f "tokens=*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB" /s /v "PowerSettings" 2^>nul ^| findstr /i "HKEY.*ROOT"') do (
    reg add "%%i" /v PowerSettings /t REG_BINARY /d "0000000000000000" /f >nul 2>&1
    if !errorLevel! equ 0 (
        echo     [OK] USB Root Hub Power Management optimiert
    )
)

echo.

echo ============================================
echo   NETZWERK-OPTIMIERUNGEN
echo ============================================
echo.

echo [24/30] Netzwerk-Throttling optimieren...

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d "4294967295" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Network Throttling deaktiviert
) else (
    echo     [INFO] Network Throttling nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d "0" /f >nul 2>&1

echo.

echo ============================================
echo   FINALE OPTIMIERUNGEN
echo ============================================
echo.

echo [25/30] Konsistenz bei schnellen Bewegungsabläufen optimieren...

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Games Affinity optimiert
) else (
    echo     [INFO] Games Affinity nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Games Background Only optimiert
) else (
    echo     [INFO] Games Background Only nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Games SFIO Priority optimiert
) else (
    echo     [INFO] Games SFIO Priority nicht verfügbar
)

echo.

echo [26/30] Fullscreen Optimizations deaktivieren...

reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d "2" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Fullscreen Optimizations deaktiviert
) else (
    echo     [INFO] Fullscreen Optimizations nicht verfügbar
)

reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_DSEBehavior /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_EFSEFeatureFlags /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d "1" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo     [OK] GameDVR Fullscreen-Einstellungen optimiert
)

echo.

echo [27/30] GameDVR & Game Bar optimieren...

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] GameDVR App Capture deaktiviert
) else (
    echo     [INFO] GameDVR App Capture nicht verfügbar
)

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_Enabled /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AudioCaptureEnabled /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v MicrophoneCaptureEnabled /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v VideoEncodingBitrate /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v VideoEncodingResolutionMode /t REG_DWORD /d "0" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo     [OK] GameDVR-Einstellungen optimiert
)

reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v GameModeEnabled /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v GameBarEnabled /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Game Bar optimiert
) else (
    echo     [INFO] Game Bar nicht verfügbar
)

echo.

echo [28/30] TCP/IP Optimierungen...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpAckFrequency /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] TCP ACK Frequency optimiert
) else (
    echo     [INFO] TCP ACK Frequency nicht verfügbar
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPNoDelay /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpDelAckTicks /t REG_DWORD /d "0" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo     [OK] TCP/IP Latenz-Optimierungen aktiviert
)

echo.

echo [29/30] Weitere Multimedia-Scheduler-Optimierungen...

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo     [OK] Audio Task Scheduling optimiert
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo     [OK] Capture Task Scheduling optimiert
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo     [OK] Distribution Task Scheduling optimiert
)

echo.

echo [30/30] Windows Explorer Performance optimieren...

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewPane /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo     [OK] Explorer Preview Pane deaktiviert
) else (
    echo     [INFO] Explorer Preview Pane nicht verfügbar
)

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d "0" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo     [OK] Explorer Animationen optimiert
)

echo.

echo ============================================
echo   Tweak abgeschlossen!
echo ============================================
echo.
echo [INFO] Alle Tastatur-, Maus- und System-Optimierungen wurden vorgenommen.
echo.
echo [ERGEBNIS] Erwartete Verbesserungen:
echo           - Reaktionsschnelleres System
echo           - Gleichmäßigeres, extrem schnelles Bewegungsverhalten (WASD)
echo           - Präzisere Maussteuerung
echo           - Stabilere Gesamtperformance
echo           - Verbesserte Konsistenz bei schnellen Bewegungsabläufen
echo.
echo [HINWEIS] Ein Neustart wird empfohlen, damit alle
echo           Änderungen vollständig wirksam werden.
echo.
pause