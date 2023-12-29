# getting NEW SharePoint sites with PnP.PowerShell
$connAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $ClientId -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection 

$tenantSites = Get-PnPTenantSite -Connection $connAdmin

$tenantSites.Count
$tenantSite = $tenantSites | Select-Object -First 1 -Skip 1000
$tenantSite
$tenantSite | gm | ?{$_ -like "*date*"}

$tenantSite = Get-PnPTenantSite -Detailed -Identity $tenantSite.Url -Connection $connAdmin

$connSite = Connect-PnPOnline -Url $tenantSite.Url -ClientId $ClientId -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection 
$connSite.Url

$site = Get-PnPSite -Connection $connSite
$site
$site | gm | ?{$_ -like "*date*"}

$site
$site = Get-PnPSite -Connection $connSite -Includes RootWeb
$site.RootWeb.Created

Measure-Command {
    $tenantSites | Get-Random -Count 10 | %{ 
        $connSite = Connect-PnPOnline -Url $tenantSite.Url -ClientId $ClientId -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection;
        $site = Get-PnPSite -Connection $connSite -Includes RootWeb
    }
}

(2*5000/10)/60






