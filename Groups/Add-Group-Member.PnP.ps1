
# Get-PnPContext
# Get-PnPConnection

$groupId = 'b9bc6bd8-f0ea-4842-860f-331a71c415bd'  # 2
$upn = "john.smith@$orgname.onmicrosoft.com"

$group = Get-PnPMicrosoft365Group -Identity $groupId
$group

Get-PnPMicrosoft365GroupMember -Identity $groupId

Add-PnPMicrosoft365GroupMember -Identity $groupId -Users $upn 
# users are notified

