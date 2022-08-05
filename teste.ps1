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

# $saida = 123;

# if ($saida -ne 0) {
#     $saida = 1
# }
# try {
#     adfdfw
# }
# catch {ls

#     {"TESTE"}
# }


$SERVIDORES_HMG = @{ 

APP01_CATALOG_XFLOW = "SAODOMINGOS"; 
APP02_CATALOG_XFLOW = "SAODESIDERIO";
APP03_INTEGRACAO = "SAOBRAS";
STANDBY = "SAOBORJA"; 
}

$SRV_TESTE = @{
TARRASQUE = "TARRASQUE"
NOTE_SOLUTIS = "SLT-002595"
SDM_DEV = "SDM-STANDALONE"
}

foreach ($item_chave in $SRV_TESTE.Keys) {
   "Chave-> " + $item_chave + " Valor-> " + $SRV_TESTE[$item_chave]
}

#Write-Host $SRV_TESTE.SDM_DEV.GetType()
#$Error[0] > .\output-erro.txt
#
$Senha = ConvertTo-SecureString -String 'V@ndrilho1' -AsPlainText -Force
$PScredencial = New-Object -TypeName System.Management.Automation.PSCredential("Administrador\Administrador", $Senha)
$Sessao = New-PSSession -ComputerName $SRV_TESTE.TARRASQUE -Credential $PScredencial
Copy-Item  "\\SLT-002595\c$\temp\select.txt" -Destination "\\TARRASQUE\c$\temp" -ToSession $Sessao
#
