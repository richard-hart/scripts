$adminCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $adminCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
Import-Module MSOnline
Connect-MsolService -Credential $adminCredential

