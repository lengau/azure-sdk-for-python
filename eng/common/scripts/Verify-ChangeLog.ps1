# Wrapper Script for ChangeLog Verification
param (
  [String]$ChangeLogLocation,
  [String]$VersionString,
  [string]$PackageName,
  [string]$ServiceDirectory,
  [boolean]$ForRelease = $False
)

. (Join-Path $PSScriptRoot common.ps1)

Write-Host $args

$validChangeLog = $false
if ($ChangeLogLocation -and $VersionString) 
{
  $validChangeLog = Confirm-ChangeLogEntry -ChangeLogLocation $ChangeLogLocation -VersionString $VersionString -ForRelease $ForRelease
}
else
{
  $PackageProp = Get-PkgProperties -PackageName $PackageName -ServiceDirectory $ServiceDirectory
  Write-Host "Version $($PackageProp.Version)"
  $validChangeLog = Confirm-ChangeLogEntry -ChangeLogLocation $PackageProp.ChangeLogPath -VersionString $PackageProp.Version -ForRelease $ForRelease
}

if (!$validChangeLog)
{
  exit 1
}

exit 0