# Connect-PnPOnline -Url $adminUrl -ClientId $clientId -ClientSecret $clientSc 
Connect-PnPOnline -Url $adminUrl -ClientId $clientId -Tenant $tenantId -Thumbprint $certThumbprint

Get-PnPAzureADUser 
Get-PnPAzureADUser | ? { $_.UserPrincipalname -match 11 } 
$users = Get-PnPAzureADUser | ? { $_.UserPrincipalname -match 11 } 
$users.count
$adUser = Get-PnPAzureADUser -Identity $users[2].UserPrincipalName -Select AdditionalProperties
$adUser = Get-PnPAzureADUser -Identity $users[2].UserPrincipalName
$adUser.AdditionalProperties
$adUser | fl


$UserProp = Get-PnPUserProfileProperty -Account $users[3].UserPrincipalName 
# $UserProp | fl
$UserProp.UserProfileProperties.'SPS-HideFromAddressLists'

$users | % { Get-PnPUserProfileProperty -Account $_.UserPrincipalname } | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }

Get-PnPUserProfileProperty -Account 'test-user-1101@$orgname.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1102@$orgname.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1103@$orgname.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1104@$orgname.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1105@$orgname.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1106@$orgname.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }

# Set-PnPUserProfileProperty -Account $users[4].UserPrincipalName -PropertyName 'SPS-HideFromAddressLists' -Value 'True'
Set-PnPUserProfileProperty -Account 'test-user-1105@$orgname.onmicrosoft.com' -PropertyName 'SPS-HideFromAddressLists' -Value 'True'

#############################################################
# AzureAD

# auto:
Connect-AzureAD -ApplicationId $clientID -TenantId $tenantId -CertificateThumbprint $certThumbprint

Get-azureaduser 
Get-azureaduser -ObjectId test-user-1103@$orgname.onmicrosoft.com | fl 
Get-azureaduser -ObjectId test-user-1105@$orgname.onmicrosoft.com | fl 
$user = Get-azureaduser -ObjectId test-user-1105@$orgname.onmicrosoft.com 
$user | fl
$user.tojson()
$user | fl | clip
$user.ShowInAddressList

$aadUser = Get-PnPAzureADUser -Identity test-user-1104@$orgname.onmicrosoft.com -Select AdditionalProperties
$aadUser.AdditionalProperties["AdditionalData"]


Set-AzureADUser -ObjectId test-user-1105@$orgname.onmicrosoft.com -ShowInAddressList $false
Set-AzureADUser -ObjectId test-user-1105@$orgname.onmicrosoft.com -ShowInAddressList 1

Set-AzureADUser -ObjectId test-user-1106@$orgname.onmicrosoft.com -ShowInAddressList $false
Set-AzureADUser -ObjectId test-user-1106@$orgname.onmicrosoft.com -ShowInAddressList $true

Get-AzureADApplication | Get-AzureADApplicationExtensionProperty

# Az
Connect-AzAccount -ApplicationId $clientId -CertificateThumbprint $certThumbprint -Tenant $tenantId 
Get-AzADUser
Get-AzADUser -UserPrincipalName test-user-1100@$orgname.onmicrosoft.com -Select ShowInAddressList -AppendSelected | Select-Object UserPrincipalName, ShowInAddressList 
Get-AzADUser -UserPrincipalName test-user-1101@$orgname.onmicrosoft.com -Select ShowInAddressList -AppendSelected | Select-Object UserPrincipalName, ShowInAddressList 
Get-AzADUser -UserPrincipalName test-user-1102@$orgname.onmicrosoft.com -Select ShowInAddressList -AppendSelected | Select-Object UserPrincipalName, ShowInAddressList 
Get-AzADUser -UserPrincipalName test-user-1103@$orgname.onmicrosoft.com -Select ShowInAddressList -AppendSelected | Select-Object UserPrincipalName, ShowInAddressList 
Get-AzADUser -UserPrincipalName test-user-1104@$orgname.onmicrosoft.com -Select ShowInAddressList -AppendSelected | Select-Object UserPrincipalName, ShowInAddressList 
Get-AzADUser -UserPrincipalName test-user-1105@$orgname.onmicrosoft.com -Select ShowInAddressList -AppendSelected | Select-Object UserPrincipalName, ShowInAddressList 
Get-AzADUser -UserPrincipalName test-user-1106@$orgname.onmicrosoft.com -Select ShowInAddressList -AppendSelected | Select-Object UserPrincipalName, ShowInAddressList 
