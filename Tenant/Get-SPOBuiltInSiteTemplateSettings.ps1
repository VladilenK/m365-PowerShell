$adminUrl = "https://uhgdev-admin.sharepoint.com"
"GlAdmin@uhgdev.onmicrosoft.com" | clip
Connect-SPOService -Url $adminUrl 
Get-SPOSite -Limit 3


Get-SPOBuiltInSiteTemplateSettings 
Set-SPOBuiltInSiteTemplateSettings -Identity 'b8ef3134-92a2-4c9d-bca6-c2f14e79fe98' -IsHidden $true # Learning central
Set-SPOBuiltInSiteTemplateSettings -Identity '73495f08-0140-499b-8927-dd26a546f26a' -IsHidden $true # Department	

Set-SPOBuiltInSiteTemplateSettings -Identity '00000000-0000-0000-0000-000000000000' -IsHidden $true # all

Set-SPOBuiltInDesignPackageVisibility -DesignPackage Showcase -IsVisible:$false

Get-PnPSiteDesign

$siteUrl = "https://uhgdev.sharepoint.com/sites/Birding_in_KZ"
$site = Get-SPOSite $siteUrl
$site.Template



