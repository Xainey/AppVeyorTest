<#
$res = Invoke-Pester -Path ".\Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\TestsResults.xml))
if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed."}
. .\Get-CustomBadge.ps1;
$badgeurl = (Get-CustomBadge -Subject "Test" -Status "Good" -Color green -ImageType png -ColorA ff0000)
$outfile = "$PSScriptRoot\badge.png"
(New-Object 'System.Net.WebClient').DownloadFile($badgeurl, "$PSScriptRoot\badge.png")
Push-AppveyorArtifact $outfile
#>

# Grab nuget bits
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

# Some CI/CD helper functions, set up some env variables
Install-Module BuildHelpers -Force
Import-Module BuildHelpers
Set-BuildEnvironment

# Display some details about the environment!
$lines = '-' * 60

"$lines`nPSVERSIONTABLE`n`n"
$PSVersionTable | Out-Host

"`n`n$lines`nBUILDHELPERS`n`n"
Get-Item ENV:BH* | Out-Host

"`n`n$lines`nMODULES`n`n"
Get-Module -ListAvailable | Select-Object Name, Version, Path | Sort-Object Name | Out-Host

"`n`n$lines`nENV`n`n"
Get-ChildItem ENV: | Out-Host

"`n`n$lines`nPSMODULEPATH`n`n"
$ENV:PSModulePath -Split ";" | Out-Host

"`n`n$lines`nPATH`n`n"
$ENV:PATH -Split ";" | Out-Host

"`n`n$lines`nVARIABLES`n`n"
Get-Variable | Out-Host

"`n`n$lines`nOther`n`n"
Get-Command Init
Get-Command