# Let's check if the SharePoint Online Management Shell is already installed
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version

# Let's install Sharepoint Online Management Shell
Install-Module -Name Microsoft.Online.SharePoint.PowerShell

$adminUPN="homer@acme.com"
$orgName="Acme"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url "https://Acme-admin.sharepoint.com" -Credential $userCredential

#connect with multi-factor authentication
$orgName="<name of your Office 365 organization, example: contosotoycompany>"
Connect-SPOService -Url https://Acme-admin.sharepoint.com

