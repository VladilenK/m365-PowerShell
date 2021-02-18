$siteConnection = Connect-PnPOnlineAuto -Url $Url 
$siteConnection.Url

$site = Get-PnPSite -Connection $siteConnection; $site.Url
$web = Get-PnPWeb -Connection $siteConnection -includes IsHomepageModernized, WebTemplate, WelcomePage
$web.IsHomepageModernized
$web.WebTemplate
$web.WelcomePage


$list = Get-PnPList "Site Pages" -Includes ContentTypes, Fields
$list.BaseTemplate
$list.BaseType
$list.ContentTypes | ft -a
$list.Fields

$listContentTypes = Get-PnPContentType -List $list -Connection $siteConnection
$cType = $listContentTypes[3]; $cType
Get-PnPProperty -ClientObject $listContentTypes[3] -Connection $siteConnection -Property Description
Get-PnPProperty -ClientObject $listContentTypes[3] -Connection $siteConnection -Property Fields
Get-PnPProperty -ClientObject $listContentTypes[3] -Connection $siteConnection -Property Id
Get-PnPProperty -ClientObject $listContentTypes[3] -Connection $siteConnection -Property Name

$cType = Get-PnPContentType -List $list -Connection $siteConnection | ? { $_.Name -eq 'Site Page' };
$cType.id
$queryString = "<View><Query><Where><Eq><FieldRef Name='ContentTypeId'/><Value Type='Text'>" + $cType.Id.StringValue + "</Value></Eq></Where></Query></View>"  
#Get-PnPListItem -List $list -Query "<View><Query><Where><Eq><FieldRef Name='ContentTypeId'/><Value Type='Text'>0x0101009D1CB255DA76424F860D91F20E6C411800E53BD99D3E0D8545813DF21536D1B228</Value></Eq></Where></Query></View>"  
$modernPages = Get-PnPListItem -List $list -Query $queryString
$modernPages.count
$modernPages | ft -a


$items = Get-PnPListItem -List "SitePages" -Fields ID, Title, DisplayName, BannerImageUrl, FileRef, ContentType -Connection $siteConnection 
$items.Count

$page = Get-PnPListItem -Connection $siteConnection -List "SitePages" -Id 2 -Fields ID, Title, DisplayName, FileRef, Client_Title, FileSystemObjectType, CommentsDisabled, CommentsDisabledScope
$page.DisplayName
$page.Client_Title
#$page.FieldValues
$page.FileSystemObjectType
#$page.Properties
$page.BannerImageUrl
$page.CommentsDisabled
$page.CommentsDisabledScope
$page["ContentType"]
$page.ContentType # ?
$items[0].ContentType
$items[1].ContentType

Get-PnPContentType -List "SitePages"

$siteModernPages = @()
foreach ($modernPage in $items) {
    Write-Host $modernPage["Title"] -NoNewline
    if ($true) {
        $FileName = $ModernPage["FileLeafRef"]
        $PageUrl = "$($Site.SiteUrl)/SitePages/$FileName"
        $PageObject = [PSCustomObject]@{Site = $Site.SiteUrl; PageTitle = $ModernPage["Title"]; PageUrl = $PageUrl }
        $siteModernPages += $PageObject
        Write-Host "Modern Page Found.  Added to List" -ForegroundColor Green
    }
}
$SiteModernPages.count

$page = Get-PnPClientSidePage -Identity home.aspx
$page.Controls


return
$siteModernPages = @()
foreach ($modernPage in $items) {
    Write-Host "." -NoNewline
    Write-Host $modernPage | ft -a ID, Title, BannerImageUrl, FileRef
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

