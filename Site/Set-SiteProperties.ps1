$sites = Get-PnPTenantSite -Detailed -Connection $connectionAdmin
$sites.count
$sites | ? { $_.Url -like "*bird*" }
$sites | ? { $_.Url -like "*test*" }

$adminUrl = "https://uhgdev-admin.sharepoint.com"
$connectionAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection
$connectionAdmin.Url


$siteUrl = "https://uhgdev.sharepoint.com/sites/Birding_in_KZ"
$siteUrl = "https://uhgdev.sharepoint.com/sites/Birding_in_the_US"
$siteUrl = "https://uhgdev.sharepoint.com/teams/TestTeam_03"
$siteUrl = "https://uhgdev.sharepoint.com/teams/Test01"
$siteUrl = "https://uhgdev.sharepoint.com/sites/TestCommSite_01"
$siteUrl = "https://uhgdev.sharepoint.com/sites/Test-Official-Site-01"
$siteUrl = "https://uhgdev.sharepoint.com/teams/AboutBirdwatching"
$siteUrl = "https://uhgdev.sharepoint.com/sites/TestCommSite_02"
$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection
Get-PnPPropertyBag -Key "SiteCustomSubject"  -Connection $connectionSite # RefinableString09 aka SiteCustomSubject
$connectionSite.Url

$tenantSite = Get-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -Detailed
$tenantSite
Set-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -DenyAddAndCustomizePages:$false
Set-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -DenyAddAndCustomizePages:$true

Get-pnpsite -Connection $connectionSite
Get-PnPPropertyBag -Key "SiteCustomSubject"  -Connection $connectionSite # RefinableString09 aka SiteCustomSubject
Get-PnPPropertyBag -Key "IsOfficial"  -Connection $connectionSite # RefinableString35
Get-PnPPropertyBag -Key "SiteSearchClassification"  -Connection $connectionSite # RefinableString08

Set-PnPPropertyBagValue -Key "SiteCustomSubject" -Value "Birding" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "SiteCustomSubject" -Value "News" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "SiteCustomSubject" -Value "Test Test5 Test10" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "IsOfficial" -Value "Yes" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "IsOfficial" -Value "True" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "IsOfficial" -Value "No" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "IsOfficial" -Value "False" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "SiteSearchClassification" -Value "Official" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "SiteSearchClassification" -Value "Included" -Indexed:$true -Connection $connectionSite
Set-PnPPropertyBagValue -Key "SiteSearchClassification" -Value "Excluded" -Indexed:$true -Connection $connectionSite

$connectionSite.Url
Set-PnPAdaptiveScopeProperty -Key "IsOfficial" -Value "Yes" -Connection $connectionSite
Set-PnPAdaptiveScopeProperty -Key "SiteCustomSubject" -Value "Test5;Test10" -Connection $connectionSite
Set-PnPAdaptiveScopeProperty -Key "SiteCustomSubject" -Value "Test5,Test10" -Connection $connectionSite

Request-PnPReIndexWeb -Connection $connectionSite 


# test User-level
Get-pnpsite -Connection $connection
Get-PnPPropertyBag -Key "SiteCustomSubject"  -Connection $connection # RefinableString09
Set-PnPAdaptiveScopeProperty -Key "SiteCustomSubject" -Value "Test Test4" -Connection $connection
Set-PnPPropertyBagValue -Key "SiteCustomSubject" -Value "Test10 Test5" -Indexed:$true -Connection $connection
 


