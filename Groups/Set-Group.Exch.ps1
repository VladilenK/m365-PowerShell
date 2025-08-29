$groupId = '460ef90e-d95f-4a24-963e-77075b56bde3'  # 
$groupId = '82c3d9cd-08c3-4931-8b09-16305f38d664'  # 
$upn = "john.smith@$orgname.onmicrosoft.com"

$group = Get-PnPMicrosoft365Group -IncludeSiteUrl -IncludeOwners -Identity $groupId -Connection $connectionAdmin
$group | Select-Object MailNickname, CreatedDateTime, RenewedDateTime, HideFromAddressLists, AllowToAddGuests

Connect-ExchangeOnline -AppId $clientid


$uGroup = Get-UnifiedGroup -Identity $groupId
$uGroup.AccessType
$uGroup.Name
$uGroup.DisplayName
$uGroup.WelcomeMessageEnabled

Set-UnifiedGroup -Identity $groupId -DisplayName "User ID Mismatch Test 03"
Set-UnifiedGroup -Identity $groupId -AccessType Private
Get-UnifiedGroupLinks -Identity $groupId -LinkType Members

Set-UnifiedGroup -Identity $groupId 

Add-UnifiedGroupLinks -Identity $groupId -LinkType Members -Links $upn # works with notification sent
Add-UnifiedGroupLinks -Identity $groupId -LinkType Members -Links $upn -SendWelcomeMessage:$false #  A parameter cannot be found that matches parameter name 'SendWelcomeMessage'.

Set-UnifiedGroup -Identity $groupId -UnifiedGroupWelcomeMessageEnabled:$false # false is a default settings, notifications still come
Set-UnifiedGroup -Identity $groupId -UnifiedGroupWelcomeMessageEnabled








