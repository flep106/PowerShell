$data = Get-Date -Format "dd/mm/yyyy hh:mm:ss"

"[{0}] - {1}: LOG GERADO" -f $data, $env:COMPUTERNAME  | Out-File -FilePath .\Documents\output-ps1.txt
