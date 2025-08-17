# get all apss and permissions

$apps = Get-MgApplication -All
$apps.count

$allAppsRoles = @()
foreach ($app in $apps) {
    $spn = Get-MgServicePrincipalByAppId -AppId $app.AppId -ErrorAction SilentlyContinue
    if ($spn) {
        $roles = Get-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $spn.Id 
        foreach ($role in $roles) {
            $allAppsRoles += $role
        }
    } else {
        Write-Host "Service Principal not found for AppId: $($app.DisplayName)"
    }
}

$allAppsRoles | fl
$allAppsRoles.count

$allAppsRoles | Export-Csv -Path "C:\Users\Vlad\Downloads\AppsRoles.csv" 





$appId = "199e7a72-cd35-4e4a-b4c5-5dfd00a245b7"
$app = Get-MgApplicationByAppId -AppId $appId
$app | fl

$spn = Get-MgServicePrincipalByAppId -AppId $appId
$spn | fl

$roles = Get-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $spn.Id 
$roles | fl






