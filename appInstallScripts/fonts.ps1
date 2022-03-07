$outfile = "C:\TEMP\fonts.zip"
$client = new-object System.Net.WebClient
$client.DownloadFile("https://statlasautomation002.blob.core.windows.net/installers/fonts/Atlas_Cloud_Marketing_Fonts.zip", $outfile)
New-Item  -ItemType Directory "C:\TEMP\Extracted"
Expand-Archive $outfile -destination "C:\TEMP\Extracted"
$FontFolder = "C:\TEMP\Extracted\fonts"
$FontItem = Get-Item -Path $FontFolder
$FontList = Get-ChildItem -Path "$FontItem\*" -Include ('*.fon','*.otf','*.ttc','*.ttf')
foreach ($Font in $FontList) {
        Write-Host 'Installing font -' $Font.BaseName
        Copy-Item $Font "C:\Windows\Fonts"
        New-ItemProperty -Name $Font.BaseName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $Font.name         
}
