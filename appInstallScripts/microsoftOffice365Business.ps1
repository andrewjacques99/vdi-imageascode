#Install MS Office365 Business
Write-Output 'MS Office365 Business Start'
#If c:\CustomizerArtifacts directory doesnt exist then create it
$odtDir = 'C:\TEMP\ODT'
if (-not(Test-Path $odtDir)) {
    New-Item -ItemType directory $odtDir
}
#Get the O365 business configuration file
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/andrewjacques99/vdi-imageascode/main/appInstallScripts/o365_business.xml" -OutFile "C:\TEMP\ODT\o365_business.xml"
#Get all MS Office installers
$allVersions = Find-EvergreenApp -Name Microsoft365Apps | Get-EvergreenApp
#Filter 'Current' channel installers
$currentInstallers = $allVersions | Where-Object { $_.Channel -eq 'Current'}
#Filter the most recent installer version
$mostRecent = $currentInstallers | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
#Get the most recent installer version
$myInstaller = $currentInstallers | Where-Object { $_.version -eq $mostRecent }
$fileName = split-path $myInstaller.uri -Leaf
$outFile = join-path 'C:\TEMP\ODT' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myInstaller.uri -OutFile $outFile
}
#Change directory
cd C:\TEMP\ODT\
#Download MS Office
Start-Process -FilePath $outFile -Argument "/download C:\TEMP\ODT\o365_business.xml" -Wait
#Install & configure MS Office
Start-Process -FilePath $outFile -Argument "/configure C:\TEMP\ODT\o365_business.xml" -Wait
#Remove installers
Remove-Item C:\TEMP\ODT\Office -Confirm:$false -Force -Recurse
Write-Output 'MS Office365 Business Installed'