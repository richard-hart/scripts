# ##########################################################

# HELPER FUNCTION

# ##########################################################

Function PressAnyKey ($message)

{

# Check if running Powershell ISE

if ($psISE)

{

Add-Type -AssemblyName System.Windows.Forms

[System.Windows.Forms.MessageBox]::Show("$message")

}

else

{

Write-Host "$message" -ForegroundColor Yellow

$key = [System.Console]::ReadKey().Key.ToString()

}

}

# ##########################################################

# MAIN

# ##########################################################

# Check if Azure AD PowerShell is installed

$module = Get-Module -ListAvailable -Name AzureAd

$modulep = Get-Module -ListAvailable -Name AzureAdPreview

# Install Azure AD PowerShell if not installed

if (-not $module -and -not $modulep) {

Write-Host "Azure AD PowerShell module not installed!" -ForegroundColor Yellow

Write-Host "Attempting to install Azure AD PowerShell module..." -ForegroundColor Yellow

Install-Module AzureAd

}

# Connect to Azure AD PowerShell

if (-not $AadSession) {

$AadSession = Connect-Azuread -verbose

}

# Get List of Company Administrators

$filename = "admins.of.$($AadSession.TenantDomain)"

$role = $null

$role = Get-AzureADDirectoryRole -Filter "DisplayName eq 'Company Administrator'"

$admins = Get-AzureADDirectoryRoleMember -ObjectId $role.ObjectId | Select-Object DisplayName, UserPrincipalName

# Export list of admins to a CSV

$admins | Export-Csv "$filename"

# Output list of admins

$admins | format-table

PressAnyKey -message "Press any key to continue..."