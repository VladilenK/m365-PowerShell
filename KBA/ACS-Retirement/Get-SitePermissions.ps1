$apiUrl = "https://graph.microsoft.com/v1.0/sites/root/permissions"
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$orgname.sharepoint.com:/sites/KBA-ACS-Site-02"

$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Data | Format-List

$siteId = "364ce920-b5e4-4421-b687-32a68846bdb8" # 02
$siteId = "c22cc5b4-e87c-45b5-b485-d3408856b0cf" # 01
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$siteId/permissions"
$apiUrl = "https://graph.microsoft.com/beta/sites/$siteId/permissions"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Data.value | Format-List

$Data.value[0].grantedToIdentities | Format-List 
$Data.value[0].grantedToIdentitiesV2 | Format-List 

