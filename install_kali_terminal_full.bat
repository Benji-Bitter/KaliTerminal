@echo off
setlocal enabledelayedexpansion

echo Installing full cinematic Kali terminal... hang tight g.

:: Create install folder
set "KF=%USERPROFILE%\KaliTerm"
if not exist "%KF%" mkdir "%KF%"

echo [+] Created install folder at %KF%

:: =======================
::   CMD VERSION
:: =======================
(
echo @echo off
echo title Kali Linux - CMD Edition
echo cls
echo reg add HKCU\Console /f /v VirtualTerminalLevel /t REG_DWORD /d 1 ^>nul
:: Red skull
echo set "skull=[38;2;255;0;0m   (^_^)   [0m"
:: White Dragon ASCII
echo set "dragon=[97m
echo           /\\
echo          /  \\      ___
echo         ^|    ^|    /   \\
echo        /      \\  /     \\
echo       ^|   ◣     ◢      ^|
echo       ^|    \\___/       ^|
echo        \\               /
echo         \\    FIRE     /
echo          \\___________/
echo [0m"
:: Typing SFX function
echo :playsfx
echo powershell -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\Windows Unlock.wav').PlaySync()" 2^>nul
echo goto :eof

:: Exploding fire frames
echo set "fire1=[91m*  *  *[0m"
echo set "fire2=[91m * * * [0m"
echo set "fire3=[91m*   *   *[0m"

:: Boot splash
echo cls
echo echo [97m          /\       
echo echo         /  \      ___
echo echo        ^|    ^|    /   \\
echo echo       /      \\  /     \\
echo echo      ^|   ◣     ◢      ^|
echo echo      ^|    \\___/       ^|
echo echo       \\               /
echo echo        \\   BOOTING    /
echo echo         \\___________/ [0m
echo timeout /t 2 >nul

:: Main loop
echo :loop
echo cls
echo echo =====================================
echo echo       KALI LINUX ^(CMD MODE^)
echo echo =====================================
echo echo.
echo echo %%skull%%
echo echo.
echo echo %%dragon%%
echo echo.
echo rem Fire explosion animation
echo echo %%fire1%%
echo timeout /t 0.2 >nul
echo echo %%fire2%%
echo timeout /t 0.2 >nul
echo echo %%fire3%%
echo timeout /t 0.2 >nul
echo echo.
echo call :playsfx
echo set /p cmd="kali@windows:~$ "
echo ^^!cmd^^!
echo goto loop
) > "%KF%\kali_cmd.bat"

echo [+] CMD version installed with fire & typing SFX.


:: =======================
::   POWERSHELL VERSION
:: =======================
(
echo ^# PowerShell Kali Terminal
echo ^[Console]::OutputEncoding = ^[System.Text.Encoding]::UTF8
echo Clear-Host
echo $Host.UI.RawUI.WindowTitle = "Kali Linux - PowerShell Edition"

:: Typing SFX
echo $player = New-Object System.Media.SoundPlayer "C:\Windows\Media\Windows Unlock.wav"
echo $player.Play()

:: Gradient Skull
echo $skull = @(
echo "`e[38;2;255;255;255m(^_^)`e[0m",
echo "`e[38;2;255;180;180m(^_^)`e[0m",
echo "`e[38;2;255;120;120m(^_^)`e[0m",
echo "`e[38;2;255;60;60m(^_^)`e[0m",
echo "`e[38;2;255;0;0m(^_^)`e[0m"
echo )

:: Red Dragon ASCII
echo $dragon = @"
echo `e[91m
echo           /\       
echo          /  \      ___
echo         ^|    ^|    /   \
echo        /      \  /     \
echo       ^|   ◣     ◢      ^|
echo       ^|    \___/       ^|
echo        \               /
echo         \    FIRE     /
echo          \___________/
echo `e[0m
echo "@

:: Matrix rain setup
echo $cols = [Console]::WindowWidth
echo $rows = [Console]::WindowHeight
echo $matrix = 1..$cols | ForEach-Object { 0 }
echo function Draw-Matrix {
echo   for ($i=0; $i -lt $cols; $i++) {
echo     if (Get-Random -gt 0.9) { $matrix[$i] = 0 }
echo     $matrix[$i]++
echo     $y = $matrix[$i] % $rows
echo     Write-Host (" " * $i + "|") -NoNewline -ForegroundColor Green
echo   }
echo   Write-Host ""
echo }

:: Aliases
echo Set-Alias ls Get-ChildItem
echo Set-Alias apt winget
echo Set-Alias ifconfig ipconfig
echo Set-Alias clear Clear-Host
echo Set-Alias cat Get-Content
echo Set-Alias grep Select-String

:: Theme override
echo $Host.UI.RawUI.ForegroundColor = "Cyan"
echo $Host.UI.RawUI.BackgroundColor = "Black"
echo Clear-Host

:: Main loop
echo while ($true) {
echo   Clear-Host
echo   Draw-Matrix
echo   foreach ($f in $skull) {
echo     Write-Host $f
echo     Write-Host $dragon
echo     Write-Host "`e[38;2;0;200;255mkali@windows`e[0m:`e[38;2;255;255;255m~`e[0m$ "
echo     Start-Sleep -Milliseconds 150
echo   }
echo }
) > "%KF%\kali_ps.ps1"

echo [+] PowerShell version installed with Matrix, HUD, and SFX.


:: =======================
::   LAUNCHER
:: =======================
(
echo @echo off
echo if defined PSModulePath (
echo powershell -ExecutionPolicy Bypass -File "%KF%\kali_ps.ps1"
echo ) else (
echo call "%KF%\kali_cmd.bat"
echo )
) > "%KF%\kali_launcher.bat"

echo [+] Launcher installed.


:: =======================
::   AUTO-RUN
:: =======================
:: CMD AutoRun
set "RUNKEY=HKCU\Software\Microsoft\Command Processor"
reg add "%RUNKEY%" /v AutoRun /t REG_SZ /d "\"%KF%\kali_launcher.bat\"" /f
:: PowerShell profile
if not exist "%USERPROFILE%\Documents\PowerShell" mkdir "%USERPROFILE%\Documents\PowerShell"
set "PSP=%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
echo Start-Process "%KF%\kali_launcher.bat" > "%PSP%"

echo [+] Auto-run setup complete.
echo ================================
echo       INSTALL COMPLETE MY G
echo ================================
pause
exit /b
