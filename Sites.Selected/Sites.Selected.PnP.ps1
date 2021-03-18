$adminConnection = Connect-PnPOnline -Url $adminUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenantName -Verbose -ReturnConnection
$adminConnection.Url

$clientPermission = Get-PnPAzureADAppSitePermission -Site $sitePath -Connection $adminConnection
$clientPermission

$clientPermission = Grant-PnPAzureADAppSitePermission -AppId $clientAppId -DisplayName "Test-App" -Permissions "Read" -Site $sitePath -Connection $adminConnection
$clientPermission = Grant-PnPAzureADAppSitePermission -AppId $clientAppId -DisplayName "Test-App" -Permissions "Write" -Site $sitePath -Connection $adminConnection
$clientPermission

Set-PnPAzureADAppSitePermission -PermissionId $clientPermission.Id -Permissions "Write" -Connection $adminConnection
Revoke-PnPAzureADAppSitePermission -Connection $adminConnection -Site $sitePath -PermissionId $clientPermission.Id

$clientConnection = Connect-PnPOnline -Url $sitePath -ClientId $clientAppId -CertificateBase64Encoded $secretPlainText -Tenant $tenantName  -Verbose -ReturnConnection
$clientConnection.Url
Get-PnPTenantSite -Connection $clientConnection
Get-PnPSite -Connection $clientConnection 
Get-PnPList -Connection $clientConnection 




