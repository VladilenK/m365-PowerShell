# tested with PowerShell 5.1, PnP.PowerShell 1.9 and 
# 16.0.21909.12000 Microsoft.Online.SharePoint.PowerShell 

$odSites = Import-Csv -Path "c:\temp\od-sites.csv"
$odsites.count

$pnpAdminConnection = Connect-PnPOnline -Interactive -ClientId $clientid -ReturnConnection -Url $adminUrl
$pnpAdminConnection.Url

$supportGroupLogin = "c:0t.c|tenant|169fcebc-209a-44a3-ba31-a3e4a1fc3ed9"
$everyoneLogin = "c:0-.f|rolemanager|spo-grid-all-users/046d11d6-08e0-4d20-a743-562836cdcab5"

Connect-SPOService -Url $adminUrl 
Get-SPOSite -Identity $adminUrl

foreach ($odsite in $odsites) {
    Set-SPOUser -LoginName $supportGroupLogin -Site $odsite.Url -IsSiteCollectionAdmin:$true
    Remove-SPOUser -Site $odsite.Url -LoginName $everyoneLogin 
    Remove-SPOUser -Site $odsite.Url -LoginName $supportGroupLogin
}


return

$odsiteUrl = ""
Set-SPOUser -LoginName $supportGroupLogin -Site $odsiteUrl -IsSiteCollectionAdmin:$true
Remove-SPOUser -Site $odsiteUrl -LoginName $everyoneLogin 
Remove-SPOUser -Site $odsiteUrl -LoginName $supportGroupLogin


Get-SPOUser -Site $odsiteUrl 
Get-SPOSite -Identity $odsiteUrl | select Owner
Set-SPOSite -Owner $adminUPN -Identity $odsiteUrl

Set-PnPTenantSite -Identity $odsiteUrl -Owners $supportGroupLogin
Get-PnPTenantSite -Identity $odsiteUrl | select Owner




