param([ValidateSet('pybuilder', 'unittest', 'make', 'files')][string]$Evidence = 'pybuilder')

# Run real commands in a visible console and capture only that console window.
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path $PSScriptRoot -Parent)
$env:VIRTUALENV_OVERRIDE_APP_DATA = Join-Path $PWD '.build-cache/virtualenv'
$env:PIP_CACHE_DIR = Join-Path $PWD '.build-cache/pip'
$env:TEMP = Join-Path $PWD '.build-cache/tmp'
$env:TMP = $env:TEMP
New-Item -ItemType Directory -Force $env:TEMP | Out-Null
Add-Type -AssemblyName System.Drawing
Add-Type @'
using System;
using System.Runtime.InteropServices;
public class EvidenceWindow {
    [StructLayout(LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int command);
    [DllImport("user32.dll")] public static extern bool MoveWindow(IntPtr h, int x, int y, int w, int ht, bool repaint);
}
'@
$Host.UI.RawUI.WindowTitle = "Lab 6 - Batoul Hachem - $Evidence"
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
try {
    $Host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size(145, 3000)
    $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(145, 47)
} catch { }
$handle = [EvidenceWindow]::GetConsoleWindow()
[void][EvidenceWindow]::MoveWindow($handle, 10, 10, 1500, 1000, $true)
[void][EvidenceWindow]::SetForegroundWindow($handle)
Clear-Host
$log = Join-Path $PSScriptRoot "$Evidence.log"
Start-Transcript -Path $log -Force | Out-Null
Write-Host "LAB 6 - AUTOMATIC BUILD | Batoul Hachem"
Write-Host "Project: $PWD"
Write-Host ''
$global:LASTEXITCODE = 0
switch ($Evidence) {
    'pybuilder' {
        Write-Host "PS> pyb run_unit_tests"
        & pyb run_unit_tests
    }
    'unittest' {
        Write-Host "PS> python -m unittest discover -s tests/unittest/calculator_Batoul_Hachem -v"
        & python -m unittest discover -s tests/unittest/calculator_Batoul_Hachem -v
    }
    'make' {
        Write-Host "PS> make build"
        & make build
    }
    'files' {
        Write-Host 'PS> Get-ChildItem src,tests -Recurse -Filter *.py'
        Get-ChildItem src,tests -Recurse -Filter *.py | ForEach-Object { Write-Host $_.FullName.Replace("$PWD\", '') }
        Write-Host ''
        Write-Host 'PS> Get-ChildItem target/dist/*/dist'
        Get-ChildItem target/dist -Recurse -File | Where-Object { $_.Extension -in '.whl', '.gz' } | Select-Object Name, Length | Format-Table -AutoSize
    }
}
$commandExit = $LASTEXITCODE
if ($commandExit -ne 0) { throw "Evidence command failed with exit code $commandExit" }
Write-Host ''
Write-Host 'PS> ' -NoNewline
Stop-Transcript | Out-Null
[void][EvidenceWindow]::ShowWindow($handle, 9)
[void][EvidenceWindow]::MoveWindow($handle, 10, 10, 1500, 1000, $true)
[void][EvidenceWindow]::SetForegroundWindow($handle)
Start-Sleep -Milliseconds 1200
$rect = New-Object EvidenceWindow+RECT
[void][EvidenceWindow]::GetWindowRect($handle, [ref]$rect)
if ($rect.Right -le $rect.Left) { throw 'No visible console window found.' }
$bitmap = New-Object System.Drawing.Bitmap(($rect.Right - $rect.Left), ($rect.Bottom - $rect.Top))
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen($rect.Left, $rect.Top, 0, 0, $bitmap.Size)
$bitmap.Save((Join-Path $PSScriptRoot "$Evidence.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose()
$bitmap.Dispose()
Set-Content (Join-Path $PSScriptRoot "$Evidence.done") 'OK'
