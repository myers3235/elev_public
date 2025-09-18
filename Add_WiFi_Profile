# Define the SSID and password of the Wi-Fi network
$wifiSSID = "YourWiFiSSID"
$wifiPassword = "YourWiFiPassword"

# Generate a Wi-Fi profile XML
$wifiProfileXml = @"
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
    <name>$wifiSSID</name>
    <SSIDConfig>
        <SSID>
            <name>$wifiSSID</name>
        </SSID>
    </SSIDConfig>
    <connectionType>ESS</connectionType>
    <connectionMode>auto</connectionMode>
    <MSM>
        <security>
            <authEncryption>
                <authentication>WPA2PSK</authentication>
                <encryption>AES</encryption>
                <useOneX>false</useOneX>
            </authEncryption>
            <sharedKey>
                <keyType>passPhrase</keyType>
                <protected>false</protected>
                <keyMaterial>$wifiPassword</keyMaterial>
            </sharedKey>
        </security>
    </MSM>
</WLANProfile>
"@

# Save the profile XML to a temporary file
$tempProfileFile = [System.IO.Path]::GetTempFileName()
Set-Content -Path $tempProfileFile -Value $wifiProfileXml -Encoding UTF8

# Add the Wi-Fi profile
netsh wlan add profile filename="$tempProfileFile"

# Connect to the Wi-Fi network
netsh wlan connect name="$wifiSSID"

# Clean up temporary profile file
Remove-Item -Path $tempProfileFile
