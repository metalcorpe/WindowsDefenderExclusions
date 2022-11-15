$userPath = $env:USERPROFILE
$pathExclusions = New-Object System.Collections.ArrayList
$processExclusions = New-Object System.Collections.ArrayList
$extensionExclusions = New-Object System.Collections.ArrayList

$pathExclusions.Add('C:\Windows\Microsoft.NET') > $null
$pathExclusions.Add('C:\Windows\assembly') > $null
$pathExclusions.Add('C:\P4V') > $null
$pathExclusions.Add('C:\P4S') > $null
$pathExclusions.Add('C:\P4P') > $null
$pathExclusions.Add('C:\P4') > $null
$pathExclusions.Add('C:\DDC') > $null
$pathExclusions.Add('C:\Jenkins') > $null
$pathExclusions.Add('C:\_JenkinsMerge') > $null
$pathExclusions.Add('C:\JenkinsSlave') > $null
$pathExclusions.Add('C:\JenkinsWorkspaces') > $null
$pathExclusions.Add('C:\Staging') > $null


$pathExclusions.Add($userPath + '\.dotnet') > $null
$pathExclusions.Add($userPath + '\.librarymanager') > $null

$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VisualStudio') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VisualStudio Services') > $null
$pathExclusions.Add($userPath + '\AppData\Local\GitCredentialManager') > $null
$pathExclusions.Add($userPath + '\AppData\Local\GitHubVisualStudio') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\dotnet') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VSApplicationInsights') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VSCommon') > $null
$pathExclusions.Add($userPath + '\AppData\Local\Temp\VSFeedbackIntelliCodeLogs') > $null

$pathExclusions.Add($userPath + '\AppData\Roaming\Microsoft\VisualStudio') > $null
$pathExclusions.Add($userPath + '\AppData\Roaming\NuGet') > $null
$pathExclusions.Add($userPath + '\AppData\Roaming\Visual Studio Setup') > $null
$pathExclusions.Add($userPath + '\AppData\Roaming\vstelemetry') > $null
$pathExclusions.Add($userPath + '\AppData\Roaming\HeidiSQL') > $null

$pathExclusions.Add('C:\ProgramData\Microsoft\VisualStudio') > $null
$pathExclusions.Add('C:\ProgramData\Microsoft\NetFramework') > $null
$pathExclusions.Add('C:\ProgramData\Microsoft Visual Studio') > $null
$pathExclusions.Add('C:\ProgramData\MySQL') > $null

$pathExclusions.Add('C:\Program Files\Microsoft Visual Studio') > $null
$pathExclusions.Add('C:\Program Files\dotnet') > $null
$pathExclusions.Add('C:\Program Files\Microsoft SDKs') > $null
$pathExclusions.Add('C:\Program Files\Microsoft SQL Server') > $null
$pathExclusions.Add('C:\Program Files\MySQL') > $null
$pathExclusions.Add('C:\Program Files\IIS') > $null
$pathExclusions.Add('C:\Program Files\IIS Express') > $null
$pathExclusions.Add('C:\Program Files\Epic Games') > $null
$pathExclusions.Add('C:\Program Files\Perforce') > $null

$pathExclusions.Add('C:\Program Files (x86)\Microsoft Visual Studio') > $null
$pathExclusions.Add('C:\Program Files (x86)\dotnet') > $null
$pathExclusions.Add('C:\Program Files (x86)\Microsoft SDKs') > $null
$pathExclusions.Add('C:\Program Files (x86)\Microsoft SQL Server') > $null
$pathExclusions.Add('C:\Program Files (x86)\IIS') > $null
$pathExclusions.Add('C:\Program Files (x86)\IIS Express') > $null

$processExclusions.Add('ServiceHub.SettingsHost.exe') > $null
$processExclusions.Add('ServiceHub.IdentityHost.exe') > $null
$processExclusions.Add('ServiceHub.VSDetouredHost.exe') > $null
$processExclusions.Add('ServiceHub.Host.CLR.x86.exe') > $null
$processExclusions.Add('Microsoft.ServiceHub.Controller.exe') > $null
$processExclusions.Add('PerfWatson2.exe') > $null
$processExclusions.Add('sqlwriter.exe') > $null
$processExclusions.Add('cl.exe') > $null
$processExclusions.Add('link.exe') > $null
$processExclusions.Add('cl-filter.exe') > $null
$processExclusions.Add('link-filter.exe') > $null
$processExclusions.Add('devenv.exe') > $null
$processExclusions.Add('jp2launcher.exe') > $null
$processExclusions.Add('vcpkgsrv.exe') > $null
$processExclusions.Add('vctip.exe') > $null
$processExclusions.Add('VcxprojReader.exe') > $null
$processExclusions.Add('VaCodeInspectionsServer.exe') > $null
$processExclusions.Add('VaDbMtx64.exe') > $null
$processExclusions.Add('dotnet.exe') > $null
$processExclusions.Add('MSBuild.exe') > $null
$processExclusions.Add('UE4Editor.exe') > $null
$processExclusions.Add('UnrealEditor.exe') > $null
$processExclusions.Add('UnrealBuildTool.exe') > $null
$processExclusions.Add('UnrealHeaderTool.exe') > $null
$processExclusions.Add('UnrealPak.exe') > $null
$processExclusions.Add('AutomationTool.exe') > $null
$processExclusions.Add('ShaderCompileWorker.exe') > $null
$processExclusions.Add('p4ps.exe') > $null


$extensionExclusions.Add('.c') > $null
$extensionExclusions.Add('.cpp') > $null
$extensionExclusions.Add('.cs') > $null
$extensionExclusions.Add('.h') > $null
$extensionExclusions.Add('.hpp') > $null
$extensionExclusions.Add('.o') > $null
$extensionExclusions.Add('.pdb') > $null
$extensionExclusions.Add('.db') > $null
$extensionExclusions.Add('.sln') > $null
$extensionExclusions.Add('.vcxproj') > $null
$extensionExclusions.Add('.user') > $null
$extensionExclusions.Add('.uproject') > $null


Write-Host "This script will create Windows Defender exclusions for common Visual Studio 2022 folders and processes."
Write-Host ""


foreach ($exclusion in $pathExclusions) 
{
    Write-Host "Adding Path Exclusion: " $exclusion
    Add-MpPreference -ExclusionPath $exclusion
}

foreach ($exclusion in $processExclusions)
{
    Write-Host "Adding Process Exclusion: " $exclusion
    Add-MpPreference -ExclusionProcess $exclusion
}

foreach ($exclusion in $extensionExclusions)
{
    Write-Host "Adding Extension Exclusion: " $exclusion
    Add-MpPreference -ExclusionExtension $exclusion
}


Write-Host ""
Write-Host "Your Exclusions:"

$prefs = Get-MpPreference
$prefs.ExclusionPath
$prefs.ExclusionProcess
$prefs.ExclusionExtension

Write-Host ""
Write-Host "Enjoy faster build times and coding!"
Write-Host ""