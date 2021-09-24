Write-Output 'AdobeAcrobatReaderDC Start'
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)) {
    New-Item  -ItemType Directory $BuildDir
}
$allVersions = Find-EvergreenApp -Name AdobeAcrobatReaderDC | Get-EvergreenApp
$mostRecent = $allVersions | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
$allOnVersion = $allVersions | Where-Object { $_.version -eq $mostRecent }
$allOnArchitecture = $allOnVersion | Where-Object { $_.Architecture -eq 'x64'}
$myVersion = $allOnArchitecture | Where-Object { $_.Language -eq 'English (UK)'}
$fileName = split-path $myVersion.uri -Leaf
$outFile = join-path 'c:\CustomizerArtifacts' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myVersion.uri -OutFile $outFile
}
Start-Process -FilePath $outFile -Argument "/sAll /rs /msi EULA_ACCEPT=YES" -Wait
Remove-Item $outFile
Write-Output 'AdobeAcrobatReaderDC Installed'
