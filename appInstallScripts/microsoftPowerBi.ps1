echo 008-PowerBi-Start >> C:\\buildActions\\buildActionsOutput.txt
$outfile = "C:\TEMP\PBIDesktopSetup_x64.exe"
$client = new-object System.Net.WebClient
$client.DownloadFile("https://statlasautomation002.blob.core.windows.net/installers/power_bi/PBIDesktopSetup_x64.exe", $outfile)
Start-Process -FilePath $outFile -Argument "-silent -norestart ACCEPT_EULA=1" -wait
Remove-Item $outFile
echo 008-PowerBi-Installed >> C:\\buildActions\\buildActionsOutput.txt
