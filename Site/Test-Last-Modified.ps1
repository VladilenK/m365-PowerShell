# research on Site Last Modified Date
$connAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $clientID -Tenant $tenantId -Thumbprint $certThumbprint -ReturnConnection
$connAdmin.Url

# create sites
1..12 | ForEach-Object {
    $title = "Test Last Modified Date {0:000}" -f $_
    $Url = "https://uhgdev.sharepoint.com/sites/Test-LastModDate-{0:000}" -f $_
    New-PnPTenantSite -Title $title -Url $url -Owner $adminUPN -Template "STS#3" -TimeZone "6" -Connection $connAdmin
}

$siteUrl = "https://uhgdev.sharepoint.com/sites/Test-LastModDate-001"
$siteUrl = "https://uhgdev.sharepoint.com/teams/test-ownerless-group-611"
$tSite = Get-PnPTenantSite -Identity $siteUrl -Connection $connAdmin
$tSite.LastContentModifiedDate.ToLocalTime().DateTime 

$connSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -Tenant $tenantId -Thumbprint $certThumbprint -ReturnConnection
$site = Get-PnPSite -Connection $connSite -Include rootweb, id
$site.RootWeb.LastItemModifiedDate
$site.RootWeb.LastItemUserModifiedDate
$site.Id

# group
$m365group = Get-PnPMicrosoft365Group -Connection $connAdmin -Identity $tSite.GroupId
$m365group.RenewedDateTime.ToLocalTime().DateTime

# graph Site
$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $tenantDomain + ':/' + $sitePath + '?$select=id,displayName'
$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $site.Id.Guid
$gSite = Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)" } -Uri  $apiUrl -Method Get 


$tSites = Get-PnPTenantSite -Connection $connAdmin -Detailed -Filter "Url -like 'https://uhgdev.sharepoint.com/sites/Test-LastModDate'"
$tSites += Get-PnPTenantSite -Connection $connAdmin -Detailed -Identity "https://uhgdev.sharepoint.com/teams/Test-ownerless-team-51"
$tSites += Get-PnPTenantSite -Connection $connAdmin -Detailed -Identity "https://uhgdev.sharepoint.com/teams/test-ownerless-group-605"
$tSites += Get-PnPTenantSite -Connection $connAdmin -Detailed -Identity "https://uhgdev.sharepoint.com/teams/test-ownerless-group-608"
$tsites.count

$report = @()
foreach ($tsite in $tSites) {
    $connSite = Connect-PnPOnline -Url $tsite.Url -ClientId $clientID -Tenant $tenantId -Thumbprint $certThumbprint -ReturnConnection
    $site = Get-PnPSite -Connection $connSite -Include rootweb, Id
    $apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $site.Id.Guid
    $gSite = Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)" } -Uri  $apiUrl -Method Get 
    $report += [PSCustomObject]@{
        SiteUrl                   = $tSite.Url.TrimStart('https://uhgdev.sharepoint.com/sites')
        LastContentModifiedDate   = $tSite.LastContentModifiedDate
        LastItemModifiedDate      = $site.RootWeb.LastItemModifiedDate
        LastItemUserModifiedDate  = $site.RootWeb.LastItemUserModifiedDate
        GraphLastModifiedDateTime = $gsite.lastModifiedDateTime
        GraphCreatedDateTime      = $gsite.createdDateTime
    }
}
$report 
$report | Export-Csv -Path "G:\My Drive\SharePoint\Sites-Last-Modified-Date-tmp.csv"

# update item by app
$siteUrl = "https://uhgdev.sharepoint.com/sites/Test-LastModDate-002"
$connSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -Tenant $tenant -Thumbprint $thumbprint -ReturnConnection
$site = Get-PnPSite -Connection $connSite -Include rootweb
Add-PnPFile -Connection $connSite -Path "C:\Users\Vlad\Documents\Test\Test-01.docx" -Folder "Shared Documents"

# update site custom property
$siteUrl = "https://uhgdev.sharepoint.com/sites/Test-LastModDate-003"
$site = Get-PnPSite -Connection $connSite -Include rootweb
Get-PnPPropertyBag -Connection $connSite -Key "SiteCustomSubject" # RefinableString09 aka SiteCustomSubject
Set-PnPAdaptiveScopeProperty -Key "SiteCustomSubject" -Value "TestLastModDate" -Connection $connSite
Request-PnPReIndexWeb -Connection $connSite 

# update site sensitivity label
$siteUrl = "https://uhgdev.sharepoint.com/sites/Test-LastModDate-005"
$SensLabelId = [GUID]("0f4b1e4f-9646-4748-b397-283325ce9f49") # Test Label 01
Get-PnPTenantSite -Connection $connAdmin -Identity $siteUrl | select url, SensitivityLabel
Set-PnPTenantSite -Connection $connAdmin -Identity $siteUrl -SensitivityLabel $SensLabelId

# update site admin
$siteUrl = "https://uhgdev.sharepoint.com/sites/Test-LastModDate-007"
Get-PnPTenantSite -Connection $connAdmin -Identity $siteUrl | select url, owner
Set-PnPTenantSite -Connection $connAdmin -Identity $siteUrl -Owners $userUPN

# update m365 group membership
$siteUrl = "https://uhgdev.sharepoint.com/sites/Test-LastModDate-009"
$siteUrl = "https://uhgdev.sharepoint.com/teams/test-ownerless-group-605"
$tSite = Get-PnPTenantSite -Connection $connAdmin -Identity $siteUrl 
$m365group = Get-PnPMicrosoft365Group -Connection $connAdmin -Identity $tSite.GroupId
Get-PnPMicrosoft365GroupOwner -Connection $connAdmin -Identity $tSite.GroupId
Add-PnPMicrosoft365GroupOwner -Connection $connAdmin -Identity $tSite.GroupId -Users $userUPN
Get-PnPMicrosoft365GroupMember -Connection $connAdmin -Identity $tSite.GroupId
Remove-PnPMicrosoft365GroupMember -Connection $connAdmin -Identity $tSite.GroupId -Users $userUPN

