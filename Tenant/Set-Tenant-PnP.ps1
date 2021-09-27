Get-PnPTenant | select DisableCustomAppAuthentication, CommentsOnSitePagesDisabled | fl

$tenant = Get-PnPTenant 
$tenant.DisableCustomAppAuthentication

#################
Set-PnPTenant -CommentsOnSitePagesDisabled $true
Set-PnPTenant -CommentsOnSitePagesDisabled $false