$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$releaseDir = Join-Path $root "release\x64"
$distDir = Join-Path $root "dist"
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$packageDir = Join-Path $distDir "MusicPlayer2TaskbarLyric-x64-$stamp"

if (!(Test-Path (Join-Path $releaseDir "MusicPlayer2.exe"))) {
    throw "Missing release binary: MusicPlayer2.exe. Run .\scripts\build-release.ps1 first."
}

if (!(Test-Path (Join-Path $releaseDir "MusicPlayer2Lyric.dll"))) {
    throw "Missing release binary: MusicPlayer2Lyric.dll. Run .\scripts\build-release.ps1 first."
}

New-Item -ItemType Directory -Force -Path $packageDir | Out-Null
Copy-Item -LiteralPath (Join-Path $releaseDir "MusicPlayer2.exe") -Destination $packageDir -Force
Copy-Item -LiteralPath (Join-Path $releaseDir "MusicPlayer2Lyric.dll") -Destination $packageDir -Force
if (Test-Path (Join-Path $releaseDir "MusicPlayer2Lyric.ini.example")) {
    Copy-Item -LiteralPath (Join-Path $releaseDir "MusicPlayer2Lyric.ini.example") -Destination $packageDir -Force
}
Copy-Item -LiteralPath (Join-Path $root "README.md") -Destination $packageDir -Force

if (Test-Path (Join-Path $root "licenses")) {
    Copy-Item -LiteralPath (Join-Path $root "licenses") -Destination $packageDir -Recurse -Force
}

Write-Host "Package created:"
Get-ChildItem -LiteralPath $packageDir | Select-Object FullName,Length,LastWriteTime
