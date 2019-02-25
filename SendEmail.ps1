#Send email via PowerShell

$Attachment = "PathToAttachment"
$SmtpServer = "smtp.domain.com"
$Smtp = New-Object Net.Mail.SmtpClient($SmtpServer)
$SmtpFile = New-Object Net.Mail.Attachment($Attachment)
$SmtpMsg = New-Object Net.Mail.MailMessage
$SmtpMsg.From = "admin@domain.com"
$SmtpMsg.To.Add("user@domain.com")
$SmtpMsg.Subject = "Message Subject"
$SmtpMsg.Body = "Some message body text."
$SmtpMsg.Attachments.Add($SmtpFile)
$Smtp.Timeout = "30000"
$Smtp.Send($SmtpMsg)
$SmtpFile.Dispose()