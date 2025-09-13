
$siteUrl = "https://$orgName.sharepoint.com/teams/TestAlerts"

# admin connection:
Connect-PnPOnline -ClientId $ClientId -Thumbprint $thumbprint -Tenant $tenantId -Url $siteUrl

# user connection (app registration with delegated permissions must be specified as $clientIdDlg):
Connect-PnPOnline -Url $siteUrl -Interactive -ClientId $clientIdDlg


Get-PnPAlert -AllUsers

$allSitesAlerts = @()

foreach($site in $sites) {
    Write-Host "Processing site: $($site.Url)" -ForegroundColor Yellow
    try {
        $siteConnection = Connect-PnPOnline -Url $site.Url -ClientId $ClientId -Thumbprint $thumbprint -Tenant $tenantId -ReturnConnection
        $siteAlerts = Get-PnPAlert -AllUsers -Connection $siteConnection
        foreach($alert in $siteAlerts) {
            $alertInfo = [PSCustomObject]@{
                SiteUrl       = $site.Url
                AlertTitle    = $alert.Title
                AlertUser     = $alert.User.DisplayName
                AlertFrequency = $alert.AlertFrequency
                AlertType    = $alert.AlertType
                LastModified  = $alert.LastModified
            }
            $allSitesAlerts += $alertInfo
        }
    } catch {
        Write-Host "Failed to process site: $($site.Url). Error: $_" -ForegroundColor Red
    }
}

Write-Host "Total alerts found across all sites: $($allSitesAlerts.Count)" -ForegroundColor Green
$allSitesAlerts | Export-Csv -Path "AllSitesAlertsReport.csv" 




