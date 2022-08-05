param ([string]$Type='R', [string]$Category, [string]$Summary,  [string]$Description, [string]$Group)

function createCASDMRequest($CASDMUsr, $URL, $Type, $Summary, $Category, $Group, $Description){
    $svc = New-WebServiceProxy -Uri $URL
    $wsUsername=$CASDMUsr
    $passwd=Read-Host -Prompt 'Enter your CA ServiceDesk Manager Password' -AsSecureString
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwd)
    $wsPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    $sid = $svc.login($wsUsername,$wsPassword)
    $customerHandle = $svc.getHandleForuserID($sid,$wsUsername)  # Using the creator user as customer
    $creatorHandle = $customerHandle
    $prop = ""
    $attr = "persistent_id"
    $requestHandle = ""
    $requestNumber = ""
    $summ=$Summary
    $desc=$Description
    [xml]$groupHandleReturn = $svc.doSelect($sid,"grp","last_name='$Group'",1,"persistent_id")
    $groupHandle=$groupHandleReturn.UDSObjectList.UDSObject.Handle
    [xml]$categoryHandleReturn = $svc.doSelect($sid,"pcat","sym='$Category'",1,"persistent_id")
    $categoryHandle=$categoryHandleReturn.UDSObjectList.UDSObject.Handle
    $attrVal = "customer", $customerHandle, "type",$Type,"summary",$summ,"description",$desc,"group",$groupHandle,"category",$categoryHandle,"priority",5
    [xml]$newRequestHandle = $svc.createRequest($sid,$creatorHandle,$attrVal,$prop,"","id",[ref]$requestHandle, [ref]$requestNumber)
    return [String]$requestNumber
}

$URL = $env:URLCASDM  # Register the CA ServiceDesk wsdl URI in an environment variable
$CASDMUsr = $env:USERNAME # User is the current user
$Ticket = createCASDMRequest $CASDMUsr $URL $Type $Summary $Category $Group $Description
Write-Host (Get-Date -UFormat "%d-%h-%Y %H:%M:%S : [INFO] Call Request Type $Type created: $Ticket") -ForegroundColor Green;