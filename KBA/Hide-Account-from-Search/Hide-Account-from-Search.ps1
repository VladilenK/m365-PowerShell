##############################################################################################################
# Exchange
DisConnect-ExchangeOnline 
Connect-ExchangeOnline 

$upns = @()
$upns += 'DavidA@s5dz3.onmicrosoft.com'
$upns += 'Designer@s5dz3.onmicrosoft.com'
$upns += 'JohanL@s5dz3.onmicrosoft.com'
$upns += 'JohannaL@s5dz3.onmicrosoft.com'

foreach ($upn in $upns) {
    $exchMailBox = Get-Mailbox -Identity $upn 
    $exchMailBox | Select-Object UserPrincipalName, HiddenFromAddressListsEnabled 
}
# Set-Mailbox -Identity 'Designer@s5dz3.onmicrosoft.com' -HiddenFromAddressListsEnabled $true

##############################################################################################################
# SharePoint
$UserProp = Get-PnPUserProfileProperty -Account $upns[0] -Connection $connection
$UserProp.UserProfileProperties.'SPS-UserPrincipalName'
$UserProp.UserProfileProperties.'SPS-HideFromAddressLists'

$upns | % { Get-PnPUserProfileProperty -Account $_ -Connection $connection } `
| % { Write-Host $_.UserProfileProperties.'SPS-HideFromAddressLists' $_.UserProfileProperties.'SPS-UserPrincipalName' }

Set-PnPUserProfileProperty -Account $upns[0]  -PropertyName 'SPS-HideFromAddressLists' -Value $true -Connection $connection
Set-PnPUserProfileProperty -Account $loginUPN -PropertyName 'SPS-HideFromAddressLists' -Value $true -Connection $connection

##############################################################################################################
# Azure 
DisConnect-AzAccount 
Connect-AzAccount 

$azADUser = Get-AzADUser -UserPrincipalName $upns[0]
$azADUser.ShowInAddressList

foreach ($upn in $upns) {
    $azAdUser = Get-AzADUser -UserPrincipalName $upn -Select AccountEnabled, ShowInAddressList -AppendSelected 
    $azAdUser | Select-Object UserPrincipalName, AccountEnabled, ShowInAddressList
}

Set-AzADUser -UPNOrObjectId  $upns[0] -ShowInAddressList:$false
Set-AzADUser -UPNOrObjectId  $upns[1] -ShowInAddressList:$false
Set-AzADUser -UPNOrObjectId  $upns[2] -ShowInAddressList:$true


