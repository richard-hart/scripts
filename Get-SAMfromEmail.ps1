Get-Content "C:\Temp\Users.txt" | ForEach-Object {
  $mail = $_
  $user = Get-ADUser -LDAPFilter "(mail=$mail)"
  if ( $user ) {
    $sAMAccountName = $user.sAMAccountName
  }
  else {
    $sAMAccountName = $null
  }
  [PSCustomObject] @{
    "mail" = $mail
    "sAMAccountName" = $sAMAccountName
  }
} | Export-Csv "C:\Temp\users-output.csv" -NoTypeInformation