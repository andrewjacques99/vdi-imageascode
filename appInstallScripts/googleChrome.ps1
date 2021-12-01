Write-Output 'Chrome Start'
#If c:\CustomizerArtifacts directory doesnt exist then create it
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)) {
    New-Item  -ItemType Directory $BuildDir
}
#Get all MS OneDrive installers
$allInstallers = Find-EvergreenApp -Name GoogleChrome | Get-EvergreenApp
#Filter 'stable' channel installers
$prodInstallers = $allInstallers | Where-Object { $_.Channel -eq 'stable'}
#Filter 'exe' type installers
$msiInstallers = $prodInstallers | Where-Object { $_.Type -eq 'msi'}
#Filter 'AMD64' architecture installers
$x64Installers = $prodInstallers | Where-Object { $_.Architecture -eq 'x64'}
#Filter the most recent installer version
$mostRecent = $x64Installers | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
#Get the most recent installer version
$myInstaller = $x64Installers | Where-Object { $_.version -eq $mostRecent }
$fileName = split-path $myInstaller.uri -Leaf
$outFile = join-path 'c:\CustomizerArtifacts' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myInstaller.uri -OutFile $outFile
}
Start-Process -FilePath msiexec.exe -Argument "/i $outFile /qn" -Wait
Remove-Item $outFile
Write-Output 'Chrome Installed'
