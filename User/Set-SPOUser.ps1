Connect-PnPOnline -Url $adminUrl -ClientId $clientId -ClientSecret $clientSc 
$connection.Url

$upn = 'test-user-1100@uhgdev.onmicrosoft.com'
$upn = 'Vlad@uhgdev.onmicrosoft.com'
$UserProp = Get-PnPUserProfileProperty -Account $upn
$UserProp | fl
$UserProp.UserProfileProperties | ft -AutoSize
$UserProp.UserProfileProperties.'SPS-HideFromAddressLists'
$UserProp.UserProfileProperties.'SPS-PhoneticFirstName'

Set-PnPUserProfileProperty -Account $upn -PropertyName 'SPS-PhoneticFirstName' -Value 'user1100'

Set-PnPUserProfileProperty -Account 'Vlad@uhgdev.onmicrosoft.com' -PropertyName 'SPS-PhoneticFirstName' -Value 'Adik'
Set-PnPUserProfileProperty -Account 'Jan@uhgdev.onmicrosoft.com' -PropertyName 'SPS-PhoneticFirstName' -Value 'Janata'
Set-PnPUserProfileProperty -Account 'S.Lem@uhgdev.onmicrosoft.com' -PropertyName 'SPS-PhoneticFirstName' -Value 'Stasik'
Set-PnPUserProfileProperty -Account 'user33@uhgdev.onmicrosoft.com' -PropertyName 'SPS-PhoneticFirstName' -Value 'Bapu'
Set-PnPUserProfileProperty -Account 'user33@uhgdev.onmicrosoft.com' -PropertyName 'SPS-PhoneticLastName' -Value 'Bapu'
Set-PnPUserProfileProperty -Account 'user33@uhgdev.onmicrosoft.com' -PropertyName 'SPS-PhoneticDisplayName' -Value 'Bapu'
Set-PnPUserProfileProperty -Account 'user33@uhgdev.onmicrosoft.com' -PropertyName 'Fax' -Value '+91-555-555-5555'









$users | % { Get-PnPUserProfileProperty -Account $_.UserPrincipalname } | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }

Get-PnPUserProfileProperty -Account 'test-user-1101@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1102@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1103@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1104@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1105@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1106@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }

# Set-PnPUserProfileProperty -Account $users[4].UserPrincipalName -PropertyName 'SPS-HideFromAddressLists' -Value 'True'
Set-PnPUserProfileProperty -Account 'test-user-1105@uhgdev.onmicrosoft.com' -PropertyName 'SPS-HideFromAddressLists' -Value 'True'

#############################################################
# AzureAD

# auto:
# Connect-AzureAD -ApplicationId $clientID -TenantId $tenantId -CertificateThumbprint $certThumbprint
Connect-AzureAD 

Get-azureaduser 
Get-azureaduser -ObjectId test-user-1103@uhgdev.onmicrosoft.com | fl 
Get-azureaduser -ObjectId test-user-1105@uhgdev.onmicrosoft.com | fl 
$user = Get-azureaduser -ObjectId test-user-1105@uhgdev.onmicrosoft.com 
$user | fl
$user.tojson()
$user | fl | clip
$user.ShowInAddressList

Get-AzureADUser -ObjectId test-user-1104@uhgdev.onmicrosoft.com | Select -ExpandProperty ExtensionProperty

Get-AzureADUser -ObjectId test-user-1101@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1102@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1103@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1104@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1105@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1106@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList

Set-AzureADUser -ObjectId test-user-1105@uhgdev.onmicrosoft.com -ShowInAddressList $false
Set-AzureADUser -ObjectId test-user-1105@uhgdev.onmicrosoft.com -ShowInAddressList 1

Set-AzureADUser -ObjectId test-user-1106@uhgdev.onmicrosoft.com -ShowInAddressList $false
Set-AzureADUser -ObjectId test-user-1106@uhgdev.onmicrosoft.com -ShowInAddressList $true

Get-AzureADApplication | Get-AzureADApplicationExtensionProperty

