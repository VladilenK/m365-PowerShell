Connect-ExchangeOnline -UserPrincipalName $loginUpn
Get-AdminAuditLogConfig | FL UnifiedAuditLogIngestionEnabled

Get-OwnerlessGroupPolicy 




