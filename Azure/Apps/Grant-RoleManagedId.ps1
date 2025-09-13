

Get-PnPAzureADServicePrincipal -BuiltInType MicrosoftGraph
Get-PnPAzureADServicePrincipal -BuiltInType SharePointOnline 

Get-PnPAzureADServicePrincipal -BuiltInType MicrosoftGraph | Get-PnPAzureADServicePrincipalAvailableAppRole | ?{$_.Value -match "sites"} | ft value
# Sites.Archive.All
# Sites.FullControl.All
# Sites.Manage.All
# Sites.Read.All
# Sites.ReadWrite.All
# Sites.Selected

Get-PnPAzureADServicePrincipal -BuiltInType SharePointOnline | Get-PnPAzureADServicePrincipalAvailableAppRole | ?{$_.Value -match "sites"} | ft value
# Sites.ReadWrite.All
# Sites.Read.All
# Sites.FullControl.All
# Sites.Manage.All
# Sites.Selected


$UserAssignedManagedIdentityObjectId = "c7cfc72e-25e2-44a2-b9ae-197a0dfc4fa8" # sites.selected
$UserAssignedManagedIdentityObjectId = "b0bfe72c-73a9-4072-a78b-391e9670f4b9" # full control all sites
$UserAssignedManagedIdentityObjectId = "08f3b083-8ed5-4b3a-ba88-43b6a6336a16" # sites.selected
Get-PnPAzureADServicePrincipalAssignedAppRole -Principal $UserAssignedManagedIdentityObjectId | ft -a 

Add-PnPAzureADServicePrincipalAppRole -Principal $UserAssignedManagedIdentityObjectId -AppRole "Sites.FullControl.All" -BuiltInType MicrosoftGraph
Add-PnPAzureADServicePrincipalAppRole -Principal $UserAssignedManagedIdentityObjectId -AppRole "Sites.FullControl.All" -BuiltInType SharePointOnline

Add-PnPAzureADServicePrincipalAppRole -Principal $UserAssignedManagedIdentityObjectId -AppRole "Sites.Manage.All" -BuiltInType MicrosoftGraph
Add-PnPAzureADServicePrincipalAppRole -Principal $UserAssignedManagedIdentityObjectId -AppRole "Sites.Manage.All" -BuiltInType SharePointOnline

Add-PnPAzureADServicePrincipalAppRole -Principal $UserAssignedManagedIdentityObjectId -AppRole "Sites.Selected" -BuiltInType MicrosoftGraph
Add-PnPAzureADServicePrincipalAppRole -Principal $UserAssignedManagedIdentityObjectId -AppRole "Sites.Selected" -BuiltInType SharePointOnline

Remove-PnPAzureADServicePrincipalAssignedAppRole -Principal $UserAssignedManagedIdentityObjectId -AppRole "Sites.Selected" 


# Sites.selected

$siteUrl = "https://$orgname.sharepoint.com/sites/Test101"
Get-PnPAzureADAppSitePermission -Site $siteUrl  -Connection $connectionAdmin

$clientId = "48ba55a6-4548-452f-b098-13ba9cacbc29" # App id
$appDisplayname = "Test-MI"
Grant-PnPAzureADAppSitePermission -AppId $clientId -DisplayName $appDisplayname -Site $siteUrl -Permissions Read -Connection $connectionAdmin
Grant-PnPAzureADAppSitePermission -AppId $clientId -DisplayName $appDisplayname -Site $siteUrl -Permissions Write -Connection $connectionAdmin

$permissions = Get-PnPAzureADAppSitePermission -Site $siteUrl 
$permissions.Id

Revoke-PnPAzureADAppSitePermission -Site $siteUrl -PermissionId $permissions.Id





