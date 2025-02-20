# not finished yet


$headers | ft -a

# https://manage.office.com/api/v1.0/{tenant_id}/activity/feed/{operation}

#################################
# Audit logs
$operationPath = "subscriptions/start?contentType=Audit.SharePoint&PublisherIdentifier=$tenantId"

$apiUrl = "https://manage.office.com/api/v1.0/$tenantId/activity/feed/$operationPath"

$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Post

$Data.value | Format-List
$timestamp = Get-Date -Format "yyyy-MM-dd--HH-mm"
$Data.value | Export-Csv -Path "T:\code\PS\.data\ACS-audit\$reportPath-$timestamp.csv"



$Data.value | Format-List | clip
$Data.value[0] | Format-List 
$Data.value[-1] | Format-List 

