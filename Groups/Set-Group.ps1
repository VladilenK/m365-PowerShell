$groupId = '53d4d2cd-ac3b-4f80-b96a-82a3909e45de'  # 
$groupId = '4caca2bb-e0cf-4581-b296-38aff807de9d'  # AboutBirdwatching
$groupId = 'b0305dbf-ba6a-4053-9fb2-ef09832dc43d'  # 
$groupId = '3167e891-a922-4922-8486-8f3ef5bc871b'  # 
$groupId = 'fff5dfa4-de04-43e0-8add-cf9031fa9eb1'  # 
$groupId = '79dcd676-127c-4cc0-9acd-d3116c7e7c06'  # 
$groupId = '25d0d732-66cd-42e5-8b70-6536db5c4c74'  # 
$groupId = '179802d3-e525-4209-acc2-67d59d9c8d68'  # Test-21
$groupId = '010a41bb-bb31-4a11-ad02-1627597268df'  # 602
$groupId = '0b27bd21-6e75-4069-9d84-337a5d814cc6'  # 614
$groupId = '9b157abe-0375-40b6-b788-b6c6be455af1'  # Test-Sites-Selected
$groupId = 'a738c357-0b80-427c-9dbd-77b505aa1ea6'  # TestPrivteam-ownerlessgroupspolicy
$groupId = 'a1a667f7-1433-401c-b384-0b34dc2fd680'  # 603
$groupId = '92d1bceb-33d4-4db2-afce-6495d461a92e'  # 604
$groupId = '80e65035-e6e7-45c3-8fa6-b412bdf11e97'  # 605

$group = Get-PnPMicrosoft365Group -IncludeSiteUrl -IncludeOwners -Identity $groupId
$group | Select-Object MailNickname, CreatedDateTime, RenewedDateTime, HideFromAddressLists, AllowToAddGuests

Reset-PnPMicrosoft365GroupExpiration -Identity $groupId 

$group.RenewedDateTime = $((Get-Date).AddDays(-90))
$group.RenewedDateTime
Invoke-PnPQuery 

Set-PnPMicrosoft365Group -Identity $groupId -HideFromAddressLists $true

# group membership
Get-PnPMicrosoft365GroupOwner  -Identity $groupId 
Get-PnPMicrosoft365GroupOwner  -Identity $groupId | % { Get-PnPAzureADUser -Identity $_.Id }
Get-PnPMicrosoft365GroupMember -Identity $groupId 
Add-PnPMicrosoft365GroupOwner -Identity $groupId -Users "Jan@$orgname.onmicrosoft.com"
Add-PnPMicrosoft365GroupOwner -Identity $groupId -Users "370a89fb-88db-4102-a3a9-0b603a0635b2"
Remove-PnPMicrosoft365GroupOwner -Identity $groupId -Users "370a89fb-88db-4102-a3a9-0b603a0635b2"



# MgGraph - Microsoft.Graph
Import-Module Microsoft.Graph.Groups
# $tenantId = '887d660e-c53f-4c38-af69-214fe2a73f0a'
# $clientid = '5011b163-c4ee-48e5-850d-fadbcc79983d' # SPO_FullControl_App (FullControl)
# $certThumbprint = 'D573D69810F63F027E3DA172FB922D1D0A54036C'
Disconnect-MgGraph
Connect-MgGraph -ClientId $clientid -CertificateThumbprint $certThumbprint -TenantId $tenantId 
Get-MgGroup -GroupId $groupId 
$mgGroup = Get-MgGroup -GroupId $groupId 
$mgGroup.RenewedDateTime
$params = @{
    description     = "Test-21 group description"
    RenewedDateTime = "2023-01-01"
}
Update-MgGroup -GroupId $groupId -BodyParameter $params


####
# Group(s) settings
Get-PnPMicrosoft365GroupSettingTemplates 
Get-PnPMicrosoft365GroupSettings 
New-PnPMicrosoft365GroupSettings 
Get-PnPMicrosoft365GroupSettings -Identity $groupId
Set-PnPMicrosoft365GroupSettings -Identity $settingsId -Group $groupId -Values @{"AllowToAddGuests" = "true" }

