

$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Broken-Team-Site"

Get-PnPDeletedTeam -Connection $connectionAdmin

Get-PnPTenantDeletedSite -Connection $connectionAdmin | ft SiiteId, Url, Title, DeletionTime, DaysRemaining

$siteUrl = "https://s5dz3.sharepoint.com/teams/My_Test_Team-My_Private_Channel"
Restore-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin
