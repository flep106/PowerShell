<#
Autor: Felipe Vandrilho
Data: 23/02/2023

Pré requisito para Get-ADComputer:
Add-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 -Online
Add-WindowsFeature RSAT-AD-Powershell
#>


<#
$computerlist = Get-ADComputer -LDAPFilter $ldapfilter -SearchBase $searchBase -Properties Name, IPv4Address, DNSHostName, IPv4Address, Modified, whenChanged, whenCreated | 
FT -Property Name, IPv4Address, DNSHostName, IPv4Address, Modified, whenChanged, whenCreated -AutoSize
#>
# $computers.count   # Returns 15. 
#Obtem todos os computadores com alguemas informacoes do AD
# FT -> Format-Tabele


#Filtro de pesquisa no AD
$searchBase = "CN=Computers,DC= janga, DC=local"
$ldapfilter = "(name=*)"
$outputDirectory = $env:HOMEPATH + "\EXPORT_AD"
$outputFile = $outputDirectory + "\EXPORT_AD_COMPUTERS.csv"


<# Conectando a um controlador de domínio
$domainController = "AD-WIN"
$userAD = "JANGA\Administrator"
$pwordAD = ConvertTo-SecureString -String "V@ndrilho1" -AsPlainText -Force
$PScredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $userAD, $pwordAD

Connect-ADService -Server $domainController -Credential $PScredential
#>


# Consultando informações de objetos de computador no Active Directory
Get-ADComputer -Filter * -Properties Name, OperatingSystem

$computerlist = Get-ADComputer -LDAPFilter $ldapfilter -SearchBase $searchBase `
-Properties Name, IPv4Address, DNSHostName, IPv4Address, OperatingSystem, Modified,whenChanged,whenCreated

$computerlist | Select-Object -Property Name, ObjectClass, OperatingSystem, Modified, whenChanged, whenCreated, @{label="Modificado"; expression={"{0:dd/MM/yyyy HH:mm:ss}" -f $_.Modified}} `
 | Export-Csv $outputFile -Delimiter ";" -NoTypeInformation 
