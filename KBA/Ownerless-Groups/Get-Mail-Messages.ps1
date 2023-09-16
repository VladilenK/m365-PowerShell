# authentication with App
#  app must have as minimum "..." Microsoft Graph API application permission
Connect-MgGraph -ClientId $clientid -TenantId $tenantId -CertificateThumbprint $CertThumbprint
Get-MgContext

$userId = "robert.dylan@uhgdev.onmicrosoft.com"
Get-MgUserMessageCount -userId $userId

$messages = Get-MgUserMessage  -userId $userId -All
$messages.count



