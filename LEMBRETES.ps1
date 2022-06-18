#Lembretes rapidos de powershell

######################### HELPER ##################################
# Tipo do Objeto
@().GetType().Name
@{}.GetType().Name

#Lista de METODOS E PROPRIEDADES do objeto
@{} | Get-Member #hastable
@(1) | Get-Member #array
1 | Get-Member #int
"" | Get-Member #string


#Help de metodos
Get-Help Send-MailMessage
Get-Help -Name Send-MailMessage

#Help de comandos
Get-Command -Name *rename*

#Atualiza a documentacao do Get-Help
Update-Help
#################################################################

### ERROR para arquivo
# transfere o erro "2>" -> fluxo normal "&1" > arquivo.txt
cd 'fake' 2>&1 > .\output-erro.txt



#########PARAMETROS
[string] $email_usu = $args[0]
[string] $email_pss = $args[1]

param(
[string] $email_usu,
[string] $email_pss
)


# variavel de ambiente
$env:path 

# Metodos suportado pelo objeto
$env:path | Get-Member

#variaveis de script
Get-Variable | ? -Like Name "*erro*"

#### ERROR
2>&1 > .\output-erro.txt #maneira padrao
$Error[0] > .\output-erro.txt #retorna o erro MAIS RECENTE do script



#verificar o que sua linha de comando vai fazer
Rename-Item .\tix.txt tix-telecom.txt -whatif
#output: What if: Realizando a operacao "Renomear Arquivo" no destino "Item: C:\Users\felipe.silva\Desktop\tix.txt Destino: C:\Users\felipe.silva\Desktop\tix-telecom.txt"




########## SELECT COM HASTABLE ###################
<# 
Entra em todas as pastas do diretório atual recursivamente e procura por arquivos txt
Imprime em formato de tabela

$nameExpr = @{}
$nameExpr.Add("Label", "Nome")
$nameExpr.Add("Expression", { $_.Name })

Quando colocar o nome "Label" o select reconhece como nome da coluna
Quando colocar o nome "Expression" o select reconhece como valor da coluna
#>
$erro
$nameExpr = @{
    Label = "Nome";
    Expression = { $_.Name }
}

$lengthExpr = @{
    Label = "Tamanho";
    Expression = { "{0:N2}KB" -f ($_.Length / 1KB) }
}

$params = $nameExpr, $lengthExpr

$resultado =
gci -Recurse -File |
    ? Name -like "*_migrando_*" |
    select $params

# Alias "gci" = Get-ChildItem
# Alias "?" = Where-Object

$resultado =
gci -Recurse -File |
    ? Name -like "*_migrando_*" |
    select $params

$estilos = Get-Content C:\scripts\styles.css #Obtem o estilo CSS pra aplica na tabela
$styleTag = "<style> $estilos </style>"
$tituloPagina = "Relatório de Scripts em Migração"
$tituloBody = "<h1> $tituloPagina </h1>"

$resultado | 
    ConvertTo-Html -Head $styleTag -Title $tituloPagina -Body $tituloBody | 
    Out-File C:\tempGui\relatorio.html

##########################################################
param($tipoDeExportacao) #diz ao ps que o script precisa de parametro

if ($tipoDeExportacao -eq "HTML") {
    $estilos = Get-Content C:\Scripts\styles.css
    $styleTag = "<style> $estilos </style>"
    $tituloPagina = "Relatório de Scripts em Migração"
    $tituloBody = "<h1> $tituloPagina </h1>"

    $resultado | 
        ConvertTo-Html -Head $styleTag -Title $tituloPagina -Body $tituloBody | 
        Out-File C:\tempGui\relatorio.html
} elseif ($tipoDeExportacao -eq "JSON") {
    $resultado | 
        ConvertTo-JSON |
        Out-File C:\tempGui\relatorio.json
} elseif ($tipoDeExportacao -eq "CSV") {
    $resultado | 
        ConvertTo-CSV |
        Out-File C:\tempGui\relatorio.csv
}

##########################################################