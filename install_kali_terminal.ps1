# --- Permanent Kali Terminal Installer ---
$ErrorActionPreference = "SilentlyContinue"

Write-Host "[*] Installing Kali Terminal Mods…" -ForegroundColor Cyan

# ------------------------
# PATHS
# ------------------------
$psProfile = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$cmdInit = "$HOME\cmd_init.cmd"

# Make PowerShell profile folder if missing
$psFolder = Split-Path $psProfile
if (!(Test-Path $psFolder)) { New-Item -ItemType Directory -Path $psFolder -Force }

# ------------------------
# CMD AUTORUN REGISTRY
# ------------------------
Write-Host "[*] Setting CMD AutoRun…" -ForegroundColor Cyan
reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "\"$cmdInit\"" /f | Out-Null

# ------------------------
# CMD THEME + ASCII DRAGON
# ------------------------
$cmdASCII = @"
color 0C

echo.
echo     (K A L I   D R A G O N)
echo.
echo                   /\
echo        __        (  )
echo      /'__`\      /  \
echo     /\ \/\ \   _/ /\ \__
echo     \ \ \ \ \ /\`'__\/'__`\
echo      \ \ \_\ \\ \ \//\ \/\ \
echo       \ \____/ \ \_\\ \_\ \_\
echo        \/___/   \/_/ \/_/\/_/
echo.
echo        ~~~ BREATHING FIRE ~~~

:: FIRE LOOP
for /l %%x in (1,1,6) do (
    cls
    echo                       (   )
    echo                       (   )
    echo                     ( FIRE )
    echo                       \ | /
    echo                        \|/
    echo                         V
    timeout /t 0 >nul
)

echo.
echo Welcome to CMD x KALI Mode
echo.
"@

Set-Content -Path $cmdInit -Value $cmdASCII -Encoding ASCII -Force

# ------------------------
# POWERSHELL CINEMATIC MODE
# ------------------------

$psStuff = @"
# ============================
# KALI POWERSHELL CINEMATIC
# ============================

# RED Kali Dragon Boot Splash
Write-Host ''
Write-Host '     /\\' -ForegroundColor Red
Write-Host '    (  )  K A L I  L O A D I N G' -ForegroundColor Red
Write-Host '   (    )' -ForegroundColor Red
Write-Host '  (      )' -ForegroundColor Red
Write-Host ' (        )' -ForegroundColor Red
Write-Host '==============' -ForegroundColor Red
Start-Sleep -Milliseconds 300

# Matrix Rain Background
1..40 | ForEach-Object {
    Write-Host ("$(Get-Random -Maximum 999999999999)" ) -ForegroundColor DarkGreen
    Start-Sleep -Milliseconds 20
}

Clear-Host

# WatchDogs‑style HUD overlay
Write-Host "[ HUD ONLINE ]" -ForegroundColor Cyan
Write-Host "[ NETWORK SNIFFERS: ACTIVE ]" -ForegroundColor Cyan
Write-Host "[ TERMINAL READY ]" -ForegroundColor Cyan
Write-Host ""

# Typing SFX
function Type-SFX {
    param([string]$t)
    $t.ToCharArray() | ForEach-Object {
        Write-Host -NoNewline $_
        [console]::beep(800,15)
    }
    Write-Host ""
}

Type-SFX "Welcome back, operator."

# Aliases (Kali style)
Set-Alias ls Get-ChildItem
Set-Alias apt winget
Set-Alias clear Clear-Host

# Red theme
$Host.UI.RawUI.ForegroundColor = "Red"
"@

Set-Content -Path $psProfile -Value $psStuff -Encoding UTF8 -Force

Write-Host "[✓] Install Complete." -ForegroundColor Green
Write-Host "[*] Restart CMD + PowerShell to see effects." -ForegroundColor Yellow
