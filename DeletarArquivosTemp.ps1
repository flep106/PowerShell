$sourceDirectory = ".\"
$data = (Get-Date).AddDays(-366).Date
$ActiveCount = 0

# Remover tudo que contenha a data de 90 dias atras 
$files = Get-ChildItem -Path $sourceDirectory | ? { $_.LastWriteTime.Date -lt $data }
foreach($file in $files){
# Remove-Item -Path $file.FullName -Force -Recurse
#Write-Host : Arquivo $file.FullName removido com sucesso.
$ActiveCount++
}

Write-Host : Total:  $ActiveCount