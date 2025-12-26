$sites = Get-PnPTenantSite -Detailed -Connection $connectionAdmin
$sites.count
$sites | ? { $_.Url -like "*bird*" }
$sites | ? { $_.Url -like "*test*" }

$adminUrl = "https://$orgname-admin.sharepoint.com"
$connectionAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection
$connectionAdmin.Url

$siteUrl = ""                # SiteCustomSubject: Test5 Test10; SiteSearchClassification: Included
$siteUrl = "https://$orgname.sharepoint.com/sites/TestCommSite_02"       # SiteCustomSubject: Test5,Test10; SiteSearchClassification: <not set>
$siteUrl = "https://$orgname.sharepoint.com/sites/TestCommSite_01"       # SiteCustomSubject: Test5;Test10; SiteSearchClassification: <not set>
$siteUrl = "https://$orgname.sharepoint.com/teams/TestTeam_03"           # SiteCustomSubject: Test10 Test5; SiteSearchClassification: Excluded
$siteUrl = "https://$orgname.sharepoint.com/sites/Birding_in_the_US"     # SiteCustomSubject: Birding; SiteSearchClassification: Included
$siteUrl = "https://$orgname.sharepoint.com/sites/Birding_in_KZ"         # SiteCustomSubject: Birding; SiteSearchClassification: Included
$siteUrl = "https://$orgname.sharepoint.com/teams/AboutBirdwatching"     # SiteCustomSubject: Birding; SiteSearchClassification: Official
$siteUrl = "https://$orgname.sharepoint.com/sites/Test-Official-Site-01" # SiteCustomSubject: News; SiteSearchClassification: Official
$siteUrl = "https://$orgname.sharepoint.com/teams/Test01"                # SiteCustomSubject: Test5 Test10; SiteSearchClassification: Included
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Retention-001"    # SiteCustomSubject: TestRetention; SiteSearchClassification: Included
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Parallel-1500"    # SiteCustomSubject: TestRetention; SiteSearchClassification: Included
$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection; $connectionSite.Url
Get-PnPPropertyBag -Connection $connectionSite -Key "SiteSearchClassification" # RefinableString08 aka SiteSearchClassification
Get-PnPPropertyBag -Connection $connectionSite -Key "SiteCustomSubject" # RefinableString09 aka SiteCustomSubject

$tenantSite = Get-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -Detailed
$tenantSite | Select-Object Url, Title, DenyAddAndCustomizePages
Set-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -DenyAddAndCustomizePages:$false
Set-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -DenyAddAndCustomizePages:$true

Get-pnpsite -Connection $connectionSite
Set-PnPAdaptiveScopeProperty -Key "IsOfficial" -Value "No" -Connection $connectionSite
Set-PnPAdaptiveScopeProperty -Key "SiteSearchClassification" -Value "Included" -Connection $connectionSite
Set-PnPAdaptiveScopeProperty -Key "SiteCustomSubject" -Value "TestRetention" -Connection $connectionSite
Request-PnPReIndexWeb -Connection $connectionSite 



# test User-level
Get-pnpsite -Connection $connection
Get-PnPPropertyBag -Key "SiteCustomSubject"  -Connection $connection # RefinableString09
Set-PnPAdaptiveScopeProperty -Key "SiteCustomSubject" -Value "Test Test4" -Connection $connection
Set-PnPPropertyBagValue -Key "SiteCustomSubject" -Value "Test10 Test5" -Indexed:$true -Connection $connection

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

Request-PnPReIndexWeb -Connection $connectionSite 

Get-PnPPropertyBag -Key "SiteCustomSubject"  -Connection $connectionSite # RefinableString09 aka SiteCustomSubject
Get-PnPPropertyBag -Key "IsOfficial"  -Connection $connectionSite # RefinableString35
Get-PnPPropertyBag -Key "SiteSearchClassification"  -Connection $connectionSite # RefinableString08


return

1..10 | ForEach-Object {
    $title = "Test-Retention-{0:000}" -f $_
    $siteUrl = "https://$orgname.sharepoint.com/teams/Test-Retention-{0:000}" -f $_
    $owner = "vladilen@$orgname.onmicrosoft.com"
    New-PnPTenantSite -Title $title -Url $siteurl -Owner $owner -Template "STS#3" -TimeZone "6" -Connection $connectionAdmin
}
1..10 | ForEach-Object {
    $title = "Test-Retention-{0:000} - Updated 2023-02-04" -f $_
    $siteUrl = "https://$orgname.sharepoint.com/teams/Test-Retention-{0:000}" -f $_
    Set-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -Title $title
}
1..10 | ForEach-Object {
    $siteUrl = "https://$orgname.sharepoint.com/teams/Test-Retention-{0:000}" -f $_
    Set-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -DenyAddAndCustomizePages:$false
    $connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection -WarningAction Ignore; $connectionSite.Url 
    # Set-PnPAdaptiveScopeProperty -Connection $connectionSite -Key "SiteCustomSubject" -Value "TestRetention" 
    Get-PnPPropertyBag -Connection $connectionSite -Key "SiteCustomSubject" 
    Request-PnPReIndexWeb -Connection $connectionSite 
}

##########################
# Static vs Adaptive tests
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-retention-01"  
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-retention-02"  
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-retention-03"  
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-retention-04"  
$siteUrl = "https://$orgname.sharepoint.com/sites/Test-retention-05"  
$siteUrl = "https://$orgname.sharepoint.com/sites/Test-retention-06"  
$siteUrl = "https://$orgname.sharepoint.com/sites/Test-retention-07"  
$siteUrl = "https://$orgname.sharepoint.com/sites/Test-retention-08"  
$siteUrl = "https://$orgname.sharepoint.com/sites/Test-retention-09"  
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-retention-10"  
$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection; $connectionSite.Url
Get-PnPPropertyBag -Connection $connectionSite -Key "SiteCustomSubject" # RefinableString09 aka SiteCustomSubject
Add-PnPFile -Connection $connectionSite -Path "C:\Users\Vlad\Documents\Test\Test-01.docx" -Folder "Shared Documents"
Add-PnPFile -Connection $connectionSite -Path "C:\Users\Vlad\Documents\Test\Test-01.xlsx" -Folder "Shared Documents"

Request-PnPReIndexWeb -Connection $connectionSite 
Set-PnPAdaptiveScopeProperty -Key "SiteCustomSubject" -Value "Ret6d" -Connection $connectionSite




