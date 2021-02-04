# WIP: Work in Progress

$adminConnection = Connect-PnPOnline -Url $adminUrl -ClientId $clientID -Certificate $x509Cert -Tenant $tenant  -Verbose 
$sites = Get-PnPTenantSite -Connection $adminConnection 
$sites.count

$pagesReport = @()
foreach ($siteUrl in $sites.Url) {
    $siteConnection = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -Certificate $x509Cert -Tenant $tenant -ReturnConnection
    $site = Get-PnPSite -Connection $siteConnection
    #$site.Url 
    $webs = Get-PnPSubWebs -Connection $siteConnection -IncludeRootWeb
    foreach ($web in $webs) {
        $sitePagesList = Get-PnPList -Connection $siteConnection -Identity "SitePages"
        $pages = Get-PnPListItem -Connection $siteConnection -List $sitePagesList
        Write-Host "Web Url:" $web.Url
        Write-Host " pages:" $pages.count
        # $batch = New-PnPBatch -Connection $siteConnection
        # $pages | ForEach-Object { Set-PnPListItem -Connection $siteConnection -List $sitePagesList -Identity $_.Id -Batch $batch -Values @{"CommentsDisabled" = $true } }
        # Invoke-PnPBatch -Batch $batch
        foreach ($pageId in $pages.Id) {
            $page = Get-PnPListItem -Connection $siteConnection -List $sitePagesList -Id $pageId -Fields ID, Title, DisplayName, BannerImageUrl, FileRef, CommentsDisabled, CommentsDisabledScope
            $pageFileName = $page["FileLeafRef"]
            $PageUrl = "$($siteUrl)/SitePages/$pageFileName"
            $pageObject = [PSCustomObject]@{
                Site                  = $siteUrl; 
                Web                   = $web.Url; 
                PageUrl               = $PageUrl;
                PageTitle             = $page["Title"]; 
                CommentsDisabled      = $page.CommentsDisabled;
                CommentsDisabledScope = $page.CommentsDisabledScope
            }
            $pagesReport += $pageObject
        }
    }
}
#$pagesReport | Select-Object -last 3 | fl
$pagesReport | Select-Object -last 16 | ft -a PageUrl, PageTitle, CommentsDisabled


Connect-PnPOnline -Url $adminUrl -ClientId $clientID -Certificate $x509Cert -Tenant $tenant  -Verbose 

$sites = Get-PnPTenantSite 
$sites.count

$url = "https://uhgdev.sharepoint.com/teams/AboutBirdwatching"
$siteConnection = Connect-PnPOnline -Url $Url -ClientId $clientID -Certificate $x509Cert -Tenant $tenant -ReturnConnection

Get-PnPListItem -List "Site Pages" -Query "<View><Query><Where><Eq><FieldRef Name='ContentTypeId'/><Value Type='Text'>0x0101009D1CB255DA76424F860D91F20E6C411800E53BD99D3E0D8545813DF21536D1B228</Value></Eq></Where></Query></View>"  

$items = Get-PnPListItem -List "SitePages" -Fields ID, Title, BannerImageUrl, FileRef
$siteModernPages = @()
foreach ($modernPage in $items) {
    Write-Host "." -NoNewline
    if ($modernPage["BannerImageUrl"].Url -ne $null) {
        Write-Host “.” -NoNewline
        $FileName = $ModernPage[“FileLeafRef”]
        $PageUrl = “$($Site.SiteUrl)/SitePages/$FileName”
        $PageObject = [PSCustomObject]@{Site = $Site.SiteUrl; PageTitle = $ModernPage[“Title”]; PageUrl = $PageUrl }
        $siteModernPages += $PageObject
        Write-Host “Modern Page Found.  Added to List” -ForegroundColor Green
    }
}
$SiteModernPages.count

$page = Get-PnPClientSidePage -Identity home.aspx
$pag }
}
$SiteModernPages.count

$page = Get-PnPClientSidePage -Identity home.aspx
$pag e
e
$SiteModernPages.count

$page = Get-PnPClientSidePage -Identity home.aspx
$page.Controls.Controls.Controls
