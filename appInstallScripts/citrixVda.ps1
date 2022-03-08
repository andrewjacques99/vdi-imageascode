$outfile = "C:\TEMP\VDAServerSetup.exe"
$client = new-object System.Net.WebClient
$client.DownloadFile("https://statlasautomation002.blob.core.windows.net/installers/citrix_vda/VDAServerSetup_2112.exe", $outfile)
Start-Process -FilePath $outFile -Argument "/quiet /components vda /disableexperiencemetrics /enable_hdx_ports /enable_hdx_udp_ports /enable_real_time_transport /enable_remote_assistance /enable_ss_ports /exclude `"Citrix Profile Management`",`"Citrix Profile Management WMI Plug-in`",`"Citrix Telemetry Service`",`"Citrix Personalization for App-V - VDA`",`"User personalization layer`",`"Citrix WEM Agent`",`"Citrix VDA Upgrade Agent`",`"Citrix Rendezvous V2`" /includeadditional `"Citrix Universal Print Client`",`"Citrix Supportability Tools`",`"Citrix Files for Windows`",`"Citrix Files for Outlook`",`"Citrix MCS IODriver`" /masterimage /noreboot /virtualmachine" -Wait
