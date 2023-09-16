$connection

$siteurl = "https://s5dz3.sharepoint.com/teams/Team-SO-A"
Get-PnPTenantSite -Connection $connection -Identity $siteurl   | ft -a Url, LockState
Set-PnPTenantSite -Connection $connection -Identity $siteurl -LockState ReadOnly
Get-PnPTenantSite -Connection $connection -Identity $siteurl   | ft -a Url, LockState
Set-PnPTenantSite -Connection $connection -Identity $siteurl -LockState Unlock

$siteurl = "https://s5dz3.sharepoint.com/teams/Team-SO-B"
Get-PnPTenantSite -Connection $connection -Identity $siteurl   | ft -a Url, LockState
Set-PnPTenantSite -Connection $connection -Identity $siteurl -LockState NoAccess
Get-PnPTenantSite -Connection $connection -Identity $siteurl   | ft -a Url, LockState


