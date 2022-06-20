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

$saida = 123;

if ($saida -ne 0) {
    $saida = 1
}
try {
    adfdfw
}
catch {
    {"TESTE"}
}



#$Error[0] > .\output-erro.txt