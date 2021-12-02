Write-Output 'VideoLanVlcPlayer Start'
#If c:\CustomizerArtifacts directory doesnt exist then create it
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)) {
    New-Item -ItemType Directory $BuildDir
}
#Get all Notepad++ installers
$allVersions = Find-EvergreenApp -Name VideoLanVlcPlayer | Get-EvergreenApp
#Filter 'x64' architecture installers
$x64Installers = $allVersions | Where-Object { $_.Architecture -eq 'x64'}
#Filter 'exe' type installers
$exeInstallers = $x64Installers | Where-Object { $_.Type -eq 'EXE'}
#Filter the most recent installer version
$mostRecent = $exeInstallers | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
#Get the most recent installer version
$myInstaller = $exeInstallers | Where-Object { $_.version -eq $mostRecent }
$fileName = split-path $myInstaller.uri -Leaf
$outFile = join-path 'c:\CustomizerArtifacts' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myInstaller.uri -OutFile $outFile
}
Start-Process -FilePath $outFile -Argument "/S" -Wait
Remove-Item $outFile
Write-Output 'VideoLanVlcPlayer Installed'