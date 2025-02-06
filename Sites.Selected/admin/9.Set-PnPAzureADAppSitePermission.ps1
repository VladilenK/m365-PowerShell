


$appId = "cb06d91c-33c7-408d-b5e2-4b60c33f2c7e" # KBA-ACS-App-01
$app = Get-PnPAzureADApp -Identity $appId
$appDisplayname = $app.DisplayName
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-01"
Grant-PnPAzureADAppSitePermission -AppId $appId -DisplayName $appDisplayname -Site $siteUrl -Permissions Read 

