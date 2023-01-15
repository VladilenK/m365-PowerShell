$loginUPN = "GlAdmin@uhgdev.onmicrosoft.com"
$loginUPN = "Vladilen@uhgdev.onmicrosoft.com"
Connect-ExchangeOnline -UserPrincipalName $loginUpn
Get-AdminAuditLogConfig | FL UnifiedAuditLogIngestionEnabled

Get-OwnerlessGroupPolicy 




