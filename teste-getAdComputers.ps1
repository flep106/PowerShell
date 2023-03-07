<#
Autor: Felipe Vandrilho
Data: 23/02/2023
#>
$searchBase = "CN=Computers,DC= janga, DC=local"
$ldapfilter = "(name=*)"
$outputFile = "C:\Users\Administrator.JANGA\Documents\temp\export.csv"
$computerlist = Get-ADComputer -LDAPFilter $ldapfilter -SearchBase $searchBase `
-Properties Name, IPv4Address, DNSHostName, IPv4Address, OperatingSystem, Modified,whenChanged,whenCreated

<#
$computerlist = Get-ADComputer -LDAPFilter $ldapfilter -SearchBase $searchBase -Properties Name, IPv4Address, DNSHostName, IPv4Address, Modified, whenChanged, whenCreated | 
FT -Property Name, IPv4Address, DNSHostName, IPv4Address, Modified, whenChanged, whenCreated -AutoSize
#>
# $computers.count   # Returns 15
#Obtem todos os computadores com alguemas informacoes do AD
# FT -> Format-Tabele
# t-Content -Path .\Processes.csv
$computerlist | Select-Object -Property Name, ObjectClass, OperatingSystem, OperatingSystemVersion, Enabled, BadLogonCount, BadPwdCount, Modified, whenChanged, whenCreated,@{label="Modificado";expression={"{0:dd/MM/yyyy HH:mm:ss}" -f $_.Modified}} `
 |Export-Csv $outputFile -Delimiter ";" -NoTypeInformation 