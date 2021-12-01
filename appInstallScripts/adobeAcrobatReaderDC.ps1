Write-Output 'AdobeAcrobatReaderDC Start'
#If c:\CustomizerArtifacts directory doesnt exist then create it
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)) {
    New-Item  -ItemType Directory $BuildDir
}
#Get all MS OneDrive installers
$allVersions = Find-EvergreenApp -Name AdobeAcrobatReaderDC | Get-EvergreenApp
#Filter 'English (UK)' Language installers
$ukInstallers = $allVersions | Where-Object { $_.Language -eq 'English (UK)'}
#Filter 'x64' architecture installers
$x64Installers = $ukInstallers | Where-Object { $_.Architecture -eq 'x64'}
#Filter the most recent installer version
$mostRecent = $x64Installers | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
#Get the most recent installer version
$myInstaller = $x64Installers | Where-Object { $_.version -eq $mostRecent }
$fileName = split-path $myInstaller.uri -Leaf
$outFile = join-path 'c:\CustomizerArtifacts' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myInstaller.uri -OutFile $outFile
}
Start-Process -FilePath $outFile -Argument "/sAll /rs /msi EULA_ACCEPT=YES" -Wait
Remove-Item $outFile
Write-Output 'AdobeAcrobatReaderDC Installed'
