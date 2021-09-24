Write-Output 'Chrome Start'
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)) {
    New-Item  -ItemType Directory $BuildDir
}
$allVersions = Find-EvergreenApp -Name GoogleChrome | Get-EvergreenApp
$mostRecent = $allVersions | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
$allOnVersion = $allVersions | Where-Object { $_.version -eq $mostRecent }
$myVersion = $allOnVersion | Where-Object { $_.Architecture -eq 'x64'}
$fileName = split-path $myVersion.uri -Leaf
$outFile = join-path 'c:\CustomizerArtifacts' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myVersion.uri -OutFile $outFile
}
Start-Process -FilePath msiexec.exe -Argument "/i $outFile /qn" -Wait
Remove-Item $outFile
Write-Output 'Chrome Installed'
