#Obter todos os arquivos dentro de subpastas, onde cada (item da lista é "_$") composto de txt, selecione o nome e o tamanho
# similar ao select de tabela de BD
Get-ChildItem -Recurse -File | Where-Object {$_ -like "*.txt*"} | Select-Object -Property Name, Length


#Outra maneira
$nameExpr = @{
    Label = "Nome";
    Expression = { $_.Name }
}

$lengthExpr = @{
    Label = "Tamanho";
    Expression = { "{0:N2}KB" -f ($_.Length / 1KB) }
}

$params = $nameExpr, $lengthExpr

# Alias "gci" = Get-ChildItem
# Alias "?" = Where-Object
$resultado =
gci -Recurse -File |
    ? Name -like "*_migrando_*" |
    select $params

#### Formatando HTML
$estilos = Get-Content C:\scripts\styles.css #Obtem o estilo CSS pra aplica na tabela
$styleTag = "<style> $estilos </style>"
$tituloPagina = "Relatório de Scripts em Migração"
$tituloBody = "<h1> $tituloPagina </h1>"


#Utiliza a tabela e converte para HTMPL | CSV | JSON
$resultado | 
    ConvertTo-Html -Head $styleTag -Title $tituloPagina -Body $tituloBody | 
    Out-File C:\tempGui\relatorio.html

#Parametro para exportação HTML | CSV | JSON
param(
	$tipoDeExportacao
	) #diz ao ps que o script precisa de parametro

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