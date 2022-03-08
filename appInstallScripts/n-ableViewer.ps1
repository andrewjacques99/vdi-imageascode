echo 016-N-Able-Viewer-Start >> C:\\buildActions\\buildActionsOutput.txt
$outfile = "C:\TEMP\N-AbleViewerSetup.exe"
$client = new-object System.Net.WebClient
$client.DownloadFile("https://statlasautomation002.blob.core.windows.net/installers/n-able/MSPA4NCentralViewerInstall-7.00.26-20210708.exe", $outfile)
Start-Process -FilePath $outFile -Argument "/silent" 
Start-Sleep -Seconds 80
Remove-Item $outFile
echo 016-N-Able-Viewer-Installed >> C:\\buildActions\\buildActionsOutput.txt
