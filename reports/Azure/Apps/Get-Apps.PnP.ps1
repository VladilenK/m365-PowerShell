$appId = "199e7a72-cd35-4e4a-b4c5-5dfd00a245b7"

$app = Get-PnPAzureADApp -Identity $appId
$app | Format-List
$permissions = Get-PnPAzureADAppPermission -Identity $appId
$permissions | Format-List



