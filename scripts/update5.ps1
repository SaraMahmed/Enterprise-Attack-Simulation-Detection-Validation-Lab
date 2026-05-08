# Windows Security Management Script
# Purpose: Manage local users and Windows Defender settings for SOC testing

# 1. Add a new local administrator (Used in persistence simulation)
$Username = "SecurityAudit"
$Password = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
New-LocalUser -Name $Username -Password $Password -Description "Account for security auditing."
Add-LocalGroupMember -Group "Administrators" -Member $Username

# 2. Modify Windows Defender Settings (Used to simulate evasion or hardening)
# Disable Real-time monitoring (Simulation only!)
Set-MpPreference -DisableRealtimeMonitoring $true 

# To re-enable (Hardening phase):
# Set-MpPreference -DisableRealtimeMonitoring $false
