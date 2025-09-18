#Pull all services and export to outfile
$timestamp = Get-Date -Format 'yyyyMMdd-HHmm'
$outFile   = "C:\Temp\ServiceInventory_Local_$timestamp.csv"

Get-WmiObject -Class Win32_Service |
    Select-Object Name,
                  DisplayName,
                  @{n='Status';e={$_.State}},
                  @{n='StartupType';e={$_.StartMode}},
                  @{n='StartName';e={$_.StartName}} |
    Export-Csv -Path $outFile -NoTypeInformation -Encoding UTF8

Write-Host "✔ Saved: $outFile"

#myers