$clientAppId = "6cea34ae-ee32-4283-882e-0b2618a8c3bb"
$siteUrl = "https://uhgdev.sharepoint.com/sites/spo-app-test-01"

$adminConnection = Connect-PnPOnline -Url $adminUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant  -Verbose -ReturnConnection
$adminConnection.Url

$clientPermission = Get-PnPAzureADAppSitePermission -Site $siteUrl -Connection $adminConnection
$clientPermission

$clientPermission = Grant-PnPAzureADAppSitePermission -AppId $clientAppId -DisplayName "Test-App" -Permissions "Read" -Site $siteUrl -Connection $adminConnection
$clientPermission = Grant-PnPAzureADAppSitePermission -AppId $clientAppId -DisplayName "Test-App" -Permissions @("Read","Write") -Site $siteUrl -Connection $adminConnection
$clientPermission

Set-PnPAzureADAppSitePermission -PermissionId $clientPermission.Id -Permissions "Write" -Connection $adminConnection
Revoke-PnPAzureADAppSitePermission -Connection $adminConnection -Site $siteUrl -PermissionId $clientPermission

$clientConnection = Connect-PnPOnline -Url $siteUrl -ClientId $clientAppId -CertificateBase64Encoded $secretPlainText -Tenant $tenant  -Verbose -ReturnConnection
$clientConnection.Url
Get-PnPSite -Connection $clientConnection 




