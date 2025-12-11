@echo off
title Kali CMD Installer
color 0A

echo Installing Kali-style CMD...
echo.

:: Path where the CMD theme script will live
set "KALI_DIR=%USERPROFILE%\KaliCMD"
set "KALI_SCRIPT=%KALI_DIR%\kali_start.cmd"

:: Create folder
if not exist "%KALI_DIR%" mkdir "%KALI_DIR%"

:: Write CMD theme script
(
echo @echo off
echo title Kali CMD Terminal
echo mode 120,40
echo color 0C
echo cls

echo :: ===============================
echo ::      RED SKULL INTRO
echo :: ===============================
echo echo.
echo echo      ████████████████████████
echo echo      ███      SKULL       ███
echo echo      ████████████████████████
echo echo.
echo echo             (x_x)
echo echo.

echo :: ===============================
echo ::      WHITE KALI DRAGON
echo :: ===============================
echo color 07
echo echo           /\\
echo echo      __  (  )   KALI DRAGON
echo echo    /'__^\\/  \\
echo echo    \ \ \ \ \__/ 
echo echo     \ \_\ \__/
echo echo      \/___/
echo echo.

echo :: ===============================
echo ::      FIRE BREATH ANIMATION
echo :: ===============================
echo for /l %%%%A in (1,1,5) do ^
(
echo   cls
echo   echo Dragon breathing fire...
echo   echo        ^>
echo   ping -n 1 localhost ^>nul
echo   cls
echo   echo Dragon breathing fire...
echo   echo        ^>^>^>
echo   ping -n 1 localhost ^>nul
echo )

echo :: ===============================
echo ::      MATRIX RAIN
echo :: ===============================
echo color 0A
echo for /l %%%%B in (1,1,150) do ^
(
echo   set /a N=%%random%% %% 9999999
echo   echo !N!
echo   ping -n 1 localhost ^>nul
echo )

echo :: ===============================
echo ::      WATCHDOGS HUD
echo :: ===============================
echo color 0B
echo cls
echo echo [*] SYSTEM ONLINE
echo echo [*] SENSORS ACTIVE
echo echo [*] TERMINAL READY
echo echo.

echo :: ===============================
echo ::      TYPING SFX BANNER
echo :: ===============================
echo set "msg=Welcome Operator..."
echo for /l %%%%i in (1,1,22) do ^
(
echo    set "ch=!msg:~%%%%i,1!"
echo    <nul set /p=!ch!
echo    powershell -c ^"[console]::beep(800,20)^"
echo )
echo echo.
echo echo [Kali CMD Loaded]
echo color 0A
) > "%KALI_SCRIPT%"

:: Enable CMD autorun permanently
reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "cmd /k \"%KALI_SCRIPT%\"" /f

echo.
echo Done.
echo Close this window and re-open CMD.
pause
exit
