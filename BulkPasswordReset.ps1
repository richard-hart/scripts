#ensure AD module is imported so things work
Import-Module ActiveDirectory
 
#set path to CSV file here:
$filepath = "C:\Temp\users.csv"
 
#for each row in the CSV
$passwordList = Import-CSV $filepath | ForEach-Object {
 
#retrieve the username and password
$username = $_."samAccountName"
$password = $_."password"
 
#convert password to secure string
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
 
#set new password
Set-ADAccountPassword -Identity $username -NewPassword $securePassword -Reset
 
#confirm accounts being updated
Write-Host "Password has been set for: "$username
 
}