$outfile = "C:\TEMP\N-AbleViewerSetup.exe"
$client = new-object System.Net.WebClient
$client.DownloadFile("https://statlasautomation002.blob.core.windows.net/installers/n-able/MSPA4NCentralViewerInstall-7.00.26-20210708.exe", $outfile)
Start-Process -FilePath $outFile -Argument "/qn" 
Start-Sleep -Seconds 60
