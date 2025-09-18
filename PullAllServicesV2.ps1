<# Minimal, no-WSMan service inventory
   - Uses WMI/DCOM (Get-WmiObject) so WinRM is not required
   - Outputs one CSV per computer
#>

param(
    [string[]]$ComputerName = @($env:COMPUTERNAME),
    [string]$OutputFolder = 'C:\Temp\ServiceInventory',
    [pscredential]$Credential
)

if (-not (Test-Path -LiteralPath $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder -Force | Out-Null
}

$timestamp = Get-Date -Format 'yyyyMMdd-HHmm'

foreach ($comp in $ComputerName) {
    Write-Host "Collecting services from $comp ..." -ForegroundColor Cyan
    try {
        $svcArgs = @{ Class = 'Win32_Service'; ComputerName = $comp; ErrorAction = 'Stop' }
        if ($Credential) { $svcArgs.Credential = $Credential }

        # Win32_Service fields: Name, DisplayName, State, StartMode, StartName, PathName, Description
        $rows = Get-WmiObject @svcArgs | Select-Object `
            @{n='ComputerName';e={$comp}},
            Name, DisplayName,
            @{n='Status';e={$_.State}},
            @{n='StartupType';e={$_.StartMode}},   # Auto | Manual | Disabled | (Boot/System rare)
            @{n='StartName';e={$_.StartName}},     # Logon account
            PathName, Description

        $fileSafe = ($comp -replace '[^A-Za-z0-9\-_.]', '_')
        $outFile = Join-Path $OutputFolder ("ServiceInventory_{0}_{1}.csv" -f $fileSafe, $timestamp)
        $rows | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $outFile
        Write-Host "✔ Saved: $outFile" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to collect from $comp : $($_.Exception.Message)"
    }
}
