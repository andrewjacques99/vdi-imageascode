Write-Output 'MicrosoftOneDrive Start'
#If c:\CustomizerArtifacts directory doesnt exist then create it
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)) {
    New-Item  -ItemType Directory $BuildDir
}
#Get all MS OneDrive installers
$allInstallers = Find-EvergreenApp -Name MicrosoftOneDrive | Get-EvergreenApp
#Filter 'Production' ring installers
$prodInstallers = $allInstallers | Where-Object { $_.Ring -eq 'Production'}
#Filter 'exe' type installers
$exeInstallers = $prodInstallers | Where-Object { $_.Type -eq 'exe'}
#Filter 'AMD64' architecture installers
$AMD64Installers = $prodInstallers | Where-Object { $_.Architecture -eq 'AMD64'}
#Filter the most recent installer version
$mostRecent = $AMD64Installers | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
#Get the most recent installer version
$myInstaller = $AMD64Installers | Where-Object { $_.version -eq $mostRecent }
$fileName = split-path $myInstaller.uri -Leaf
$outFile = join-path 'c:\CustomizerArtifacts' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myInstaller.uri -OutFile $outFile
}
#Install OneDrive
Start-Process -FilePath $outFile -Argument "/allusers /SILENT" -Wait
#Remove install file
Remove-Item $outFile
Write-Output 'MicrosoftOneDrive Installed'
