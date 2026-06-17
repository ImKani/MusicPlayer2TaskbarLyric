$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$workspace = Resolve-Path (Join-Path $root "..")
$musicPlayer2 = Join-Path $workspace "MusicPlayer2\MusicPlayer2"
$plugins = Join-Path $workspace "TrafficMonitorPlugins"
$buildTools = "C:\BuildTools\Common7\Tools\VsDevCmd.bat"
$sdkVersion = "10.0.26100.0"
$releaseDir = Join-Path $root "release\x64"

if (!(Test-Path $buildTools)) {
    throw "VsDevCmd.bat not found: $buildTools"
}

New-Item -ItemType Directory -Force -Path $releaseDir | Out-Null

Write-Host "Building patched MusicPlayer2 x64 Release..."
cmd /c "cd /d `"$musicPlayer2`" && .\print_compile_time.bat && call `"$buildTools`" -arch=x64 -host_arch=x64 >nul && msbuild MusicPlayer2.vcxproj /p:Configuration=Release /p:Platform=x64 /p:PreBuildEventUseInBuild=false /p:WindowsTargetPlatformVersion=$sdkVersion /m"
if ($LASTEXITCODE -ne 0) {
    throw "MusicPlayer2 build failed with exit code $LASTEXITCODE"
}

Write-Host "Building TrafficMonitor MusicPlayer2Lyric plugin x64 Release..."
cmd /c "call `"$buildTools`" -arch=x64 -host_arch=x64 >nul && pushd `"$plugins`" && msbuild TrafficMonitorPlugins.sln /t:MusicPlayer2Lyric /p:Configuration=Release /p:Platform=x64 /m"
if ($LASTEXITCODE -ne 0) {
    throw "MusicPlayer2Lyric plugin build failed with exit code $LASTEXITCODE"
}

Copy-Item -LiteralPath (Join-Path $musicPlayer2 "x64\Release\MusicPlayer2.exe") -Destination (Join-Path $releaseDir "MusicPlayer2.exe") -Force
Copy-Item -LiteralPath (Join-Path $plugins "bin\x64\Release\MusicPlayer2Lyric.dll") -Destination (Join-Path $releaseDir "MusicPlayer2Lyric.dll") -Force

Write-Host "Release refreshed:"
Get-ChildItem -LiteralPath $releaseDir | Select-Object FullName,Length,LastWriteTime

