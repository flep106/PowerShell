<# 
Autor:               Felipe Vandrilho
Data de modificação: 15/08/2022
Objetivo: Envia e-mail para subtituir o operador "SEND_EMAIL" do PAM
#>

#PARAMETROS
[string] $email_usu = $args[0]
[string] $email_pss = $args[1]
[string] $email_dest = $args[2]
[string] $body_sem_cadastro = $args[3]

# USA TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#conversao em security string
$email_pss_ss = ConvertTo-SecureString -String $email_pss -Force -AsPlainText
$body_sem_cadastro2 = ConvertTo-Html -InputObject $body_sem_cadastro

#Objeto Credencial
$credencial = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $email_usu, $email_pss_ss

$smtp_cliente = @{
    From = $email_usu
    To = $email_dest
    Subject = "Não foi possível registrar a sua solicitação!"
    Body = $body_sem_cadastro2
    Credential = $credencial
    SmtpServer = "smtp.office365.com"
    Port = "587"
    BodyAsHtml = $true
    UseSsl = $true
    Encoding ="UTF8"
}

Send-MailMessage @smtp_cliente
