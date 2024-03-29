﻿<# 
Autor:               Felipe Vandrilho
Data de modificação: 15/08/2022
Objetivo: Envia e-mail para subtituir o operador "SEND_EMAIL" do PAM
#>

# PARAMETROS
param (
[Parameter(Mandatory=$true, Position=0)][string] $email_usu, 
[Parameter(Mandatory=$true, Position=1)][string] $email_pss,
[Parameter(Mandatory=$true, Position=2)][string] $email_dest 
)


# Retorna o conteudo do arquivo HTML como String no body
$body_sem_cadastro = Get-ChildItem -Path "C:\temp\" -Name body-message.html | Get-Content | Out-String

# USA TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#conversao passowrd em security string
$email_pss_ss = ConvertTo-SecureString -String $email_pss -Force -AsPlainText

#Objeto Credencial
$credencial = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $email_usu, $email_pss_ss

$smtp_cliente = @{
    From = $email_usu
    To = $email_dest
    Subject = "Não foi possível registrar a sua solicitação!"
    #Body = "<h1>TESTE 01</h1>"
    Body = $body_sem_cadastro
    Credential = $credencial
    SmtpServer = "smtp.office365.com"
    Port = "587"
    BodyAsHtml = $true
    UseSsl = $true
    Encoding ="UTF8"
}

Send-MailMessage @smtp_cliente

# $Error[0] > "C:\temp\error-output.txt"