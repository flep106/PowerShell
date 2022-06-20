<#
$teste = $args[0]
$teste2 = $args[1]


Write-Host($teste)
#>

<#
param(
[string] $email_usu,
[string] $email_pss
)
#>



# pwd > .\output.txt
# #gera error proposital
# cd $a

$body_sem_cadastro = Get-ChildItem -Path "C:\temp\" -Name body-message.html | Get-Content | Out-String
#$body_sem_cadastro2 = $body_sem_cadastro.
Write-Host($body_sem_cadastro)

$body_sem_cadastro.GetType()

#Write-Host($body_sem_cadastro)

$Error[0] > .\output-erro.txt