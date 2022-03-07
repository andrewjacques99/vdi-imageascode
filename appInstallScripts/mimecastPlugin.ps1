$outfile = "C:\TEMP\MimecastOutlookSetup.msi"
$client = new-object System.Net.WebClient
$client.DownloadFile("https://statlasautomation002.blob.core.windows.net/installers/mimecast_plugin/Mimecast for Outlook 7.10.0.72 (x64).msi", $outfile)
Start-Process -FilePath $outFile -Argument "/quiet" -Wait
Start-Process -FilePath C:\Windows\Microsoft.NET\Framework64\v4.0.30319\InstallUtil.exe -Argument "C:\Program Files\Mimecast\Mimecast Windows Service\msdsrv.exe" -wait
